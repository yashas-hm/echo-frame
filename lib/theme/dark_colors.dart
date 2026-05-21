part of 'theme.dart';

class DarkColors extends AppThemeColors {
  const DarkColors();

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get primaryColor => KnownColors.sky400;

  @override
  Color get onPrimary => KnownColors.slate100;

  @override
  Color get secondaryColor => KnownColors.sky500;

  @override
  Color get onSecondary => KnownColors.slate100;

  @override
  Color get textPrimary => KnownColors.slate100;

  @override
  Color get textSecondary => KnownColors.slate400;

  @override
  Color get background => KnownColors.slate900;

  @override
  Color get surface => KnownColors.slate800;
  
  @override
  Color get disabledButtonColor => KnownColors.slate300;

  @override
  Color get success => KnownColors.mint400;

  @override
  Color get danger => KnownColors.apricot400;

  @override
  Color get info => KnownColors.sky500;

  @override
  Color get warning => KnownColors.gold500;

  @override
  Color get selectionColor => KnownColors.sky500.withValues(alpha: 0.3);
}
