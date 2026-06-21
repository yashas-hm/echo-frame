part of 'buttons.dart';

class EFSuccessButton extends StatelessWidget {
  const EFSuccessButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
  }) : filled = true;

  const EFSuccessButton.flat({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
  }) : filled = false;

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
      color: filled ? colors.successSurface : KnownColors.transparent,
      child: InkWell(
        onTap: onPressed,
        mouseCursor: SystemMouseCursors.click,
        hoverColor: filled
            ? colors.onSuccessPrimary.hover
            : colors.successPrimary.hover,
        splashColor: colors.successPrimary.splash,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.spacingExtraExtraSmall,
            horizontal: Sizes.spacingRegular,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.maxFinite),
            border: filled
                ? Border.all(color: colors.successPrimary, width: 1)
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
                  color:
                      filled ? colors.onSuccessPrimary : colors.successPrimary,
                ),
              Text(
                text,
                style: Styles.button(
                  color:
                      filled ? colors.onSuccessPrimary : colors.successPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
