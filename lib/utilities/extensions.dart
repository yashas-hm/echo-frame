part of 'utilities.dart';

extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  bool get isDark => MediaQuery.of(this).platformBrightness == Brightness.dark;
}
