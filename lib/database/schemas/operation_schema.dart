import 'package:drift/drift.dart';

class OperationRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get batchId => text()();

  TextColumn get opType => text()();

  TextColumn get sourcePath => text()();

  TextColumn get destPath => text()();

  DateTimeColumn get appliedAt => dateTime()();

  DateTimeColumn get rolledBackAt => dateTime().nullable()();

  BoolColumn get isDryRun => boolean().withDefault(const Constant(false))();
}
