part of 'theme.dart';

class EchoFrameThemes {
  EchoFrameThemes._();

  static const LightColors _lightColors = LightColors();
  static const DarkColors _darkColors = DarkColors();

  static final ThemeData light = _generate(_lightColors);
  static final ThemeData dark = _generate(_darkColors);

  static AppThemeColors colorsFor(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return _darkColors;
      case ThemeMode.light:
        return _lightColors;
      case ThemeMode.system:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark ? _darkColors : _lightColors;
    }
  }

  static ThemeData _generate(AppThemeColors colors) {
    final isLight = colors.brightness == Brightness.light;

    return ThemeData(
      primaryColor: colors.primaryColor,
      scaffoldBackgroundColor: colors.background,
      textTheme: GoogleFonts.latoTextTheme().apply(
        bodyColor: colors.textPrimary,
        displayColor: colors.textPrimary,
      ),
      useMaterial3: false,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: colors.brightness,
          statusBarColor: colors.surface,
          statusBarIconBrightness:
          isLight ? Brightness.dark : Brightness.light,
        ),
        elevation: 5,
        iconTheme: IconThemeData(color: colors.textPrimary),
        backgroundColor: colors.surface,
        titleTextStyle: GoogleFonts.pacifico(
          fontSize: 30,
          color: colors.textPrimary,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.secondaryColor,
        primary: colors.primaryColor,
        secondary: colors.secondaryColor,
        tertiary: colors.surface,
        tertiaryContainer: colors.success,
        shadow: colors.textPrimary,
        brightness: colors.brightness,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: colors.selectionHandleColor,
        cursorColor: colors.cursorColor,
        selectionColor: colors.selectionColor,
      ),
    );
  }
}