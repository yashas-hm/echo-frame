part of 'buttons.dart';

class EFBackButton extends StatelessWidget {
  const EFBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Sizes.spacingRegular,
      left: Sizes.spacingRegular,
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        customBorder: const CircleBorder(),
        hoverColor: context.colors.textPrimary.hover,
        splashColor: context.colors.textPrimary.splash,
        onTap: onPressed ?? context.pop,
        child: Padding(
          padding: EdgeInsets.all(Sizes.iconPadding),
          child: Icon(
            Icons.arrow_back_rounded,
            color: context.colors.textPrimary,
            size: Sizes.iconSizeRegular,
          ),
        ),
      ),
    );
  }
}
