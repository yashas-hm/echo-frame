part of 'theme.dart';

class LightColors extends AppThemeColors {
  const LightColors();

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primaryColor => KnownColors.sky300;

  @override
  Color get onPrimary => KnownColors.slate100;

  @override
  Color get secondaryColor => KnownColors.sky400;

  @override
  Color get onSecondary => KnownColors.slate100;

  @override
  Color get textPrimary => KnownColors.slate900;

  @override
  Color get textSecondary => KnownColors.slate500;

  @override
  Color get background => KnownColors.slate100;

  @override
  Color get surface => KnownColors.slate200;

  @override
  Color get disabledButtonColor => KnownColors.slate700;

  @override
  Color get success => KnownColors.mint600;

  @override
  Color get danger => KnownColors.apricot500;

  @override
  Color get info => KnownColors.sky500;

  @override
  Color get warning => KnownColors.gold500;

  @override
  Color get selectionColor => KnownColors.sky500.withValues(alpha: 0.3);
}
