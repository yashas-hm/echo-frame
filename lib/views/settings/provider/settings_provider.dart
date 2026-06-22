import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/theme/provider/theme_provider.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  const SettingsState({
    required this.showNavLabel,
    required this.activeLibraryRoot,
    required this.knownLibraryRoots,
  });

  final bool showNavLabel;
  final String? activeLibraryRoot;
  final List<String> knownLibraryRoots;

  SettingsState copyWith({
    bool? showNavLabel,
    String? activeLibraryRoot,
    List<String>? knownLibraryRoots,
  }) =>
      SettingsState(
        showNavLabel: showNavLabel ?? this.showNavLabel,
        activeLibraryRoot: activeLibraryRoot ?? this.activeLibraryRoot,
        knownLibraryRoots: knownLibraryRoots ?? this.knownLibraryRoots,
      );
}

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() => SettingsState(
        showNavLabel: Prefs.showNavLabel,
        activeLibraryRoot: Prefs.activeLibraryRoot,
        knownLibraryRoots: Prefs.knownLibraryRoots,
      );

  void setShowNavLabel(bool value) {
    Prefs.showNavLabel = value;
    state = state.copyWith(showNavLabel: value);
  }

  Future<void> switchLibrary(String path) async {
    try {
      await EchoDatabase.closeDb();
      await EchoDatabase.open(path);
      Prefs.activeLibraryRoot = path;
      state = state.copyWith(activeLibraryRoot: path);
      ref.invalidate(timelineProvider);
    } catch (e, st) {
      dev.log(
        'Failed to switch library: $e',
        stackTrace: st,
        name: 'SettingsNotifier.switchLibrary',
      );
    }
  }

  Future<void> addLibrary(String path) async {
    try {
      await EchoDatabase.closeDb();
      await EchoDatabase.open(path);
      Prefs.addKnownLibrary(path);
      state = state.copyWith(
        activeLibraryRoot: path,
        knownLibraryRoots: Prefs.knownLibraryRoots,
      );
      ref.invalidate(timelineProvider);
    } catch (e, st) {
      dev.log(
        'Failed to add library: $e',
        stackTrace: st,
        name: 'SettingsNotifier.addLibrary',
      );
    }
  }

  void removeLibrary(String path) {
    Prefs.removeKnownLibrary(path);
    final newActive = Prefs.activeLibraryRoot;
    state = SettingsState(
      showNavLabel: state.showNavLabel,
      activeLibraryRoot: newActive,
      knownLibraryRoots: Prefs.knownLibraryRoots,
    );
    if (newActive == null) ref.invalidate(timelineProvider);
  }

  static String _settingsFilePath(String libraryRoot) =>
      '$libraryRoot/.echoframe/settings.json';

  Future<bool> saveSettings() async {
    final root = state.activeLibraryRoot;
    if (root == null) return false;
    try {
      final file = File(_settingsFilePath(root));
      await file.parent.create(recursive: true);
      await file.writeAsString(jsonEncode({
        'themeMode': Prefs.themeMode.name,
        'showNavLabel': Prefs.showNavLabel,
      }));
      return true;
    } catch (e, st) {
      dev.log(
        'Failed to save settings: $e',
        stackTrace: st,
        name: 'SettingsNotifier.saveSettings',
      );
      return false;
    }
  }

  /// Returns `null` if the file doesn't exist, `false` on parse error, `true` on success.
  Future<bool?> importSettings() async {
    final root = state.activeLibraryRoot;
    if (root == null) return false;
    final file = File(_settingsFilePath(root));
    if (!await file.exists()) return null;
    try {
      final data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      final themeName = data['themeMode'] as String?;
      if (themeName != null) {
        final mode = ThemeMode.values.firstWhere(
          (m) => m.name == themeName,
          orElse: () => ThemeMode.system,
        );
        ref.read(appThemeProvider.notifier).setMode(mode);
      }
      final showLabel = data['showNavLabel'] as bool?;
      if (showLabel != null) setShowNavLabel(showLabel);
      return true;
    } catch (e, st) {
      dev.log(
        'Failed to import settings: $e',
        stackTrace: st,
        name: 'SettingsNotifier.importSettings',
      );
      return false;
    }
  }

  void reset() {
    Prefs.showNavLabel = true;
    final active = Prefs.activeLibraryRoot;
    Prefs.knownLibraryRoots = active != null ? [active] : [];
    state = SettingsState(
      showNavLabel: true,
      activeLibraryRoot: active,
      knownLibraryRoots: Prefs.knownLibraryRoots,
    );
    ref.read(appThemeProvider.notifier).setMode(ThemeMode.system);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);