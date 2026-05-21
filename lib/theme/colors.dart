part of 'theme.dart';

class KnownColors {
  KnownColors._();

  static const Color basicWhite = Color(0xFFFFFFFF);
  static const Color basicBlack = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // Sky palette – EchoFrame brand (light-theme primary → secondary)
  static const Color sky200 = Color(0xFF6BB5F2); // soft sky (light-theme primary)
  static const Color sky300 = Color(0xFF5E9FF2); // medium sky (light-theme secondary)
  static const Color sky400 = Color(0xFF36A0F7); // bright sky (dark-theme primary)
  static const Color sky500 = Color(0xFF3187F5); // deep sky (dark-theme secondary)

  // Neutral palette – app backgrounds / text
  static const Color neutral100 = Color(0xFFFAFAFA); // near-white bg (light)
  static const Color neutral200 = Color(0xFFE0DEDE); // light surface
  static const Color neutral800 = Color(0xFF2A2A2A); // dark surface
  static const Color neutral950 = Color(0xFF1C1C1C); // near-black bg (dark)

  // Blue – text-selection handles
  static const Color blue500 = Color(0xFF2196F3);

  // Error palette
  static const Color red200 = Color(0xFFFD9999);
  static const Color red300 = Color(0xFFFC6666);
  static const Color red600 = Color(0xFFC80000);
  static const Color red700 = Color(0xFF960000);

  // Slate – secondary text tones
  static const Color slate300 = Color(0xFFA7ACB1);
  static const Color slate500 = Color(0xFF6C757D);
}

abstract class AppThemeColors {
  Brightness get brightness;

  // Primary brand color (sky blue)
  Color get primaryColor;

  Color get onPrimary => KnownColors.basicWhite;

  // Secondary brand color
  Color get secondaryColor;

  Color get onSecondary => textPrimary;

  // Tertiary surface (element/card backgrounds)
  Color get tertiaryColor;

  // Backgrounds
  Color get background;

  Color get surfacePrimary => background;

  // Text
  Color get textPrimary;

  Color get textSecondary;

  // Maps to colorScheme.shadow – used by textColor dynamic getter
  Color get shadowColor;

  // Error
  Color get errorPrimary;

  Color get onErrorPrimary => onPrimary;

  // Cursor / selection
  Color get cursorColor;

  Color get selectionColor;

  Color get selectionHandleColor;

  // Navigation bar background
  Color get navigationColor;

  // Borders / dividers
  Color get borderPrimary;

  Color get dividerColor => borderPrimary;

  // Hover (defaults to primary)
  Color get hoverColor => primaryColor;
}
