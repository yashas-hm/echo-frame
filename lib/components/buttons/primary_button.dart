part of 'buttons.dart';

class EFPrimaryButton extends StatelessWidget {
  const EFPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.disabled = false,
  });

  final VoidCallback onPressed;
  final bool disabled;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      borderRadius: BorderRadius.circular(Sizes.maxFinite),
      clipBehavior: Clip.antiAlias,
      color: disabled ? colors.surfacePrimary : colors.primaryColor,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        mouseCursor: SystemMouseCursors.click,
        hoverColor: disabled ? KnownColors.transparent : colors.onPrimary.hover,
        splashColor: colors.onPrimary.splash,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.spacingExtraExtraSmall,
            horizontal: Sizes.spacingMedium,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: Sizes.spacingExtraSmall,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: Sizes.iconSizeExtraSmall,
                  color: disabled ? colors.textSecondary : colors.onPrimary,
                ),
              Text(
                text,
                style: Styles.button(
                  color: disabled ? colors.textSecondary : colors.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
