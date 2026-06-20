import 'dart:io';

import 'package:drift/drift.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/models/metadata.dart';
import 'package:echo_frame/models/tag.dart';
import 'package:echo_frame/services/thumbnail_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;

class MediaDao {
  const MediaDao._();

  static const instance = MediaDao._();

  EchoDatabase get _db => EchoDatabase.instance;

  // ── Record → MediaItem ────────────────────────────────────────────────────

  Future<List<MediaItem>> _toItems(List<MediaRecord> records) async {
    if (records.isEmpty) return [];

    final ids = records.map((r) => r.id).toList();
    final root = Prefs.libraryRootPath!;

    final tagRows = await (_db.select(_db.tagRecords).join([
      innerJoin(
        _db.mediaTagRecords,
        _db.mediaTagRecords.tagUuid.equalsExp(_db.tagRecords.uuid),
      ),
    ])
          ..where(_db.mediaTagRecords.mediaId.isIn(ids)))
        .get();

    final tagsByMediaId = <int, List<Tag>>{};
    for (final row in tagRows) {
      final mediaId = row.readTable(_db.mediaTagRecords).mediaId;
      final t = row.readTable(_db.tagRecords);
      (tagsByMediaId[mediaId] ??= []).add(Tag(uuid: t.uuid, value: t.value));
    }

    return records
        .map((r) => MediaItem.fromRecord(
              r,
              '$root/${r.relativePath}',
              tagsByMediaId[r.id] ?? const [],
            ))
        .toList();
  }

  // ── Queries ───────────────────────────────────────────────────────────────

  Future<Set<String>> listFilePaths() async {
    final root = Prefs.libraryRootPath!;
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
  }) async {
    final records = await (_db.select(_db.mediaRecords)
          ..where((r) {
            var cond = r.isTrashed.equals(false);
            if (query != null && query.isNotEmpty) {
              final like = '%$query%';
              cond = cond &
                  (r.filename.like(like) |
                      r.cameraMake.like(like) |
                      r.cameraModel.like(like));
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

  Future<MediaItem?> getById(int id) async {
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
            (r) =>
                OrderingTerm(expression: r.capturedAt, mode: OrderingMode.desc),
          ]))
        .get();
    return _toItems(records);
  }

  Future<void> setFavorite(int id, {required bool value}) =>
      (_db.update(_db.mediaRecords)..where((r) => r.id.equals(id)))
          .write(MediaRecordsCompanion(isFavorite: Value(value)));

  // ── Writes ────────────────────────────────────────────────────────────────

  Future<void> upsertMeta(
    Metadata meta,
    String absolutePath,
    String libraryRoot,
  ) =>
      _upsertBatch([_toCompanion(meta, absolutePath, libraryRoot)]);

  Future<void> _upsertBatch(List<MediaRecordsCompanion> companions) =>
      _db.batch((b) {
        for (final c in companions) {
          b.insert(_db.mediaRecords, c, onConflict: DoUpdate((old) => c));
        }
      });

  static String? _existingThumbnail(String filePath) {
    final path = ThumbnailService.pathFor(filePath);
    return File(path).existsSync() ? path : null;
  }

  MediaRecordsCompanion _toCompanion(
      Metadata meta, String absolutePath, String libraryRoot) {
    final relativePath = absolutePath.startsWith('$libraryRoot/')
        ? absolutePath.substring(libraryRoot.length + 1)
        : absolutePath.split('/').last;
    return MediaRecordsCompanion(
      relativePath: Value(relativePath),
      filename: Value(absolutePath.split('/').last),
      mediaType: Value(meta.mediaType.name),
      capturedAt: Value(meta.capturedAt),
      modifiedAt: Value(meta.modifiedAt),
      indexedAt: Value(DateTime.now().toUtc()),
      capturedYear: Value(meta.capturedAt.year),
      capturedMonth: Value(meta.capturedAt.month),
      width: Value(meta.width),
      height: Value(meta.height),
      durationMs: Value(meta.durationMs),
      latitude: Value(meta.latitude),
      longitude: Value(meta.longitude),
      altitude: Value(meta.altitude),
      cameraMake: Value(meta.cameraMake),
      cameraModel: Value(meta.cameraModel),
      thumbnailPath: Value(_existingThumbnail(absolutePath)),
      hasJsonIndex: const Value(true),
    );
  }
}
