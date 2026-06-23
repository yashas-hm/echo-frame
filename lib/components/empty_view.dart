import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.button,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? button;

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
              icon,
              size: Sizes.iconSizeHuge,
              color: colors.textSecondary,
            ),
            const SpacerMedium(),
            Text(
              title,
              style: Styles.subtitle(color: colors.textPrimary),
            ),
            const SpacerSmall(),
            Text(
              message,
              style: Styles.small(color: context.colors.textSecondary),
            ),
            if (button != null) ...[
              const SpacerExtraLarge(),
              button!,
            ]
          ],
        ),
      ),
    );
  }
}
