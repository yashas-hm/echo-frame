part of 'utilities.dart';

extension ContextExtensions on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  bool get isDark => MediaQuery.of(this).platformBrightness == Brightness.dark;

  AppThemeColors get colors => Theme.of(this).extension<AppThemeColors>()!;
}

extension DurationExtensions on int {
  Duration get milliseconds => Duration(milliseconds: this);
}

extension StringExtensions on String {
  String plural(int value) => '$this${value == 1 ? '' : 's'}';
}
