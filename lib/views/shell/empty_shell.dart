import 'package:echo_frame/components/title_bar.dart';
import 'package:echo_frame/utilities/utilities.dart' show ContextExtensions;
import 'package:flutter/material.dart';

class EmptyShell extends StatelessWidget {
  const EmptyShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TitleBar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
