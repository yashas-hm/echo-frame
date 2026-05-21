import 'package:echo_frame/app/app_notifier.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EchoFrameApp extends StatelessWidget {
  const EchoFrameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: AppView(),
    );
  }
}

class AppView extends ConsumerStatefulWidget {
  const AppView({super.key});

  @override
  ConsumerState<AppView> createState() => _AppViewState();
}

class _AppViewState extends ConsumerState<AppView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appNotifierProvider.notifier).initialize(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        ref.read(appNotifierProvider.notifier).onPaused();
        break;
      case AppLifecycleState.resumed:
        ref.read(appNotifierProvider.notifier).onResumed();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode =
        ref.watch(appNotifierProvider.select((s) => s.themeMode));

    return MaterialApp(
      theme: EchoFrameThemes.light,
      darkTheme: EchoFrameThemes.dark,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      title: 'Echo Frame',
      home: const Scaffold(
        body: Placeholder(),
      ),
    );
  }
}
