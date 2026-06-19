import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  static const double height = 40;

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
        child: Row(
          children: [
            // Space for macOS traffic lights (close/min/max)
            const SizedBox(width: 80),
            Expanded(
              child: Center(
                child: Text(
                  'Echo Frame',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            context.colors.textPrimary.withValues(alpha: 0.4),
                        letterSpacing: 0.3,
                      ),
                ),
              ),
            ),
            const SizedBox(width: 80),
          ],
        ),
      ),
    );
  }
}
