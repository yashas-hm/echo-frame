import 'package:echo_frame/theme/provider/theme_provider.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/views/favorites/favorites_screen.dart';
import 'package:echo_frame/views/import/import_screen.dart';
import 'package:echo_frame/views/organizer/organizer_screen.dart';
import 'package:echo_frame/views/photo_view/photo_view_screen.dart';
import 'package:echo_frame/views/search/search_screen.dart';
import 'package:echo_frame/views/settings/settings_screen.dart';
import 'package:echo_frame/views/shell/shell_screen.dart';
import 'package:echo_frame/views/timeline/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: TimelineScreen.path,
  routes: [
    ShellRoute(
      builder: (_, __, child) {
        return ShellScreen(child: child);
      },
      routes: [
        TimelineScreen.route,
        SearchScreen.route,
        FavoritesScreen.route,
        OrganizerScreen.route,
        ImportScreen.route,
        SettingsScreen.route,
      ],
    ),
    PhotoViewScreen.routeDef,
  ],
);

class EchoFrameApp extends ConsumerWidget {
  const EchoFrameApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider).mode;
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyF, meta: true): _SearchIntent(),
        SingleActivator(LogicalKeyboardKey.keyF, control: true):
            _SearchIntent(),
      },
      child: Actions(
        actions: {
          _SearchIntent: CallbackAction<_SearchIntent>(
            onInvoke: (_) {
              _router.go(SearchScreen.path);
              return null;
            },
          ),
        },
        child: MaterialApp.router(
          routerConfig: _router,
          theme: EchoFrameThemes.lightTheme,
          darkTheme: EchoFrameThemes.darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          title: 'Echo Frame',
        ),
      ),
    );
  }
}

class _SearchIntent extends Intent {
  const _SearchIntent();
}
