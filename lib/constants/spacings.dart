part of 'constants.dart';

class AutoSpacer extends StatelessWidget {
  const AutoSpacer(this.size, {super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final flex = context.findAncestorWidgetOfExactType<Flex>();
    final isHorizontal = flex?.direction == Axis.horizontal;
    return SizedBox(
      width: isHorizontal ? size : 0,
      height: isHorizontal ? 0 : size,
    );
  }
}

Widget spacerExtraSmall() => const AutoSpacer(Sizes.spacingExtraSmall);
Widget spacerSmall() => const AutoSpacer(Sizes.spacingSmall);
Widget spacerRegular() => const AutoSpacer(Sizes.spacingRegular);
Widget spacerMedium() => const AutoSpacer(Sizes.spacingMedium);
Widget spacerMediumLarge() => const AutoSpacer(Sizes.spacingMediumLarge);
Widget spacerLarge() => const AutoSpacer(Sizes.spacingLarge);
Widget spacerExtraLarge() => const AutoSpacer(Sizes.spacingExtraLarge);
Widget spacerExtraExtraLarge() => const AutoSpacer(Sizes.spacingExtraExtraLarge);
Widget spacerCustom(double value) => AutoSpacer(value);