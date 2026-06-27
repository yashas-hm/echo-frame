part of 'views.dart';

class DoneView extends ConsumerWidget {
  const DoneView(this.state, this.type, {super.key});

  final ImportState state;
  final ImportType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final allErrors = [
      ...?state.plan?.errors,
      ...state.applyErrors,
    ];

    return Center(
      child: SizedBox(
        width: Sizes.viewBoxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: Sizes.spacingRegular,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: Sizes.iconSizeLarge,
                  color: colors.successPrimary,
                ),
                Text(
                  '${state.applied} ${'photo'.plural(state.applied)} sorted',
                  style: Styles.title(color: colors.textPrimary),
                ),
              ],
            ),
            if (allErrors.isNotEmpty) ...[
              const SpacerMedium(),
              ErrorList(
                errors: allErrors,
              ),
            ],
            const SpacerExtraLarge(),
            Align(
              alignment: Alignment.centerRight,
              child: EFSuccessButton(
                onPressed: () {
                  ref.read(importProvider(type).notifier).reset();
                  context.pop();
                },
                text: 'Sort Complete',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
