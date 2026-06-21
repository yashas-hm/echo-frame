part of 'utilities.dart';

class Prefs {
  Prefs._();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static ThemeMode get themeMode => ThemeMode.values.firstWhere(
        (m) => m.name == _prefs.getString(Keys.themeModePrefTag),
        orElse: () => ThemeMode.system,
      );

  static set themeMode(ThemeMode value) =>
      _prefs.setString(Keys.themeModePrefTag, value.name);

  static String? get activeLibraryRoot =>
      _prefs.getString(Keys.activeLibraryRoot);

  static set activeLibraryRoot(String? value) {
    if (value == null) {
      _prefs.remove(Keys.activeLibraryRoot);
    } else {
      _prefs.setString(Keys.activeLibraryRoot, value);
    }
  }

  static List<String> get knownLibraryRoots =>
      _prefs.getStringList(Keys.knownLibraryRoots) ?? [];

  static set knownLibraryRoots(List<String> value) =>
      _prefs.setStringList(Keys.knownLibraryRoots, value);

  /// Adds [path] to known roots (deduplicating) and sets it as the active root.
  static void addKnownLibrary(String path) {
    activeLibraryRoot = path;
    final roots = knownLibraryRoots;
    if (!roots.contains(path)) {
      knownLibraryRoots = [...roots, path];
    }
  }

  static void removeKnownLibrary(String path) {
    knownLibraryRoots = knownLibraryRoots.where((r) => r != path).toList();
    if (activeLibraryRoot == path) activeLibraryRoot = null;
  }

  static bool get showNavLabel => _prefs.getBool(Keys.showNavLabel) ?? true;

  static set showNavLabel(bool value) =>
      _prefs.setBool(Keys.showNavLabel, value);

  // ── Window geometry ───────────────────────────────────────────────────────

  static double? get windowWidth => _prefs.getDouble(Keys.windowWidth);

  static set windowWidth(double? v) {
    if (v == null) {
      _prefs.remove(Keys.windowWidth);
    } else {
      _prefs.setDouble(Keys.windowWidth, v);
    }
  }

  static double? get windowHeight => _prefs.getDouble(Keys.windowHeight);

  static set windowHeight(double? v) {
    if (v == null) {
      _prefs.remove(Keys.windowHeight);
    } else {
      _prefs.setDouble(Keys.windowHeight, v);
    }
  }

  static double? get windowX => _prefs.getDouble(Keys.windowX);

  static set windowX(double? v) {
    if (v == null) {
      _prefs.remove(Keys.windowX);
    } else {
      _prefs.setDouble(Keys.windowX, v);
    }
  }

  static double? get windowY => _prefs.getDouble(Keys.windowY);

  static set windowY(double? v) {
    if (v == null) {
      _prefs.remove(Keys.windowY);
    } else {
      _prefs.setDouble(Keys.windowY, v);
    }
  }
}
