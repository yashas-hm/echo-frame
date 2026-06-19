part of 'buttons.dart';

class EFBackButton extends StatelessWidget {
  const EFBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        margin: EdgeInsets.all(Sizes.spacingRegular),
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          customBorder: const CircleBorder(),
          hoverColor: context.colors.textPrimary.hover,
          splashColor: context.colors.textPrimary.splash,
          onTap: context.pop,
          child: Padding(
            padding: EdgeInsets.all(Sizes.iconPadding),
            child: Icon(
              Icons.arrow_back_rounded,
              color: context.colors.textPrimary,
              size: Sizes.iconSizeRegular,
            ),
          ),
        ),
      ),
    );
  }
}
