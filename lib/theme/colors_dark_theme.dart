part of 'theme.dart';

class DarkColors extends AppThemeColors {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get primaryColor => KnownColors.sky300;

  @override
  Color get primarySurface => primaryColor.hover;

  @override
  Color get secondaryColor => KnownColors.sky400;

  @override
  Color get surfacePrimary => KnownColors.slate800;

  @override
  Color get background => KnownColors.slate950;

  @override
  Color get textPrimary => KnownColors.slate50;

  @override
  Color get textSecondary => KnownColors.slate300;

  @override
  Color get shadowColor => KnownColors.slate50;

  @override
  Color get errorPrimary => KnownColors.strawberry400;

  @override
  Color get errorSurface => KnownColors.strawberry300.hover;

  @override
  Color get successPrimary => KnownColors.mint300;

  @override
  Color get successSurface => KnownColors.mint300.hover;

  @override
  Color get cursorColor => KnownColors.sky400;

  @override
  Color get selectionColor => KnownColors.sky600.withValues(alpha: 0.3);

  @override
  Color get selectionHandleColor => KnownColors.sky600;

  @override
  Color get navigationColor => KnownColors.slate800;

  @override
  Color get borderPrimary => KnownColors.slate700;

  @override
  DarkColors copyWith() => DarkColors();
}
