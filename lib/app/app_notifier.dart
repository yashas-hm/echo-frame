import 'dart:developer';

import 'package:echo_frame/services/shared_preferecnes.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppData {
  final ThemeMode themeMode;
  final AppThemeColors colors;

  const AppData({
    required this.themeMode,
    required this.colors,
  });

  AppData copyWith({ThemeMode? themeMode, AppThemeColors? colors}) => AppData(
        themeMode: themeMode ?? this.themeMode,
        colors: colors ?? this.colors,
      );
}

class AppNotifier extends Notifier<AppData> {
  @override
  AppData build() => AppData(
        themeMode: ThemeMode.system,
        colors: EchoFrameThemes.colorsFor(ThemeMode.system),
      );

  Future<void> initialize(BuildContext context) async {
    try {
      if (!context.mounted) return;
      final themeMode = await _resolveThemeMode(context);

      state = state.copyWith(
        themeMode: themeMode,
        colors: EchoFrameThemes.colorsFor(themeMode),
      );
    } catch (e, s) {
      log('Error @ App Initialization', error: e, stackTrace: s);
    }
  }

  Future<void> changeTheme(ThemeMode mode) async {
    state = state.copyWith(
      themeMode: mode,
      colors: EchoFrameThemes.colorsFor(mode),
    );
    await AppPreferences.instance.setTheme(mode);
  }

  void onPaused() {}

  void onResumed() {}

  Future<ThemeMode> _resolveThemeMode(BuildContext context) async {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final saved = await AppPreferences.instance.getTheme();
    if (saved != null) return saved;
    return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }
}

final appNotifierProvider =
    NotifierProvider<AppNotifier, AppData>(AppNotifier.new);
