import 'package:drift/drift.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media/media.dart' show Tag;
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

  Future<Map<String, List<Tag>>> fetchForMediaIds(List<String> ids) async {
    if (ids.isEmpty) return {};
    final rows = await (_db.select(_db.tagRecords).join([
      innerJoin(
        _db.mediaTagRecords,
        _db.mediaTagRecords.tagId.equalsExp(_db.tagRecords.id),
      ),
    ])
          ..where(_db.mediaTagRecords.mediaId.isIn(ids)))
        .get();

    final tagsById = <String, List<Tag>>{};
    for (final row in rows) {
      final mediaId = row.readTable(_db.mediaTagRecords).mediaId;
      final t = row.readTable(_db.tagRecords);
      (tagsById[mediaId] ??= []).add(Tag(id: t.id, value: t.value));
    }
    return tagsById;
  }
}
