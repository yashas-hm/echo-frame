part of 'theme.dart';

class EchoFrameThemes {
  EchoFrameThemes._();

  static final LightColors _light = LightColors();
  static final DarkColors _dark = DarkColors();

  static final ThemeData lightTheme = _generateTheme(_light);
  static final ThemeData darkTheme = _generateTheme(_dark);

  static AppThemeColors get lightColors => _light;

  static AppThemeColors get darkColors => _dark;

  static ThemeData _generateTheme(AppThemeColors colors) {
    final brightness = colors.brightness;
    final isLight = brightness == Brightness.light;

    return ThemeData(
      primaryColor: colors.primaryColor,
      scaffoldBackgroundColor: colors.background,
      textTheme: GoogleFonts.robotoMonoTextTheme().apply(
        bodyColor: colors.textPrimary,
        displayColor: colors.textPrimary,
      ),
      useMaterial3: false,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: brightness,
          statusBarColor: colors.tertiaryColor,
          statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
        ),
        elevation: 5,
        iconTheme: IconThemeData(color: colors.textPrimary),
        backgroundColor: colors.tertiaryColor,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.secondaryColor,
        primary: colors.primaryColor,
        secondary: colors.secondaryColor,
        tertiary: colors.tertiaryColor,
        shadow: colors.shadowColor,
        error: colors.errorPrimary,
        brightness: brightness,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: colors.selectionHandleColor,
        cursorColor: colors.cursorColor,
        selectionColor: colors.selectionColor,
      ),
      dividerColor: colors.dividerColor,
      extensions: [colors],
    );
  }
}
