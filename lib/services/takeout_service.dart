import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/daos/operation_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/import_result.dart';
import 'package:echo_frame/models/month_folder.dart';
import 'package:echo_frame/models/resolved_meta.dart';
import 'package:echo_frame/models/takeout_meta.dart';
import 'package:echo_frame/services/drive_service.dart';
import 'package:echo_frame/services/library_service.dart';
import 'package:echo_frame/services/metadata_service.dart';

class ImportProgress {
  final int imported;
  final int total;
  final String? currentFile;

  const ImportProgress({
    required this.imported,
    required this.total,
    this.currentFile,
  });

  double get fraction => total == 0 ? 1.0 : imported / total;
}

class TakeoutService {
  static Future<DiscoverResult> discover(String root) async {
    final mediaPaths = <String>[];
    final jsonPaths = <String>[];

    await for (final entity in Directory(root).list(recursive: true)) {
      if (entity is! File) continue;
      final path = entity.path;
      if (path.endsWith('.json')) {
        jsonPaths.add(path);
      } else if (LibraryService.isMedia(path)) {
        mediaPaths.add(path);
      }
    }

    // Build per-directory media index: dir → { filename → absolutePath }
    final mediaByDir = <String, Map<String, String>>{};
    for (final path in mediaPaths) {
      final dir = path.substring(0, path.lastIndexOf('/'));
      final name = path.split('/').last;
      (mediaByDir[dir] ??= {})[name] = path;
    }

    final matched = <MatchedPair>[];
    final unmatched = <ImportError>[];
    final claimedMedia = <String>{};

    for (final jsonPath in jsonPaths) {
      // Parse JSON — skip if it doesn't look like a Takeout meta file
      TakeoutMeta? meta;
      try {
        final raw = await File(jsonPath).readAsString();
        final json = jsonDecode(raw) as Map<String, dynamic>;
        if (json['photoTakenTime'] == null && json['creationTime'] == null) {
          continue;
        }
        meta = TakeoutMeta.fromJson(json);
      } catch (_) {
        continue;
      }

      final jsonDir = jsonPath.substring(0, jsonPath.lastIndexOf('/'));
      final jsonFilename = jsonPath.split('/').last;
      final dirMedia = mediaByDir[jsonDir] ?? {};

      String? foundPath;

      // Strategy 1: strip ".json" suffix from sidecar name → exact match
      if (jsonFilename.endsWith('.json')) {
        final mediaName = jsonFilename.substring(0, jsonFilename.length - 5);
        foundPath = dirMedia[mediaName];
      }

      // Strategy 2: title field match (handles 46-char truncation)
      if (foundPath == null && meta.title.isNotEmpty) {
        foundPath = dirMedia[meta.title];

        if (foundPath == null) {
          final dot = meta.title.lastIndexOf('.');
          final base = dot > 0 ? meta.title.substring(0, dot) : meta.title;
          if (base.length >= 46) {
            final prefix = base.substring(0, 46);
            foundPath = dirMedia.entries
                .where((e) => e.key.startsWith(prefix))
                .map((e) => e.value)
                .firstOrNull;
          }
        }
      }

      if (foundPath != null) {
        claimedMedia.add(foundPath);
        matched.add(MatchedPair(
          mediaPath: foundPath,
          sidecarPath: jsonPath,
          meta: meta,
        ));
      } else {
        unmatched.add(ImportError(
          path: jsonPath,
          reason: 'No media file found for sidecar',
        ));
      }
    }

    // Media files with no sidecar are still importable
    for (final path in mediaPaths) {
      if (!claimedMedia.contains(path)) {
        matched.add(MatchedPair(mediaPath: path));
      }
    }

    return DiscoverResult(pairs: matched, unmatched: unmatched);
  }

  static Stream<ImportProgress> apply({
    required List<MatchedPair> pairs,
    required String libraryRoot,
    required String batchId,
  }) async* {
    if (pairs.isEmpty) return;

    final db = EchoDatabase.instance;
    final mediaDao = MediaDao(db);
    final opDao = OperationDao(db);
    final driveId = await DriveService.volumeUuid(libraryRoot);

    for (int i = 0; i < pairs.length; i++) {
      final pair = pairs[i];

      try {
        // Resolve capturedAt: Takeout timestamp > EXIF > mtime
        final exifMeta = await MetadataService.read(pair.mediaPath);
        final capturedAt = pair.meta?.photoTakenTime ?? exifMeta.capturedAt;

        final year = capturedAt.year;
        final monthName = MonthFolder.monthNames[capturedAt.month - 1];
        final rawDest = '$libraryRoot/$year/$monthName/${pair.filename}';
        final destPath = _resolveConflict(rawDest);

        // Audit log before touching files
        await opDao.insert(OperationRecordsCompanion(
          batchId: Value(batchId),
          opType: const Value('copy'),
          sourcePath: Value(pair.mediaPath),
          destPath: Value(destPath),
          appliedAt: Value(DateTime.now().toUtc()),
        ));

        await Directory(destPath).parent.create(recursive: true);
        await File(pair.mediaPath).copy(destPath);

        // Merge: Takeout GPS + timestamp > EXIF
        final mergedMeta = ResolvedMeta(
          path: destPath,
          capturedAt: capturedAt,
          width: exifMeta.width,
          height: exifMeta.height,
          durationMs: exifMeta.durationMs,
          cameraMake: exifMeta.cameraMake,
          cameraModel: exifMeta.cameraModel,
          latitude: pair.meta?.latitude ?? exifMeta.latitude,
          longitude: pair.meta?.longitude ?? exifMeta.longitude,
          mediaType: exifMeta.mediaType,
        );

        await mediaDao.upsertMeta(mergedMeta, driveId, libraryRoot);
      } catch (_) {}

      yield ImportProgress(
        imported: i + 1,
        total: pairs.length,
        currentFile: pair.filename,
      );
    }
  }

  static String _resolveConflict(String destPath) {
    if (!File(destPath).existsSync()) return destPath;
    final dot = destPath.lastIndexOf('.');
    final base = dot > 0 ? destPath.substring(0, dot) : destPath;
    final ext = dot > 0 ? destPath.substring(dot) : '';
    var i = 1;
    while (File('${base}_$i$ext').existsSync()) {
      i++;
    }
    return '${base}_$i$ext';
  }
}
