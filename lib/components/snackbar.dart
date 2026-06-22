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
    bool showDismiss = true,
  }) =>
      _show(
        context,
        message: message,
        icon: icon,
        color: context.colors.successSurface.withValues(alpha: 0.8),
        textColor: context.colors.onSuccessPrimary,
        showDismiss: showDismiss,
      );

  static void showError(
    BuildContext context, {
    required String message,
    Widget? icon,
    bool showDismiss = true,
  }) =>
      _show(
        context,
        message: message,
        icon: icon,
        color: context.colors.errorPrimary.withValues(alpha: 0.8),
        textColor: context.colors.onErrorPrimary,
        showDismiss: showDismiss,
      );

  static void showInfo(
    BuildContext context, {
    required String message,
    Widget? icon,
    bool showDismiss = true,
  }) =>
      _show(
        context,
        message: message,
        icon: icon,
        color: context.colors.surfacePrimary,
        textColor: context.colors.textPrimary,
        showDismiss: showDismiss,
      );

  static void _show(
    BuildContext context, {
    required String message,
    required Color color,
    required Color textColor,
    required bool showDismiss,
    Widget? icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Row(
          children: [
            if (icon != null) icon,
            Expanded(
              child: Text(
                message,
                softWrap: true,
                style: Styles.smallRegular(color: context.colors.textPrimary),
              ),
            ),
            if (showDismiss)
              Material(
                color: KnownColors.transparent,
                borderRadius: BorderRadius.circular(Sizes.maxFinite),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () =>
                      ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.spacingSmallRegular,
                      vertical: Sizes.spacingSmall,
                    ),
                    child: Text(
                      'Dismiss',
                      style: Styles.microBold(
                        color: context.colors.textPrimary,
                      ),
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
