import 'package:echo_frame/theme/provider/theme_provider.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(const ProviderScope(child: Application()));
}

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: EchoFrameThemes.lightTheme,
      darkTheme: EchoFrameThemes.darkTheme,
      themeMode: ref.watch(appThemeProvider).mode,
      debugShowCheckedModeBanner: false,
      title: 'Echo Frame',
      home: const Scaffold(
        body: Placeholder(),
      ),
    );
  }
}
