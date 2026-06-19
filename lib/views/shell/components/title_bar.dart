import 'package:echo_frame/constants/constants.dart' show Assets, Sizes, Styles;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

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
        padding: EdgeInsets.symmetric(
          vertical: Sizes.spacingExtraSmall,
          horizontal: 80,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: Sizes.spacingSmall,
          children: [
            SvgPicture.asset(
              Assets.logoAsset,
              height: Sizes.iconSizeSmallRegular,
              width: Sizes.iconSizeSmallRegular,
              fit: BoxFit.contain,
            ),
            Text(
              'Echo Frame',
              style: Styles.small(color: context.colors.textSecondary),
            )
          ],
        ),
      ),
    );
  }
}
