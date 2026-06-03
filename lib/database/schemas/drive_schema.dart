import 'package:drift/drift.dart';

class DriveRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuid => text()();

  TextColumn get label => text()();

  TextColumn get lastMountPath => text().nullable()();

  DateTimeColumn get firstIndexedAt => dateTime()();

  DateTimeColumn get lastScannedAt => dateTime().nullable()();

  BoolColumn get isOnline => boolean().withDefault(const Constant(false))();

  List<Set<Column>> get uniqueColumns => [
        {uuid}
      ];
}
