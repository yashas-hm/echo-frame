class MonthCount {
  const MonthCount({
    required this.year,
    required this.month,
    required this.count,
    required this.globalOffset,
  });

  final int year;
  final int month;
  final int count;
  final int globalOffset; // sum of counts of all months before this one
}
