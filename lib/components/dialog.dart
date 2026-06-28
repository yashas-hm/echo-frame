import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/constants/constants.dart' show Sizes, Styles;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';

class EFDialog {
  const EFDialog._();

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String description,
    String? confirmText = 'Confirm',
    String? cancelText = 'Cancel',
    bool showCancel = true,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Widget Function(BuildContext)? action3,
    Widget? icon,
  }) =>
      showDialog<bool>(
        context: context,
        builder: (context) {
          final colors = context.colors;
          return AlertDialog(
            backgroundColor: context.colors.surfacePrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.inputBorderRadius),
            ),
            title: Row(
              spacing: Sizes.spacingSmall,
              children: [
                if (icon != null) icon,
                Expanded(
                  child: Text(
                    title,
                    style: Styles.regularBold(color: colors.textPrimary),
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: Sizes.viewBoxWidth,
              child: Text(
                description,
                style: Styles.smallRegular(color: colors.textSecondary),
              ),
            ),
            actions: [
              if (showCancel && cancelText != null)
                EFErrorButton.flat(
                  onPressed: () {
                    onCancel?.call();
                    Navigator.pop(context, false);
                  },
                  text: cancelText,
                ),
              if (confirmText != null)
                EFPrimaryButton.flat(
                  onPressed: () {
                    onConfirm?.call();
                    Navigator.pop(context, true);
                  },
                  text: confirmText,
                ),
              if (action3 != null) action3(context)
            ],
          );
        },
      );
}
