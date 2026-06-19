part of 'constants.dart';

class AutoSpacer extends StatelessWidget {
  const AutoSpacer(this.size, {super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    var isHorizontal = false;
    context.visitAncestorElements((element) {
      if (element.widget is Row) {
        isHorizontal = true;
        return false;
      }
      if (element.widget is Column) {
        return false;
      }
      return true;
    });
    return SizedBox(
      width: isHorizontal ? size : 0,
      height: isHorizontal ? 0 : size,
    );
  }
}

class SpacerExtraSmall extends AutoSpacer {
  const SpacerExtraSmall({super.key}) : super(Sizes.spacingExtraSmall);
}

class SpacerSmall extends AutoSpacer {
  const SpacerSmall({super.key}) : super(Sizes.spacingSmall);
}

class SpacerSmallRegular extends AutoSpacer {
  const SpacerSmallRegular({super.key}) : super(Sizes.spacingSmallRegular);
}

class SpacerRegular extends AutoSpacer {
  const SpacerRegular({super.key}) : super(Sizes.spacingRegular);
}

class SpacerMedium extends AutoSpacer {
  const SpacerMedium({super.key}) : super(Sizes.spacingMedium);
}

class SpacerMediumLarge extends AutoSpacer {
  const SpacerMediumLarge({super.key}) : super(Sizes.spacingMediumLarge);
}

class SpacerLarge extends AutoSpacer {
  const SpacerLarge({super.key}) : super(Sizes.spacingLarge);
}

class SpacerExtraLarge extends AutoSpacer {
  const SpacerExtraLarge({super.key}) : super(Sizes.spacingExtraLarge);
}

class SpacerExtraExtraLarge extends AutoSpacer {
  const SpacerExtraExtraLarge({super.key})
      : super(Sizes.spacingExtraExtraLarge);
}
