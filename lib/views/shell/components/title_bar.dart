import 'package:echo_frame/constants/constants.dart' show Sizes, Styles;
import 'package:echo_frame/utilities/utilities.dart'
    show ContextExtensions, Prefs;
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.background,
      child: DragToMoveArea(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: context.colors.borderPrimary,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: Sizes.spacingExtraSmall,
            horizontal: 80,
          ),
          alignment: Alignment.center,
          child: Text(
            Prefs.activeLibraryRoot ?? 'Select Library',
            style: Styles.small(color: context.colors.textSecondary),
          ),
        ),
      ),
    );
  }
}
