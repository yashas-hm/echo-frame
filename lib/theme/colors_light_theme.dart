part of 'theme.dart';

class LightColors extends AppThemeColors {
  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primaryColor => KnownColors.sky200;

  @override
  Color get secondaryColor => KnownColors.sky300;

  @override
  Color get tertiaryColor => KnownColors.neutral200;

  @override
  Color get background => KnownColors.neutral100;

  @override
  Color get textPrimary => KnownColors.neutral950;

  @override
  Color get textSecondary => KnownColors.slate500;

  @override
  Color get shadowColor => KnownColors.neutral950;

  @override
  Color get errorPrimary => KnownColors.red700;

  @override
  Color get cursorColor => KnownColors.sky200;

  @override
  Color get selectionColor => KnownColors.blue500.withValues(alpha: 0.3);

  @override
  Color get selectionHandleColor => KnownColors.blue500;

  @override
  Color get navigationColor => KnownColors.neutral200;

  @override
  Color get borderPrimary => KnownColors.neutral200;
}
