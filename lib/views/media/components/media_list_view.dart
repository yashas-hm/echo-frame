import 'package:echo_frame/constants/constants.dart' show Sizes, Styles;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:echo_frame/views/media/components/photo_tile.dart';
import 'package:echo_frame/views/media/provider/favorites_provider.dart';
import 'package:echo_frame/views/media/provider/media_collection_notifier.dart';
import 'package:echo_frame/views/media/provider/timeline_provider.dart';
import 'package:echo_frame/views/media/provider/trash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show DateFormat;

class MediaListView extends ConsumerStatefulWidget {
  const MediaListView({
    super.key,
    required this.state,
    required this.source,
    this.searchEnabled = true,
  });

  final MediaCollectionState state;
  final MediaCollectionSource source;
  final bool searchEnabled;

  @override
  ConsumerState<MediaListView> createState() => _MediaListViewState();
}

class _MediaListViewState extends ConsumerState<MediaListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    final MediaCollectionNotifier provider = switch (widget.source) {
      MediaCollectionSource.timeline => ref.read(timelineProvider.notifier),
      MediaCollectionSource.favorites => ref.read(favoritesProvider.notifier),
      MediaCollectionSource.trash => ref.read(trashProvider.notifier),
    };
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        provider.loadNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        if (widget.searchEnabled)
          const SliverToBoxAdapter(
            child: SizedBox(
              height: Sizes.inputHeight + Sizes.edgePadding,
            ),
          ),
        for (final month in widget.state.byMonth) ...[
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.spacingMediumLarge,
              vertical: Sizes.spacingMedium,
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
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: month.items.length,
            itemBuilder: (_, i) => PhotoTile(
              item: month.items[i],
              source: widget.source,
            ),
          ),
        ],
        if (widget.state.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(Sizes.edgePadding),
              child: Center(
                child: SizedBox(
                  width: Sizes.spacingExtraLarge,
                  height: Sizes.spacingExtraLarge,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
