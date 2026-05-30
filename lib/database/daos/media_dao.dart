import 'package:drift/drift.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/month_folder.dart';
import 'package:echo_frame/models/month_index.dart';
import 'package:echo_frame/models/resolved_meta.dart';

class MediaDao {
  const MediaDao(this._db);

  final EchoDatabase _db;

  Future<void> upsertBatch(List<MediaRecordsCompanion> companions) async {
    await _db.batch((b) {
      for (final c in companions) {
        b.insert(_db.mediaRecords, c, onConflict: DoUpdate((old) => c));
      }
    });
  }

  Future<void> upsertFromIndex({
    required MonthIndex index,
    required MonthFolder folder,
    required String driveId,
    required String libraryRoot,
  }) async {
    final companions = index.items
        .map((item) => _toCompanion(
              ResolvedMeta.fromJson(item, folderPath: folder.path),
              driveId,
              libraryRoot,
            ))
        .toList();
    await upsertBatch(companions);
  }

  MediaRecordsCompanion _toCompanion(
    ResolvedMeta meta,
    String driveId,
    String libraryRoot,
  ) {
    final relativePath = meta.path.startsWith('$libraryRoot/')
        ? meta.path.substring(libraryRoot.length + 1)
        : meta.path.split('/').last;
    return MediaRecordsCompanion(
      filePath: Value(meta.path),
      driveId: Value(driveId),
      relativePath: Value(relativePath),
      filename: Value(meta.path.split('/').last),
      mediaType: Value(meta.mediaType.name),
      capturedAt: Value(meta.capturedAt),
      indexedAt: Value(DateTime.now().toUtc()),
      capturedYear: Value(meta.capturedAt.year),
      capturedMonth: Value(meta.capturedAt.month),
      width: Value(meta.width),
      height: Value(meta.height),
      durationMs: Value(meta.durationMs),
      latitude: Value(meta.latitude),
      longitude: Value(meta.longitude),
      cameraMake: Value(meta.cameraMake),
      cameraModel: Value(meta.cameraModel),
      hasJsonIndex: const Value(true),
    );
  }
}
