part of 'theme.dart';

class LightColors extends AppThemeColors {
  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primaryColor => KnownColors.sky400;

  @override
  Color get secondaryColor => KnownColors.sky500;

  @override
  Color get surfacePrimary => KnownColors.slate200;

  @override
  Color get background => KnownColors.slate50;

  @override
  Color get textPrimary => KnownColors.slate950;

  @override
  Color get textSecondary => KnownColors.slate500;

  @override
  Color get shadowColor => KnownColors.slate950;

  @override
  Color get errorPrimary => KnownColors.strawberry500;

  @override
  Color get errorSurface => KnownColors.strawberry100;

  @override
  Color get success => KnownColors.mint400;

  @override
  Color get successSurface => KnownColors.mint100;

  @override
  Color get cursorColor => KnownColors.sky200;

  @override
  Color get selectionColor => KnownColors.sky600.withValues(alpha: 0.3);

  @override
  Color get selectionHandleColor => KnownColors.sky600;

  @override
  Color get navigationColor => KnownColors.slate200;

  @override
  Color get borderPrimary => KnownColors.slate300;

  @override
  LightColors copyWith() => LightColors();
}
