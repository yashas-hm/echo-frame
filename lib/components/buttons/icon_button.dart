part of 'buttons.dart';

class EFIconButton extends StatelessWidget {
  const EFIconButton({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  factory EFIconButton.back({VoidCallback? onPressed}) => EFIconButton(
        icon: Icons.arrow_back_rounded,
        onPressed: onPressed,
      );

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
            icon,
            color: context.colors.textPrimary,
            size: Sizes.iconSizeRegular,
          ),
        ),
      ),
    );
  }
}
