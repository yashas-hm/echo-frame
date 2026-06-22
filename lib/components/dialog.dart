import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/constants/constants.dart' show Sizes, Styles;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';

class EFDialog extends StatelessWidget {
  const EFDialog({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.cancelCallback,
    this.confirmCallback,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.showCancel = true,
  });

  final String title;
  final String description;
  final String confirmText;
  final String cancelText;
  final bool showCancel;
  final Widget? icon;
  final VoidCallback? cancelCallback;
  final VoidCallback? confirmCallback;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String description,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool showCancel = true,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Widget? icon,
  }) =>
      showDialog<bool>(
        context: context,
        builder: (_) => EFDialog(
          title: title,
          description: description,
          icon: icon,
          confirmText: confirmText,
          cancelText: cancelText,
          showCancel: showCancel,
          confirmCallback: onConfirm,
          cancelCallback: onCancel,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.inputBorderRadius),
      ),
      icon: icon,
      title: Text(
        title,
        style: Styles.regularBold(color: colors.textPrimary),
      ),
      content: SizedBox(
        width: Sizes.viewBoxWidth,
        child: Text(
          description,
          style: Styles.smallRegular(color: colors.textSecondary),
        ),
      ),
      actions: [
        if (showCancel)
          EFErrorButton.flat(
            onPressed: () {
              cancelCallback?.call();
              Navigator.pop(context, false);
            },
            text: cancelText,
          ),
        EFPrimaryButton.flat(
          onPressed: () {
            confirmCallback?.call();
            Navigator.pop(context, true);
          },
          text: confirmText,
        ),
      ],
    );
  }
}
