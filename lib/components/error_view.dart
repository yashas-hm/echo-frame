import 'package:echo_frame/components/buttons/buttons.dart' show EFErrorButton;
import 'package:echo_frame/constants/constants.dart'
    show Sizes, SpacerLarge, Styles, SpacerSmallRegular;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.onButtonPressed,
    this.errorMessage,
    this.description,
    this.buttonText,
  });

  final String? errorMessage;
  final String? description;
  final String? buttonText;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: SizedBox(
        width: Sizes.viewBoxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: Sizes.iconSizeHuge,
              color: colors.errorPrimary,
            ),
            SpacerLarge(),
            Text(
              errorMessage ?? 'Something went wrong',
              style: Styles.title(),
            ),
            SpacerSmallRegular(),
            Text(
              description ?? 'Unknown error',
              textAlign: TextAlign.center,
              style: Styles.smallRegular(color: colors.textSecondary),
            ),
            SpacerLarge(),
            EFErrorButton(
              onPressed: onButtonPressed,
              text: buttonText ?? 'Retry',
            ),
          ],
        ),
      ),
    );
  }
}
