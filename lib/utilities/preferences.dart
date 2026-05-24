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
}
