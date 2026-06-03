import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  static const double height = 40;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DragToMoveArea(
      child: SizedBox(
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
                        color: colors.onSurface.withValues(alpha: 0.4),
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
