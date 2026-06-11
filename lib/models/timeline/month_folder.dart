part of 'timeline_models.dart';

class MonthFolder implements Comparable<MonthFolder> {
  static const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final int year;
  final int month;
  final String path;

  const MonthFolder(
      {required this.year, required this.month, required this.path});

  String get monthName => monthNames[month - 1];

  @override
  int compareTo(MonthFolder other) {
    final yearCmp = year.compareTo(other.year);
    return yearCmp != 0 ? yearCmp : month.compareTo(other.month);
  }
}
