part of 'views.dart';

class ReviewView extends ConsumerWidget {
  const ReviewView(this.state, this.type, {super.key});

  final ImportState state;
  final ImportType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = state.plan!;
    final notifier = ref.read(importProvider(type).notifier);
    final total = plan.total;
    final colors = context.colors;

    return Container(
      padding: EdgeInsets.all(Sizes.edgePadding),
      child: Column(
        spacing: Sizes.spacingRegular,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.spacingSmall,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: Sizes.spacingRegular,
              children: [
                Icon(
                  Icons.create_new_folder_rounded,
                  size: Sizes.iconSizeRegular,
                  color: context.colors.primaryColor,
                ),
                total == 0
                    ? Text(
                        'No media files to review',
                        style: Styles.regular(
                          color: colors.textPrimary,
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          text: '$total ',
                          style: Styles.regularBold(color: colors.textPrimary),
                          children: [
                            TextSpan(
                              text:
                                  '${'photo'.plural(total)} will be sorted into your library',
                              style: Styles.regular(color: colors.textPrimary),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          if (plan.errors.isNotEmpty)
            ErrorList(
              errors: plan.errors,
            ),
          Container(
            margin: EdgeInsets.only(top: Sizes.spacingRegular),
            child: Text(
              'Sort preview',
              style: Styles.regularBold(color: colors.textPrimary),
            ),
          ),
          Expanded(
            child: FolderTreePreview(tree: plan.tree),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: Sizes.spacingRegular,
            children: [
              EFErrorButton(
                onPressed: notifier.reset,
                text: 'Cancel',
              ),
              EFPrimaryButton(
                disabled: total == 0,
                icon: Icons.drive_folder_upload_outlined,
                text: total == 0
                    ? 'No files to sort'
                    : 'Sort $total ${'Photo'.plural(total)}',
                onPressed: notifier.apply,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
