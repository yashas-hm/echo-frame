import 'dart:io';

import 'package:drift/drift.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/media_item.dart';
import 'package:echo_frame/models/metadata.dart';
import 'package:echo_frame/services/thumbnail_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;

// ── Timeline queries ──────────────────────────────────────────────────────────

class MediaDao {
  const MediaDao(this._db);

  final EchoDatabase _db;

  static MediaItem toItem(MediaRecord r) =>
      MediaItem.fromRecord(r, '${Prefs.libraryRootPath!}/${r.relativePath}');

  Future<void> upsertBatch(List<MediaRecordsCompanion> companions) async {
    await _db.batch((b) {
      for (final c in companions) {
        b.insert(_db.mediaRecords, c, onConflict: DoUpdate((old) => c));
      }
    });
  }

  Future<Set<String>> listFilePaths() async {
    final root = Prefs.libraryRootPath!;
    final rows = await (_db.selectOnly(_db.mediaRecords)
          ..addColumns([_db.mediaRecords.relativePath]))
        .get();
    return rows
        .map((r) => '$root/${r.read(_db.mediaRecords.relativePath)!}')
        .toSet();
  }

  Future<List<({int year, int month, int count})>> listMonths() async {
    final countExpr = countAll();
    final query = _db.selectOnly(_db.mediaRecords)
      ..addColumns([
        _db.mediaRecords.capturedYear,
        _db.mediaRecords.capturedMonth,
        countExpr,
      ])
      ..where(_db.mediaRecords.isTrashed.equals(false) &
          _db.mediaRecords.capturedYear.isNotNull())
      ..groupBy([
        _db.mediaRecords.capturedYear,
        _db.mediaRecords.capturedMonth,
      ])
      ..orderBy([
        OrderingTerm(
            expression: _db.mediaRecords.capturedYear, mode: OrderingMode.desc),
        OrderingTerm(
            expression: _db.mediaRecords.capturedMonth,
            mode: OrderingMode.desc),
      ]);

    return query
        .map((row) => (
              year: row.read(_db.mediaRecords.capturedYear) ?? 0,
              month: row.read(_db.mediaRecords.capturedMonth) ?? 0,
              count: row.read(countExpr) ?? 0,
            ))
        .get();
  }

  Future<List<MediaRecord>> queryByMonth(int year, int month) =>
      (_db.select(_db.mediaRecords)
            ..where((r) =>
                r.capturedYear.equals(year) &
                r.capturedMonth.equals(month) &
                r.isTrashed.equals(false))
            ..orderBy([
              (r) => OrderingTerm(expression: r.capturedAt),
            ]))
          .get();

  Future<MediaRecord?> getById(int id) =>
      (_db.select(_db.mediaRecords)..where((r) => r.id.equals(id)))
          .getSingleOrNull();

  Future<List<MediaRecord>> queryPage({
    int offset = 0,
    int limit = 100,
    String? query,
  }) {
    return (_db.select(_db.mediaRecords)
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
  }

  // ── Favorites ─────────────────────────────────────────────────────────────

  Future<List<MediaRecord>> listFavorites() => (_db.select(_db.mediaRecords)
        ..where((r) => r.isFavorite.equals(true) & r.isTrashed.equals(false))
        ..orderBy([
          (r) =>
              OrderingTerm(expression: r.capturedAt, mode: OrderingMode.desc),
        ]))
      .get();

  Future<void> setFavorite(int id, {required bool value}) =>
      (_db.update(_db.mediaRecords)..where((r) => r.id.equals(id)))
          .write(MediaRecordsCompanion(isFavorite: Value(value)));

  Future<void> upsertMeta(
          Metadata meta, String absolutePath, String libraryRoot) =>
      upsertBatch([_toCompanion(meta, absolutePath, libraryRoot)]);

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
