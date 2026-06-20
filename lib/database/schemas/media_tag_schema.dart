import 'package:drift/drift.dart';
import 'package:echo_frame/database/schemas/media_schema.dart';
import 'package:echo_frame/database/schemas/tag_schema.dart';

class MediaTagRecords extends Table {
  TextColumn get mediaId => text().references(MediaRecords, #id)();

  TextColumn get tagId => text().references(TagRecords, #id)();

  @override
  Set<Column> get primaryKey => {mediaId, tagId};
}
