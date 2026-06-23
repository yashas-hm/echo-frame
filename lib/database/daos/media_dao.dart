// TODO: Wrap every DAO method in try/catch (drive disconnect throws DatabaseException).
//       Return a result type — e.g. `DbResult<T>` with a `bool success` and `T? data` —
//       instead of raw futures. Update GalleryActions and UI layers to react to failures
//       (snackbar / error state) rather than silently swallowing them.
import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:echo_frame/constants/constants.dart' show Keys;
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/models/metadata.dart';
import 'package:echo_frame/models/tag.dart';
import 'package:echo_frame/services/thumbnail_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:uuid/uuid.dart';

class MediaDao {
  const MediaDao._();

  static const instance = MediaDao._();

  EchoDatabase get _db => EchoDatabase.instance;

  // ── Record → MediaItem ────────────────────────────────────────────────────

  Future<List<MediaItem>> _toItems(List<MediaRecord> records) async {
    if (records.isEmpty) return [];

    final ids = records.map((r) => r.id).toList();
    final root = Prefs.activeLibraryRoot!;

    final tagRows = await (_db.select(_db.tagRecords).join([
      innerJoin(
        _db.mediaTagRecords,
        _db.mediaTagRecords.tagId.equalsExp(_db.tagRecords.id),
      ),
    ])
          ..where(_db.mediaTagRecords.mediaId.isIn(ids)))
        .get();

    final tagsById = <String, List<Tag>>{};
    for (final row in tagRows) {
      final mediaId = row.readTable(_db.mediaTagRecords).mediaId;
      final t = row.readTable(_db.tagRecords);
      (tagsById[mediaId] ??= []).add(Tag(id: t.id, value: t.value));
    }

    return records
        .map((r) => MediaItem.fromRecord(
              r,
              '$root/${r.relativePath}',
              tagsById[r.id] ?? const [],
            ))
        .toList();
  }

  // ── Queries ───────────────────────────────────────────────────────────────

  Future<Set<String>> listFilePaths() async {
    final root = Prefs.activeLibraryRoot!;
    final rows = await (_db.selectOnly(_db.mediaRecords)
          ..addColumns([_db.mediaRecords.relativePath]))
        .get();
    return rows
        .map((r) => '$root/${r.read(_db.mediaRecords.relativePath)!}')
        .toSet();
  }

  Future<List<MediaItem>> queryPage({
    int offset = 0,
    int limit = 100,
    String? query,
    bool? isFavorite,
    bool isTrashed = false,
  }) async {
    final records = await (_db.select(_db.mediaRecords)
          ..where((r) {
            var cond = r.isTrashed.equals(isTrashed);
            if (isFavorite != null) {
              cond = cond & r.isFavorite.equals(isFavorite);
            }
            if (query != null && query.isNotEmpty) {
              final like = '%$query%';
              final tagSubquery = _db.selectOnly(_db.mediaTagRecords)
                ..addColumns([_db.mediaTagRecords.mediaId])
                ..join([
                  innerJoin(
                    _db.tagRecords,
                    _db.tagRecords.id.equalsExp(_db.mediaTagRecords.tagId),
                  ),
                ])
                ..where(_db.tagRecords.value.like(like));
              cond = cond &
                  (r.filename.like(like) |
                      r.cameraMake.like(like) |
                      r.cameraModel.like(like) |
                      r.id.isInQuery(tagSubquery));
            }
            return cond;
          })
          ..orderBy([
            (r) =>
                OrderingTerm(expression: r.capturedAt, mode: OrderingMode.desc),
          ])
          ..limit(limit, offset: offset))
        .get();
    return _toItems(records);
  }

  Future<List<MediaItem>> queryByMonth(int year, int month) async {
    final records = await (_db.select(_db.mediaRecords)
          ..where((r) =>
              r.capturedYear.equals(year) &
              r.capturedMonth.equals(month) &
              r.isTrashed.equals(false))
          ..orderBy([(r) => OrderingTerm(expression: r.capturedAt)]))
        .get();
    return _toItems(records);
  }

  Future<MediaItem?> getById(String id) async {
    final r = await (_db.select(_db.mediaRecords)
          ..where((r) => r.id.equals(id)))
        .getSingleOrNull();
    if (r == null) return null;
    return (await _toItems([r])).first;
  }

  // ── Favorites ─────────────────────────────────────────────────────────────

  Future<List<MediaItem>> listFavorites() async {
    final records = await (_db.select(_db.mediaRecords)
          ..where((r) => r.isFavorite.equals(true) & r.isTrashed.equals(false))
          ..orderBy([
            (r) => OrderingTerm(
                  expression: r.capturedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return _toItems(records);
  }

  Future<void> setFavorite(String id, {required bool value}) =>
      (_db.update(_db.mediaRecords)..where((r) => r.id.equals(id)))
          .write(MediaRecordsCompanion(isFavorite: Value(value)));

  Future<void> setTrashed(
    String id, {
    required bool value,
    required String relativePath,
  }) =>
      (_db.update(_db.mediaRecords)..where((r) => r.id.equals(id))).write(
        MediaRecordsCompanion(
          isTrashed: Value(value),
          relativePath: Value(relativePath),
        ),
      );

  Future<void> permanentDelete(String id) =>
      (_db.delete(_db.mediaRecords)..where((r) => r.id.equals(id))).go();

  // ── Writes ────────────────────────────────────────────────────────────────

  Future<void> upsertMeta(
    Metadata meta,
    String absolutePath,
    String libraryRoot,
  ) =>
      _upsertBatch([
        _toCompanion(
          meta,
          absolutePath,
          libraryRoot,
        )
      ]);

  Future<void> _upsertBatch(List<MediaRecordsCompanion> companions) =>
      _db.batch(
        (b) {
          for (final c in companions) {
            b.insert(
              _db.mediaRecords,
              c,
              onConflict: DoUpdate(
                // preserve existing id on conflict — only update metadata fields
                (old) => c.copyWith(id: const Value.absent()),
                target: [_db.mediaRecords.relativePath],
              ),
            );
          }
        },
      );

  static String? _existingThumbnail(String filePath) {
    final path = ThumbnailService.pathFor(filePath);
    return File(path).existsSync() ? path : null;
  }

  MediaRecordsCompanion _toCompanion(
    Metadata meta,
    String absolutePath,
    String libraryRoot,
  ) {
    final relativePath = absolutePath.startsWith('$libraryRoot/')
        ? absolutePath.substring(libraryRoot.length + 1)
        : absolutePath.split('/').last;
    final isTrashed = relativePath.startsWith('${Keys.trashFolderName}/');
    final jsonMap = <String, dynamic>{
      if (meta.modifiedAt != null)
        'modifiedAt': meta.modifiedAt!.toIso8601String(),
      if (meta.width != null) 'width': meta.width,
      if (meta.height != null) 'height': meta.height,
      if (meta.durationMs != null) 'durationMs': meta.durationMs,
      if (meta.latitude != null) 'latitude': meta.latitude,
      if (meta.longitude != null) 'longitude': meta.longitude,
      if (meta.altitude != null) 'altitude': meta.altitude,
    };
    final thumbnail = _existingThumbnail(absolutePath);
    if (thumbnail != null) jsonMap['thumbnailPath'] = thumbnail;
    return MediaRecordsCompanion(
      id: Value(Uuid().v4()),
      relativePath: Value(relativePath),
      filename: Value(absolutePath.split('/').last),
      mediaType: Value(meta.mediaType.name),
      capturedAt: Value(meta.capturedAt),
      capturedYear: Value(meta.capturedAt.year),
      capturedMonth: Value(meta.capturedAt.month),
      cameraMake: Value(meta.cameraMake),
      cameraModel: Value(meta.cameraModel),
      isTrashed: Value(isTrashed),
      jsonData: Value(jsonMap.isEmpty ? null : jsonEncode(jsonMap)),
    );
  }
}
