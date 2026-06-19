part of '../import_screen.dart';

class DoneView extends StatelessWidget {
  const DoneView(this.state, {super.key});

  final ImportState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final allErrors = [
      ...?state.plan?.errors,
      ...state.applyErrors,
    ];

    return Center(
      child: SizedBox(
        width: 480,
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
                onPressed: context.pop,
                text: 'Sort Complete',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
