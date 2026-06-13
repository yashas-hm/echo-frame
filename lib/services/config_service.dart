import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/material.dart';

class ConfigService {
  ConfigService._();

  /// Set in main() after reading the drive config; consumed by AppThemeNotifier.build().
  static ThemeMode? driveThemeMode;

  static String _configPath(String libraryRoot) =>
      '$libraryRoot/.echoframe/echo_config.json';

  static Future<Map<String, dynamic>?> _readRaw(String libraryRoot) async {
    final file = File(_configPath(libraryRoot));
    if (!await file.exists()) return null;
    try {
      return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    } catch (e, st) {
      dev.log('Failed to read echo_config.json at $libraryRoot: $e',
          stackTrace: st, name: 'ConfigService');
      return null;
    }
  }

  /// Reads the drive config and caches [driveThemeMode]. Call in main() after opening the DB.
  static Future<void> initialize(String libraryRoot) async {
    final data = await _readRaw(libraryRoot);
    if (data == null) return;
    final name = data['themeMode'] as String?;
    if (name == null) return;
    driveThemeMode = ThemeMode.values.firstWhere(
      (m) => m.name == name,
      orElse: () => ThemeMode.system,
    );
  }

  /// Merges [themeMode] into the existing config file without clobbering other fields.
  static Future<void> writeThemeMode(String libraryRoot, ThemeMode mode) async {
    final file = File(_configPath(libraryRoot));
    final existing = await _readRaw(libraryRoot) ?? {};
    existing['themeMode'] = mode.name;
    await file.writeAsString(jsonEncode(existing));
  }
}
