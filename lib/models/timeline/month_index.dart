part of 'timeline_models.dart';

class MonthIndex {
  final int version;
  final DateTime generatedAt;
  final int year;
  final int month;
  final List<Map<String, dynamic>> items;

  const MonthIndex({
    required this.version,
    required this.generatedAt,
    required this.year,
    required this.month,
    required this.items,
  });

  factory MonthIndex.fromJson(Map<String, dynamic> json) => MonthIndex(
        version: json['version'] as int,
        generatedAt: DateTime.parse(json['generatedAt'] as String),
        year: json['year'] as int,
        month: json['month'] as int,
        items: (json['items'] as List).cast<Map<String, dynamic>>(),
      );

  Map<String, dynamic> toJson() => {
        'version': version,
        'generatedAt': generatedAt.toIso8601String(),
        'year': year,
        'month': month,
        'items': items,
      };
}
