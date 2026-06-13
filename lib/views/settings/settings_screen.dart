import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String path = '/settings';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, __) => const SettingsScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Settings')),
    );
  }
}
