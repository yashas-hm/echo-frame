part of 'views.dart';

class FolderTreePreview extends StatelessWidget {
  const FolderTreePreview({super.key, required this.tree});

  final FolderTree tree;

  @override
  Widget build(BuildContext context) {
    if (tree.isEmpty) {
      return Center(
        child: Column(
          spacing: Sizes.spacingMedium,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_off_outlined,
              size: Sizes.iconSizeHuge,
              color: context.colors.borderPrimary,
            ),
            Text(
              'No media files to preview',
              style: Styles.smallRegular(color: context.colors.textSecondary),
            ),
          ],
        ),
      );
    }

    final years = tree.sortedYears;

    return ListView.builder(
      itemCount: years.length,
      itemBuilder: (_, i) {
        final year = years[i];
        final months = tree.sortedMonthsFor(year);
        final yearTotal = tree.yearTotal(year);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.folder_copy_rounded,
                  size: Sizes.iconSizeExtraSmall,
                  color: context.colors.primaryColor,
                ),
                const SpacerSmall(),
                Text(
                  '$year',
                  style: Styles.small(
                    color: context.colors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '$yearTotal',
                  style: Styles.micro(color: context.colors.textSecondary),
                ),
              ],
            ),
            for (final entry in months)
              Row(
                children: [
                  const SpacerExtraSmall(),
                  Icon(
                    Icons.subdirectory_arrow_right_rounded,
                    size: Sizes.iconSizeExtraSmall,
                    color: context.colors.primaryColor,
                  ),
                  const SpacerExtraSmall(),
                  Icon(
                    Icons.folder_rounded,
                    size: Sizes.iconSizeExtraSmall,
                    color: context.colors.primaryColor,
                  ),
                  const SpacerSmall(),
                  Text(
                    DateFormat('MMMM').format(DateTime(year, entry.key)),
                    style: Styles.small(color: context.colors.textPrimary),
                  ),
                  const Spacer(),
                  Text(
                    '${entry.value}',
                    style: Styles.micro(color: context.colors.textSecondary),
                  ),
                ],
              ),
            const SpacerSmallRegular(),
          ],
        );
      },
    );
  }
}
