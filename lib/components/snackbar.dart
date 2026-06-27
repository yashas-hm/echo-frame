import 'package:echo_frame/constants/constants.dart' show Styles, Sizes;
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';

class EFSnackbar {
  const EFSnackbar._();

  static void showSuccess(
    BuildContext context, {
    required String message,
    Widget? icon,
    String? actionText,
    VoidCallback? onActionPressed,
  }) =>
      _show(
        context,
        message: message,
        icon: icon,
        color: context.colors.successSurface.withValues(alpha: 0.8),
        textColor: context.colors.onSuccessPrimary,
        actionText: actionText,
        onActionPressed: onActionPressed,
      );

  static void showError(
    BuildContext context, {
    required String message,
    Widget? icon,
    String? actionText,
    VoidCallback? onActionPressed,
  }) =>
      _show(
        context,
        message: message,
        icon: icon,
        color: context.colors.errorPrimary.withValues(alpha: 0.8),
        textColor: context.colors.onErrorPrimary,
        actionText: actionText,
        onActionPressed: onActionPressed,
      );

  static void showInfo(
    BuildContext context, {
    required String message,
    Widget? icon,
    String? actionText,
    VoidCallback? onActionPressed,
  }) =>
      _show(
        context,
        message: message,
        icon: icon,
        color: context.colors.surfacePrimary,
        textColor: context.colors.textPrimary,
        actionText: actionText,
        onActionPressed: onActionPressed,
      );

  static void _show(
    BuildContext context, {
    required String message,
    required Color color,
    required Color textColor,
    Widget? icon,
    String? actionText,
    VoidCallback? onActionPressed,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    final contentStyle = Styles.smallRegular(color: context.colors.textPrimary);
    final actionStyle = Styles.microBold(color: context.colors.textPrimary);
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Row(
          children: [
            if (icon != null) icon,
            Expanded(
              child: Text(
                message,
                softWrap: true,
                style: contentStyle,
              ),
            ),
            Material(
              color: KnownColors.transparent,
              borderRadius: BorderRadius.circular(Sizes.maxFinite),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  messenger.removeCurrentSnackBar();
                  onActionPressed?.call();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.spacingSmallRegular,
                    vertical: Sizes.spacingSmall,
                  ),
                  child: Text(
                    actionText ?? 'Dismiss',
                    style: actionStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
