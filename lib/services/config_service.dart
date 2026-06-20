import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:flutter/material.dart';

class ConfigService {
  ConfigService._();

  static String _configPath(String libraryRoot) =>
      '$libraryRoot/.echoframe/echo_config.json';

  static Future<Map<String, dynamic>?> _readRaw(String libraryRoot) async {
    final file = File(_configPath(libraryRoot));
    if (!await file.exists()) return null;
    try {
      return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    } catch (e, st) {
      dev.log(
        'Failed to read echo_config.json: $e',
        stackTrace: st,
        name: 'ConfigService._readRaw',
      );
      return null;
    }
  }

  static Future<void> _write(
      String libraryRoot, Map<String, dynamic> data) async {
    try {
      final file = File(_configPath(libraryRoot));
      await file.parent.create(recursive: true);
      await file.writeAsString(jsonEncode(data));
    } catch (e, st) {
      dev.log(
        'Failed to write echo_config.json: $e',
        stackTrace: st,
        name: 'ConfigService._write',
      );
    }
  }

  /// On first run (no SharedPreferences yet), seeds Prefs from the config file.
  /// Sets [Prefs.sharedPrefExists] when done so subsequent launches skip this.
  static Future<void> seedPrefsIfNeeded(String libraryRoot) async {
    if (Prefs.sharedPrefExists) return;
    final data = await _readRaw(libraryRoot);
    if (data != null) {
      final themeName = data['themeMode'] as String?;
      if (themeName != null) {
        Prefs.themeMode = ThemeMode.values.firstWhere(
          (m) => m.name == themeName,
          orElse: () => ThemeMode.system,
        );
      }
      final showLabel = data['showNavLabel'] as bool?;
      if (showLabel != null) Prefs.showNavLabel = showLabel;
    }
    Prefs.sharedPrefExists = true;
  }

  static Future<void> writeThemeMode(String libraryRoot, ThemeMode mode) async {
    final existing = await _readRaw(libraryRoot) ?? {};
    existing['themeMode'] = mode.name;
    await _write(libraryRoot, existing);
  }

  static Future<void> writeShowNavLabel(String libraryRoot, bool value) async {
    final existing = await _readRaw(libraryRoot) ?? {};
    existing['showNavLabel'] = value;
    await _write(libraryRoot, existing);
  }
}
