part of 'buttons.dart';

class EFErrorButton extends StatelessWidget {
  const EFErrorButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.filled = false,
  });

  final bool filled;
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      borderRadius: BorderRadius.circular(Sizes.maxFinite),
      clipBehavior: Clip.antiAlias,
      color: filled ? colors.errorSurface : KnownColors.transparent,
      child: InkWell(
        onTap: onPressed,
        mouseCursor: SystemMouseCursors.click,
        hoverColor:
            filled ? colors.onErrorPrimary.hover : colors.errorPrimary.hover,
        splashColor: colors.errorPrimary.splash,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.spacingExtraExtraSmall,
            horizontal: Sizes.spacingRegular,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.maxFinite),
            border: filled
                ? Border.all(color: colors.errorPrimary, width: 1)
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
                  color: colors.onErrorPrimary,
                ),
              Text(
                text,
                style: filled
                    ? Styles.buttonBold(
                        color: colors.onErrorPrimary,
                      )
                    : Styles.button(
                        color: colors.onErrorPrimary,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
