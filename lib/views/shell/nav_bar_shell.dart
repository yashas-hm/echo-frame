import 'package:echo_frame/utilities/utilities.dart' show SearchIntent;
import 'package:echo_frame/views/shell/components/nav_bar.dart';
import 'package:echo_frame/views/shell/components/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.child});

  final Widget child;

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
      child: Scaffold(
        body: Column(
          children: [
            const TitleBar(),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: child),
                  NavBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
