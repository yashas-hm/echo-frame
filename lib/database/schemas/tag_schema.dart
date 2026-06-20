import 'package:drift/drift.dart';

class TagRecords extends Table {
  TextColumn get uuid => text()();

  TextColumn get value => text().unique()();

  @override
  Set<Column> get primaryKey => {uuid};
}
