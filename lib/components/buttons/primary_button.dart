part of 'buttons.dart';

class EFPrimaryButton extends StatelessWidget {
  const EFPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.disabled = false,
  }) : filled = true;

  const EFPrimaryButton.flat({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.disabled = false,
  }) : filled = false;

  final VoidCallback onPressed;
  final bool disabled;
  final bool filled;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      borderRadius: BorderRadius.circular(Sizes.maxFinite),
      clipBehavior: Clip.antiAlias,
      color: disabled
          ? colors.surfacePrimary
          : filled
              ? colors.primarySurface
              : KnownColors.transparent,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        mouseCursor: SystemMouseCursors.click,
        hoverColor: disabled
            ? KnownColors.transparent
            : filled
                ? colors.onPrimary.hover
                : colors.primaryColor.hover,
        splashColor: colors.primaryColor.splash,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.spacingExtraExtraSmall,
            horizontal: Sizes.spacingMedium,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.maxFinite),
            border: filled && !disabled
                ? Border.all(color: colors.primaryColor, width: 1)
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: Sizes.spacingExtraSmall,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: Sizes.iconSizeExtraSmall,
                  color: disabled
                      ? colors.textSecondary
                      : filled
                          ? colors.onPrimary
                          : colors.onPrimary,
                ),
              Text(
                text,
                style: Styles.button(
                  color: disabled
                      ? colors.textSecondary
                      : filled
                          ? colors.onPrimary
                          : colors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
