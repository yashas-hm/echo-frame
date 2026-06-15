part of 'theme.dart';

class KnownColors {
  KnownColors._();

  static const Color basicWhite = Color(0xFFFFFFFF);
  static const Color basicBlack = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // Sky palette
  static const Color sky50  = Color(0xFFEEF6FF);
  static const Color sky100 = Color(0xFFCFE5FF);
  static const Color sky200 = Color(0xFF9ACBFD);
  static const Color sky300 = Color(0xFF6BB5F2);
  static const Color sky400 = Color(0xFF3E9EF5);
  static const Color sky500 = Color(0xFF1A7FE8);
  static const Color sky600 = Color(0xFF1464C8);
  static const Color sky700 = Color(0xFF0F4EA6);
  static const Color sky800 = Color(0xFF0A3880);
  static const Color sky900 = Color(0xFF062356);

  // Strawberry – error / destructive (light, pastel-forward)
  static const Color strawberry100 = Color(0xFFFFE4E4);
  static const Color strawberry200 = Color(0xFFFFBDBD);
  static const Color strawberry300 = Color(0xFFFF8FA3);
  static const Color strawberry400 = Color(0xFFFF6B6B);
  static const Color strawberry500 = Color(0xFFFA5252);

  // Mint – success / positive (light, pastel-forward)
  static const Color mint100 = Color(0xFFDDFBF0);
  static const Color mint200 = Color(0xFFB2F2E0);
  static const Color mint300 = Color(0xFF69DFB8);
  static const Color mint400 = Color(0xFF38C99A);
  static const Color mint500 = Color(0xFF20B586);

  // Slate – full grey ramp (backgrounds, surfaces, text, borders)
  static const Color slate50  = Color(0xFFFAFAFA); // near-white bg (light)
  static const Color slate100 = Color(0xFFECEEF0);
  static const Color slate200 = Color(0xFFE0DEDE); // light surface
  static const Color slate300 = Color(0xFFA7ACB1);
  static const Color slate400 = Color(0xFF868E96);
  static const Color slate500 = Color(0xFF6C757D);
  static const Color slate600 = Color(0xFF545B62);
  static const Color slate700 = Color(0xFF3D4349);
  static const Color slate800 = Color(0xFF2A2A2A); // dark surface
  static const Color slate900 = Color(0xFF131619);
  static const Color slate950 = Color(0xFF1C1C1C); // near-black bg (dark)
}

abstract class AppThemeColors extends ThemeExtension<AppThemeColors> {
  Brightness get brightness;

  // Primary brand color (sky blue)
  Color get primaryColor;

  Color get onPrimary => KnownColors.basicWhite;

  // Secondary brand color
  Color get secondaryColor;

  Color get onSecondary => onPrimary;

  // Tertiary surface (element/card backgrounds)
  Color get surfacePrimary;

  // Backgrounds
  Color get background;

  // Text
  Color get textPrimary;

  Color get textSecondary;

  // Maps to colorScheme.shadow – used by textColor dynamic getter
  Color get shadowColor;

  // Error
  Color get errorPrimary;

  Color get onErrorPrimary => onPrimary;

  Color get errorSurface;

  // Success
  Color get success;

  Color get successSurface;

  Color get onSuccess => onPrimary;

  // Cursor / selection
  Color get cursorColor;

  Color get selectionColor;

  Color get selectionHandleColor;

  // Navigation bar background
  Color get navigationColor;

  // Borders / dividers
  Color get borderPrimary;

  Color get dividerColor => borderPrimary;

  // Interaction
  Color get splashColor => primaryColor.withValues(alpha: 0.12);

  Color get hoverColor => onPrimary.withValues(alpha: 0.2);

  // Frosted glass background (blur filter overlay)
  Color get frostColor =>  textPrimary.withValues(alpha: 0.1);

  @override
  AppThemeColors lerp(AppThemeColors b, double t) => _LerpedColors(
        brightness: t < 0.5 ? brightness : b.brightness,
        primaryColor: Color.lerp(primaryColor, b.primaryColor, t)!,
        secondaryColor: Color.lerp(secondaryColor, b.secondaryColor, t)!,
        surfacePrimary: Color.lerp(surfacePrimary, b.surfacePrimary, t)!,
        background: Color.lerp(background, b.background, t)!,
        textPrimary: Color.lerp(textPrimary, b.textPrimary, t)!,
        textSecondary: Color.lerp(textSecondary, b.textSecondary, t)!,
        shadowColor: Color.lerp(shadowColor, b.shadowColor, t)!,
        errorPrimary: Color.lerp(errorPrimary, b.errorPrimary, t)!,
        errorSurface: Color.lerp(errorSurface, b.errorSurface, t)!,
        success: Color.lerp(success, b.success, t)!,
        successSurface: Color.lerp(successSurface, b.successSurface, t)!,
        frostColor: Color.lerp(frostColor, b.frostColor, t)!,
        cursorColor: Color.lerp(cursorColor, b.cursorColor, t)!,
        selectionColor: Color.lerp(selectionColor, b.selectionColor, t)!,
        selectionHandleColor:
            Color.lerp(selectionHandleColor, b.selectionHandleColor, t)!,
        navigationColor: Color.lerp(navigationColor, b.navigationColor, t)!,
        borderPrimary: Color.lerp(borderPrimary, b.borderPrimary, t)!,
      );
}

final class _LerpedColors extends AppThemeColors {
  _LerpedColors({
    required this.brightness,
    required this.primaryColor,
    required this.secondaryColor,
    required this.surfacePrimary,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.shadowColor,
    required this.errorPrimary,
    required this.errorSurface,
    required this.success,
    required this.successSurface,
    required this.frostColor,
    required this.cursorColor,
    required this.selectionColor,
    required this.selectionHandleColor,
    required this.navigationColor,
    required this.borderPrimary,
  });

  @override
  final Brightness brightness;
  @override
  final Color primaryColor;
  @override
  final Color secondaryColor;
  @override
  final Color surfacePrimary;
  @override
  final Color background;
  @override
  final Color textPrimary;
  @override
  final Color textSecondary;
  @override
  final Color shadowColor;
  @override
  final Color errorPrimary;
  @override
  final Color errorSurface;
  @override
  final Color success;
  @override
  final Color successSurface;
  @override
  final Color frostColor;
  @override
  final Color cursorColor;
  @override
  final Color selectionColor;
  @override
  final Color selectionHandleColor;
  @override
  final Color navigationColor;
  @override
  final Color borderPrimary;

  @override
  _LerpedColors copyWith() => this;
}
