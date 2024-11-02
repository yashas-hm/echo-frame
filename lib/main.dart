import 'package:echo_frame/core/constants/app_constants.dart';
import 'package:echo_frame/core/constants/app_theme.dart';
import 'package:echo_frame/providers/ui_provider.dart';
import 'package:flutter/material.dart';

void main()async {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalKey,
      theme: EchoFrameTheme(context).light,
      darkTheme: EchoFrameTheme(context).dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: kAppName,
      home: const Scaffold(
        body: Placeholder(),
      ),
    );
  }
}
