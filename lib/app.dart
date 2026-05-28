import 'package:echo_frame/theme/provider/theme_provider.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/first_launch/first_launch_screen.dart';
import 'package:echo_frame/views/import/import_screen.dart';
import 'package:echo_frame/views/organizer/organizer_screen.dart';
import 'package:echo_frame/views/settings/settings_screen.dart';
import 'package:echo_frame/views/shell/shell_screen.dart';
import 'package:echo_frame/views/timeline/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/timeline',
  redirect: (context, state) {
    final hasRoot = Prefs.libraryRootPath != null;
    final isSetup = state.matchedLocation == '/setup';
    if (!hasRoot && !isSetup) return '/setup';
    if (hasRoot && isSetup) return '/timeline';
    return null;
  },
  routes: [
    GoRoute(
      path: '/setup',
      builder: (_, __) => const FirstLaunchScreen(),
    ),
    ShellRoute(
      builder: (_, __, child) => ShellScreen(child: child),
      routes: [
        GoRoute(path: '/timeline', builder: (_, __) => const TimelineScreen()),
        GoRoute(path: '/organize', builder: (_, __) => const OrganizerScreen()),
        GoRoute(path: '/import', builder: (_, __) => const ImportScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    ),
  ],
);

class EchoFrameApp extends ConsumerWidget {
  const EchoFrameApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider).mode;
    return MaterialApp.router(
      routerConfig: _router,
      theme: EchoFrameThemes.lightTheme,
      darkTheme: EchoFrameThemes.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      title: 'Echo Frame',
    );
  }
}
