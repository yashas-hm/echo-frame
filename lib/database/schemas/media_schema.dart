import 'package:drift/drift.dart';

class MediaRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get filePath => text()();

  TextColumn get driveId => text()();

  TextColumn get relativePath => text()();

  TextColumn get filename => text()();

  TextColumn get mediaType => text().withDefault(const Constant('image'))();

  DateTimeColumn get capturedAt => dateTime().nullable()();

  DateTimeColumn get modifiedAt => dateTime().nullable()();

  DateTimeColumn get indexedAt => dateTime()();

  IntColumn get capturedYear => integer().nullable()();

  IntColumn get capturedMonth => integer().nullable()();

  IntColumn get width => integer().nullable()();

  IntColumn get height => integer().nullable()();

  IntColumn get durationMs => integer().nullable()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();

  RealColumn get altitude => real().nullable()();

  TextColumn get cameraMake => text().nullable()();

  TextColumn get cameraModel => text().nullable()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  BoolColumn get isTrashed => boolean().withDefault(const Constant(false))();

  BoolColumn get hasJsonIndex => boolean().withDefault(const Constant(false))();

  List<Set<Column>> get uniqueColumns => [
        {filePath}
      ];
}
