import 'package:flutter/material.dart';
import 'package:echo_frame/constants/sizes.dart';

class InputFormSpacer extends StatelessWidget {
  const InputFormSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spacingInputForm,
      width: Sizes.spacingInputForm,
    );
  }
}

class RegularSpacer extends StatelessWidget {
  const RegularSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spacingRegular,
      width: Sizes.spacingRegular,
    );
  }
}

class LargeSpacer extends StatelessWidget {
  const LargeSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spacingLarge,
      width: Sizes.spacingLarge,
    );
  }
}

class ExtraLargeSpacer extends StatelessWidget {
  const ExtraLargeSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spacingExtraLarge,
      width: Sizes.spacingExtraLarge,
    );
  }
}

class MediumSpacer extends StatelessWidget {
  const MediumSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spacingMedium,
      width: Sizes.spacingMedium,
    );
  }
}

class SmallSpacer extends StatelessWidget {
  const SmallSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spacingSmall,
      width: Sizes.spacingSmall,
    );
  }
}

class ExtraSmallSpacer extends StatelessWidget {
  const ExtraSmallSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spacingExtraSmall,
      width: Sizes.spacingExtraSmall,
    );
  }
}

class ExtraExtraLargeSpacer extends StatelessWidget {
  const ExtraExtraLargeSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spacingExtraExtraLarge,
      width: Sizes.spacingExtraExtraLarge,
    );
  }
}

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({super.key, required this.size}) : assert(size >= 0);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size, width: size);
  }
}
