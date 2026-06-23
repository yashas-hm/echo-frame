import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/constants/constants.dart' show Sizes;
import 'package:echo_frame/utilities/utilities.dart' show SearchIntent;
import 'package:echo_frame/views/shell/components/nav_bar.dart';
import 'package:echo_frame/views/shell/components/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({
    super.key,
    required this.child,
    this.enableNavBar = true,
    this.enableBackButton = false,
  });

  final Widget child;
  final bool enableNavBar;
  final bool enableBackButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Actions(
      actions: {
        SearchIntent: CallbackAction<SearchIntent>(
          onInvoke: (_) {
            SearchIntent.handle(context, ref);
            return null;
          },
        ),
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TitleBar(),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: child),
                if (enableNavBar) NavBar(),
                if (enableBackButton)
                  Positioned(
                    top: Sizes.spacingRegular,
                    left: Sizes.spacingRegular,
                    child: EFIconButton.back(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
