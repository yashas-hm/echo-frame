import 'package:drift/drift.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/tag.dart';
import 'package:uuid/uuid.dart';

class TagDao {
  const TagDao._();

  static const instance = TagDao._();

  EchoDatabase get _db => EchoDatabase.instance;

  Future<List<Tag>> listAll() async {
    final rows = await _db.select(_db.tagRecords).get();
    return rows.map((r) => Tag(id: r.id, value: r.value)).toList();
  }

  Future<Tag> createTag(String value) async {
    final tag = Tag(id: Uuid().v4(), value: value);
    await _db.into(_db.tagRecords).insert(
          TagRecordsCompanion.insert(id: tag.id, value: tag.value),
        );
    return tag;
  }

  Future<void> attachTag(String mediaId, String tagId) =>
      _db.into(_db.mediaTagRecords).insertOnConflictUpdate(
            MediaTagRecordsCompanion.insert(
              mediaId: mediaId,
              tagId: tagId,
            ),
          );

  Future<void> detachTag(String mediaId, String tagId) =>
      (_db.delete(_db.mediaTagRecords)
            ..where((r) => r.mediaId.equals(mediaId) & r.tagId.equals(tagId)))
          .go();
}
