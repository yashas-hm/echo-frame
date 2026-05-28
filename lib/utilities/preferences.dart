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

  static String? get libraryRootPath => _prefs.getString(Keys.libraryRootPath);

  static set libraryRootPath(String? value) {
    if (value == null) {
      _prefs.remove(Keys.libraryRootPath);
    } else {
      _prefs.setString(Keys.libraryRootPath, value);
    }
  }
}
