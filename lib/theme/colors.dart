part of 'theme.dart';

class KnownColors {
  KnownColors._();

  static const Color transparent = Color(0x00FFFFFF);
  static const Color basicWhite = Color(0xFFFFFFFF);
  static const Color basicBlack = Color(0xFF000000);

  // Slate (neutral warm grays)
  static const Color slate50 = Color(0xFFF8F8F8);
  static const Color slate100 = Color(0xFFF1F1F1);
  static const Color slate200 = Color(0xFFE0DEDE);
  static const Color slate300 = Color(0xFFBFBDBD);
  static const Color slate400 = Color(0xFF9E9C9C);
  static const Color slate500 = Color(0xFF7D7B7B);
  static const Color slate600 = Color(0xFF5F5D5D);
  static const Color slate700 = Color(0xFF454343);
  static const Color slate800 = Color(0xFF2A2A2A);
  static const Color slate900 = Color(0xFF151515);
  static const Color slate950 = Color(0xFF0A0A0A);

  // Strawberry (pink-red accent colors)
  static const Color strawberry50 = Color(0xFFFDF2F1);
  static const Color strawberry100 = Color(0xFFFBE0DE);
  static const Color strawberry200 = Color(0xFFF7C2BE);
  static const Color strawberry300 = Color(0xFFF3A49D);
  static const Color strawberry400 = Color(0xFFF08983);
  static const Color strawberry500 = Color(0xFFED6F68);
  static const Color strawberry600 = Color(0xFFD45550);
  static const Color strawberry700 = Color(0xFFB1403C);
  static const Color strawberry800 = Color(0xFF8E3230);
  static const Color strawberry900 = Color(0xFF6B2625);
  static const Color strawberry950 = Color(0xFF3A1413);

  // Apricot (orange-red brand colors)
  static const Color apricot50 = Color(0xFFFFF5ED);
  static const Color apricot100 = Color(0xFFFFE6D1);
  static const Color apricot200 = Color(0xFFFDCBA3);
  static const Color apricot300 = Color(0xFFFBB07A);
  static const Color apricot400 = Color(0xFFF99E66);
  static const Color apricot500 = Color(0xFFF68D52);
  static const Color apricot600 = Color(0xFFDC7439);
  static const Color apricot700 = Color(0xFFB85B28);
  static const Color apricot800 = Color(0xFF93481F);
  static const Color apricot900 = Color(0xFF6E3619);
  static const Color apricot950 = Color(0xFF3B1C0C);

  // Mint (green)
  static const Color mint50 = Color(0xFFEEFBF3);
  static const Color mint100 = Color(0xFFD4F5E2);
  static const Color mint200 = Color(0xFFADE9C6);
  static const Color mint300 = Color(0xFF86D4A9);
  static const Color mint400 = Color(0xFF62BF8C);
  static const Color mint500 = Color(0xFF4DA977);
  static const Color mint600 = Color(0xFF399364);
  static const Color mint700 = Color(0xFF2E7650);
  static const Color mint800 = Color(0xFF245C3F);
  static const Color mint900 = Color(0xFF1A432E);

  // Sky (blue)
  static const Color sky50 = Color(0xFFE3F2FD);
  static const Color sky100 = Color(0xFFBBDEFB);
  static const Color sky200 = Color(0xFF90CAF9);
  static const Color sky300 = Color(0xFF64B5F6);
  static const Color sky400 = Color(0xFF42A5F5);
  static const Color sky500 = Color(0xFF2196F3);
  static const Color sky600 = Color(0xFF1E88E5);
  static const Color sky700 = Color(0xFF1976D2);
  static const Color sky800 = Color(0xFF1565C0);
  static const Color sky900 = Color(0xFF0D47A1);

  // Gold (amber/warning)
  static const Color gold50 = Color(0xFFFFF8E7);
  static const Color gold100 = Color(0xFFFEEFC3);
  static const Color gold200 = Color(0xFFFDE49B);
  static const Color gold300 = Color(0xFFFCD973);
  static const Color gold400 = Color(0xFFE9C55E);
  static const Color gold500 = Color(0xFFD9B14F);
  static const Color gold600 = Color(0xFFC49B3A);
  static const Color gold700 = Color(0xFFA37E2A);
  static const Color gold800 = Color(0xFF82631E);
  static const Color gold900 = Color(0xFF614A16);

  static const gradient = LinearGradient(
    colors: [KnownColors.strawberry500, KnownColors.apricot500],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );
}

abstract class AppThemeColors {
  const AppThemeColors();

  Brightness get brightness;

  // Primary
  Color get primaryColor;

  Color get onPrimary;

  // Secondary
  Color get secondaryColor;

  Color get onSecondary;

  // Text
  Color get textPrimary;

  Color get textSecondary;

  // Surfaces
  Color get background;

  Color get surface;

  // Status
  Color get success;

  Color get danger;

  Color get info;

  Color get warning;

  // Buttons
  Color get primaryButtonColor => primaryColor;

  Color get primaryButtonTextColor => onPrimary;

  Color get secondaryButtonColor => secondaryColor;

  Color get secondaryButtonTextColor => onSecondary;

  Color get dangerButtonColor => danger;

  Color get dangerButtonTextColor => onPrimary;
  
  Color get disabledButtonColor;

  // Inputs
  Color get inputFillColor => surface;

  Color get inputTextColor => textPrimary;

  Color get inputBorderColor => surface;

  Color get inputErrorColor => danger;

  // Selection
  Color get cursorColor => primaryColor;

  Color get selectionColor;

  Color get selectionHandleColor => info;

  // Shadow
  Color get shadowColor => textPrimary.withValues(alpha: 0.2);

  Color get visitifyrStandard => textPrimary;

  Color get visitifyrPlus => KnownColors.sky500;

  Color get visitifyrGold => KnownColors.gold500;
}
