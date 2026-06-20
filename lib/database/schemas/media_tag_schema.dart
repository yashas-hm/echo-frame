import 'package:drift/drift.dart';
import 'package:echo_frame/database/schemas/tag_schema.dart';

class MediaTagRecords extends Table {
  IntColumn get mediaId => integer()();

  TextColumn get tagUuid => text().references(TagRecords, #uuid)();

  @override
  Set<Column> get primaryKey => {mediaId, tagUuid};
}
