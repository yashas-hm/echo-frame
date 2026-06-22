import 'dart:io' show Platform;

import 'package:echo_frame/constants/constants.dart' show Sizes, Styles;
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShortcutScreen extends StatelessWidget {
  const ShortcutScreen({super.key});

  static const String path = '/shortcut';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, __) => const ShortcutScreen(),
      );

  @override
  Widget build(BuildContext context) {
    final metaKey = Platform.isMacOS ? 'CMD' : 'CTRL';
    final colors = context.colors;
    final shortcuts = [
      ('Search', [metaKey, 'F']),
      ('Media Next', ['→']),
      ('Media Previous', ['←']),
      ('Media Play/Pause', ['Space']),
      ('Media Mute', ['M']),
      ('Exit Gallery', ['Esc']),
      ('Show/Hide Info', ['I']),
    ];

    return Container(
      color: colors.background,
      height: context.height,
      margin: EdgeInsets.only(top: Sizes.spacingExtraExtraLarge),
      padding: EdgeInsets.all(Sizes.edgePadding),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.spacingMedium,
          children: [
            Text(
              'Shortcuts',
              style: Styles.subTitleBold(color: colors.textPrimary),
            ),
            ...[
              for (final shortcut in shortcuts)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      shortcut.$1,
                      style: Styles.smallRegular(color: colors.textPrimary),
                    ),
                    const Spacer(),
                    ...[
                      for (int keyIndex = 0;
                          keyIndex < shortcut.$2.length;
                          keyIndex++) ...[
                        if (keyIndex != 0)
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Sizes.spacingSmall,
                            ),
                            child: Text(
                              '+',
                              style: Styles.smallBold(
                                color: colors.textPrimary,
                              ),
                            ),
                          ),
                        _shortcutButton(context, shortcut.$2[keyIndex]),
                      ]
                    ]
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _shortcutButton(BuildContext context, String key) {
    final colors = context.colors;

    return Container(
      height: Sizes.iconSizeHuge,
      constraints: BoxConstraints(
        minWidth: Sizes.iconSizeHuge,
      ),
      padding: EdgeInsets.symmetric(
        vertical: Sizes.spacingExtraSmall,
        horizontal: Sizes.spacingMedium,
      ),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: BorderRadius.circular(Sizes.inputBorderRadius),
        border: Border.all(
          color: colors.borderPrimary,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(
              alpha: 0.1,
            ),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          key,
          style: Styles.subTitleBold(
            color: colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
