part of '../settings_screen.dart';

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

  Future<EchoDBOpenResult> switchLibrary(String path) async {
    try {
      await EchoDatabase.closeDb();
      final result = await EchoDatabase.open(path);
      if (!result.success) return result;
      Prefs.activeLibraryRoot = path;
      state = state.copyWith(activeLibraryRoot: path);
      ref.invalidate(timelineProvider);
      ref.invalidate(favoritesProvider);
      ref.invalidate(trashProvider);
      return result;
    } catch (e, st) {
      dev.log(
        'Failed to switch library: $e',
        stackTrace: st,
        name: 'SettingsNotifier.switchLibrary',
      );
      return EchoDBOpenResult(success: false, isExisting: false);
    }
  }

  Future<EchoDBOpenResult> addLibrary(String path) async {
    try {
      await EchoDatabase.closeDb();
      final result = await EchoDatabase.open(path);
      if (!result.success) return result;
      Prefs.addKnownLibrary(path);
      state = state.copyWith(
        activeLibraryRoot: path,
        knownLibraryRoots: Prefs.knownLibraryRoots,
      );
      ref.invalidate(timelineProvider);
      return result;
    } catch (e, st) {
      dev.log(
        'Failed to add library: $e',
        stackTrace: st,
        name: 'SettingsNotifier.addLibrary',
      );
      return EchoDBOpenResult(success: false, isExisting: false);
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
      final data =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;
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
