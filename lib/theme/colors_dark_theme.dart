part of 'theme.dart';

class DarkColors extends AppThemeColors {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get primaryColor => KnownColors.sky400;

  @override
  Color get secondaryColor => KnownColors.sky500;

  @override
  Color get tertiaryColor => KnownColors.neutral800;

  @override
  Color get background => KnownColors.neutral950;

  @override
  Color get textPrimary => KnownColors.neutral100;

  @override
  Color get textSecondary => KnownColors.slate300;

  @override
  Color get shadowColor => KnownColors.neutral100;

  @override
  Color get errorPrimary => KnownColors.red300;

  @override
  Color get cursorColor => KnownColors.sky400;

  @override
  Color get selectionColor => KnownColors.blue500.withValues(alpha: 0.3);

  @override
  Color get selectionHandleColor => KnownColors.blue500;

  @override
  Color get navigationColor => KnownColors.neutral800;

  @override
  Color get borderPrimary => KnownColors.neutral800;

  @override
  DarkColors copyWith() => DarkColors();
}
