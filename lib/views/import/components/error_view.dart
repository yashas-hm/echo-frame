part of '../import_screen.dart';

class ErrorView extends ConsumerWidget {
  const ErrorView(this.state, this.type, {super.key});

  final ImportState state;
  final ImportType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(importProvider(type).notifier);
    final colors = context.colors;

    return Center(
      child: SizedBox(
        width: Sizes.viewBoxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: Sizes.iconSizeHuge,
              color: colors.errorPrimary,
            ),
            SpacerLarge(),
            Text(
              'Something went wrong',
              style: Styles.title(),
            ),
            SpacerSmallRegular(),
            Text(
              state.error ?? 'Unknown error',
              textAlign: TextAlign.center,
              style: Styles.smallRegular(color: colors.textSecondary),
            ),
            SpacerLarge(),
            EFErrorButton(
              onPressed: notifier.reset,
              filled: true,
              text: 'Start over',
            ),
          ],
        ),
      ),
    );
  }
}
