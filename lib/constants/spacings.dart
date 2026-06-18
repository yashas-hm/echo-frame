part of 'constants.dart';

class Spacing {
  Spacing._();

  static Widget extraSmallV() => const SizedBox(
        height: Sizes.spacingExtraSmall,
      );

  static Widget smallV() => const SizedBox(
        height: Sizes.spacingSmall,
      );

  static Widget regularV() => const SizedBox(
        height: Sizes.spacingRegular,
      );

  static Widget mediumV() => const SizedBox(
        height: Sizes.spacingMedium,
      );

  static Widget mediumLargeV() => const SizedBox(
        height: Sizes.spacingMediumLarge,
      );

  static Widget largeV() => const SizedBox(
        height: Sizes.spacingLarge,
      );

  static Widget extraLargeV() => const SizedBox(
        height: Sizes.spacingExtraLarge,
      );

  static Widget extraExtraLargeV() => const SizedBox(
        height: Sizes.spacingExtraExtraLarge,
      );

  static Widget extraSmallH() => const SizedBox(
        width: Sizes.spacingExtraSmall,
      );

  static Widget smallH() => const SizedBox(
        width: Sizes.spacingSmall,
      );

  static Widget regularH() => const SizedBox(
        width: Sizes.spacingRegular,
      );

  static Widget mediumH() => const SizedBox(
        width: Sizes.spacingMedium,
      );

  static Widget mediumLargeH() => const SizedBox(
        width: Sizes.spacingMediumLarge,
      );

  static Widget largeH() => const SizedBox(
        width: Sizes.spacingLarge,
      );

  static Widget extraLargeH() => const SizedBox(
        width: Sizes.spacingExtraLarge,
      );

  static Widget extraExtraLargeH() => const SizedBox(
        width: Sizes.spacingExtraExtraLarge,
      );

  static Widget customV(double value) => SizedBox(
        height: value,
      );

  static Widget customH(double value) => SizedBox(
        width: value,
      );
}
