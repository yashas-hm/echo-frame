import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  static const double height = 35;

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: context.colors.borderPrimary,
            ),
          ),
        ),
        height: height,
      ),
    );
  }
}
