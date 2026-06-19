import 'package:echo_frame/theme/provider/theme_provider.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show SearchIntent;
import 'package:echo_frame/views/favorites/favorites_screen.dart';
import 'package:echo_frame/views/gallery/gallery_screen.dart';
import 'package:echo_frame/views/import/import_screen.dart';
import 'package:echo_frame/views/settings/settings_screen.dart';
import 'package:echo_frame/views/shell/empty_shell.dart';
import 'package:echo_frame/views/shell/nav_bar_shell.dart';
import 'package:echo_frame/views/timeline/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: TimelineScreen.path,
  routes: [
    ShellRoute(
      builder: (_, __, child) => ShellScreen(child: child),
      routes: [
        TimelineScreen.route,
        FavoritesScreen.route,
        SettingsScreen.route,
      ],
    ),
    ShellRoute(
      builder: (_, __, child) => EmptyShell(child: child),
      routes: [
        GalleryScreen.routeDef,
        ImportScreen.route,
      ],
    ),
  ],
);

class EchoFrameApp extends ConsumerWidget {
  const EchoFrameApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider).mode;
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyF, meta: true): SearchIntent(),
        SingleActivator(LogicalKeyboardKey.keyF, control: true): SearchIntent(),
      },
      child: MaterialApp.router(
        routerConfig: _router,
        theme: EchoFrameThemes.lightTheme,
        darkTheme: EchoFrameThemes.darkTheme,
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
        title: 'Echo Frame',
      ),
    );
  }
}