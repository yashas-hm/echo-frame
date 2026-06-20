import 'package:drift/drift.dart';

class MediaRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get relativePath => text()();

  TextColumn get filename => text()();

  TextColumn get mediaType => text().withDefault(const Constant('image'))();

  DateTimeColumn get capturedAt => dateTime().nullable()();

  IntColumn get capturedYear => integer().nullable()();

  IntColumn get capturedMonth => integer().nullable()();

  TextColumn get cameraMake => text().nullable()();

  TextColumn get cameraModel => text().nullable()();

  TextColumn get jsonData => text().nullable()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  BoolColumn get isTrashed => boolean().withDefault(const Constant(false))();

  List<Set<Column>> get uniqueColumns => [
        {relativePath}
      ];
}
