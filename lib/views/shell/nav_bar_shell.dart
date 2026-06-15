import 'package:echo_frame/views/shell/components/nav_bar.dart';
import 'package:echo_frame/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TitleBar(),
          const Divider(height: 1, thickness: 1),
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
    );
  }
}
