import 'package:echo_frame/constants/constants.dart'
    show Sizes, Styles, SpacerMedium;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:echo_frame/views/media/components/photo_tile.dart';
import 'package:echo_frame/views/media/components/timeline_scrubber.dart';
import 'package:echo_frame/views/media/favourites/favorites_screen.dart'
    show favoritesProvider;
import 'package:echo_frame/views/media/provider/media_collection_notifier.dart';
import 'package:echo_frame/views/media/timeline/timeline_screen.dart'
    show timelineProvider;
import 'package:echo_frame/views/media/trash/trash_screen.dart'
    show trashProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show DateFormat;

class MediaListView extends ConsumerStatefulWidget {
  const MediaListView({
    super.key,
    required this.state,
    required this.source,
  });

  final MediaCollectionState state;
  final MediaCollectionSource source;

  @override
  ConsumerState<MediaListView> createState() => _MediaListViewState();
}

class _MediaListViewState extends ConsumerState<MediaListView> {
  final _scrollController = ScrollController();
  late final MediaCollectionNotifier _provider;
  double _viewportWidth = 0;

  // Estimates the pixel offset of a given global item index by summing month
  // header heights and grid row heights above it.
  double _pixelOffsetOf(int globalIndex) {
    if (_viewportWidth == 0) return 0;
    const headerHeight = 52.0;
    const tileSize = 182.0; // 180px tile + 2px spacing
    final tilesPerRow = ((_viewportWidth + 2) / tileSize).floor().clamp(1, 999);
    var y = 0.0;
    for (final m in widget.state.monthCounts) {
      y += headerHeight;
      if (globalIndex <= m.globalOffset) break;
      final itemsAbove = (globalIndex - m.globalOffset).clamp(0, m.count);
      y += (itemsAbove / tilesPerRow).ceil() * tileSize;
      if (globalIndex < m.globalOffset + m.count) break;
    }
    return y;
  }

  double _loadedContentEnd() {
    final s = widget.state;
    if (s.lastPageIndex < 0) return 0;
    return _pixelOffsetOf((s.lastPageIndex + 1) * 100);
  }

  double _loadedContentStart() =>
      _pixelOffsetOf(widget.state.firstPageIndex * 100);

  @override
  void initState() {
    super.initState();
    _provider = switch (widget.source) {
      MediaCollectionSource.timeline => ref.read(timelineProvider.notifier),
      MediaCollectionSource.favorites => ref.read(favoritesProvider.notifier),
      MediaCollectionSource.trash => ref.read(trashProvider.notifier),
    };
    _scrollController.addListener(() {
      final pixels = _scrollController.position.pixels;
      if (pixels >= _loadedContentEnd() - 600) _provider.loadNextPage();
      if (pixels <= _loadedContentStart() + 300) _provider.loadPreviousPage();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  static const _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 180,
    crossAxisSpacing: 2,
    mainAxisSpacing: 2,
  );

  @override
  Widget build(BuildContext context) {
    _viewportWidth = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: Sizes.edgePadding),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Sizes.cardBorderRadius),
            ),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  for (final month in widget.state.monthCounts) ...[
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        bottom: Sizes.spacingRegular,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          DateFormat('MMMM yyyy')
                              .format(DateTime(month.year, month.month)),
                          style: Styles.subTitleBold(
                            color: context.colors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    SliverGrid.builder(
                      gridDelegate: _gridDelegate,
                      itemCount: month.count,
                      itemBuilder: (_, indexInMonth) {
                        final item = widget.state
                            .itemAt(month.globalOffset + indexInMonth);
                        return item != null
                            ? PhotoTile(item: item, source: widget.source)
                            : const PlaceholderTile();
                      },
                    ),
                    const SliverToBoxAdapter(
                      child: SpacerMedium(),
                    )
                  ],
                ],
              ),
            ),
          ),
        ),
        if (widget.state.monthCounts.length > 1)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: TimelineScrubber(
              monthCounts: widget.state.monthCounts,
              totalCount: widget.state.totalCount,
              scrollController: _scrollController,
              onJumpToPage: _provider.jumpToPage,
            ),
          ),
      ],
    );
  }
}
