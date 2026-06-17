class FolderTree {
  const FolderTree._(this._data);

  final Map<int, Map<int, int>> _data;

  factory FolderTree.fromMap(Map<int, Map<int, int>> data) =>
      FolderTree._(data);

  bool get isEmpty => _data.isEmpty;

  int get total => _data.values.fold(
        0,
        (sum, months) => sum + months.values.fold(0, (a, b) => a + b),
      );

  List<int> get sortedYears => _data.keys.toList()..sort();

  List<MapEntry<int, int>> sortedMonthsFor(int year) =>
      (_data[year] ?? {}).entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));

  int yearTotal(int year) =>
      (_data[year] ?? {}).values.fold(0, (a, b) => a + b);
}