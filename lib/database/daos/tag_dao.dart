import 'package:drift/drift.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/tag.dart';
import 'package:uuid/uuid.dart';

class TagDao {
  const TagDao._();

  static const instance = TagDao._();

  EchoDatabase get _db => EchoDatabase.instance;

  static const _uuid = Uuid();

  Future<List<Tag>> listAll() async {
    final rows = await _db.select(_db.tagRecords).get();
    return rows.map((r) => Tag(uuid: r.uuid, value: r.value)).toList();
  }

  Future<Tag> createTag(String value) async {
    final tag = Tag(uuid: _uuid.v4(), value: value);
    await _db.into(_db.tagRecords).insert(
          TagRecordsCompanion.insert(uuid: tag.uuid, value: tag.value),
        );
    return tag;
  }

  Future<void> attachTag(int mediaId, String tagUuid) =>
      _db.into(_db.mediaTagRecords).insertOnConflictUpdate(
            MediaTagRecordsCompanion.insert(
              mediaId: mediaId,
              tagUuid: tagUuid,
            ),
          );

  Future<void> detachTag(int mediaId, String tagUuid) =>
      (_db.delete(_db.mediaTagRecords)
            ..where((r) =>
                r.mediaId.equals(mediaId) & r.tagUuid.equals(tagUuid)))
          .go();
}