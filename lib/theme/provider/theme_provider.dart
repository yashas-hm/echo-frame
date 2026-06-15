import 'package:echo_frame/services/config_service.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeState {
  const AppThemeState({required this.mode, required this.colors});

  final ThemeMode mode;
  final AppThemeColors colors;

  bool get isDark => switch (mode) {
        ThemeMode.dark => true,
        ThemeMode.light => false,
        ThemeMode.system =>
          SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark,
      };
}

class AppThemeNotifier extends Notifier<AppThemeState> {
  @override
  AppThemeState build() => _resolve(Prefs.themeMode);

  void init() => state = _resolve(Prefs.themeMode);

  void toggle() => _set(state.isDark ? ThemeMode.light : ThemeMode.dark);

  void setLight() => _set(ThemeMode.light);

  void setDark() => _set(ThemeMode.dark);

  void setMode(ThemeMode mode) => _set(mode);

  void _set(ThemeMode mode) {
    state = _resolve(mode);
    Prefs.themeMode = mode;
    final root = Prefs.libraryRootPath;
    if (root != null) {
      ConfigService.writeThemeMode(root, mode);
    }
  }

  AppThemeState _resolve(ThemeMode mode) {
    final dark = switch (mode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system =>
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark,
    };
    return AppThemeState(
      mode: mode,
      colors: dark ? EchoFrameThemes.darkColors : EchoFrameThemes.lightColors,
    );
  }
}

final appThemeProvider = NotifierProvider<AppThemeNotifier, AppThemeState>(
  AppThemeNotifier.new,
);
