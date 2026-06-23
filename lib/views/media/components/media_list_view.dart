import 'package:echo_frame/constants/constants.dart' show Sizes, Styles;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:echo_frame/views/media/components/photo_tile.dart';
import 'package:echo_frame/views/media/provider/media_collection_notifier.dart'
    show MediaCollectionState;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class MediaListView extends StatelessWidget {
  const MediaListView({
    super.key,
    required this.state,
    required this.scrollController,
  });

  final MediaCollectionState state;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: Sizes.inputHeight + Sizes.edgePadding,
          ),
        ),
        for (final month in state.byMonth) ...[
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
            itemBuilder: (_, i) => PhotoTile(item: month.items[i]),
          ),
        ],
        if (state.isLoadingMore)
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
