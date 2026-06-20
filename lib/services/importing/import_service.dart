import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/import/import.dart' show ImportProgress;
import 'package:echo_frame/models/metadata.dart';
import 'package:echo_frame/services/metadata_service.dart';
import 'package:echo_frame/services/thumbnail_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show DirUtils;

abstract class ImportService {
  /// Batch MMP call. Returns a map of path → Metadata (null results excluded).
  Future<Map<String, Metadata>> fetchMetadata(List<String> paths) async {
    final results = await MetadataService.readAll(paths);
    final map = <String, Metadata>{};
    for (int i = 0; i < paths.length; i++) {
      if (results[i] != null) map[paths[i]] = results[i]!;
    }
    return map;
  }

  /// Appends a numeric suffix to avoid overwriting an existing file.
  static String resolveConflict(String destPath) {
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

  /// Subclasses implement their own walk + metadata enrichment.
  Stream<DiscoverEvent> discover({
    required String sourceDir,
    required String destRoot,
  });

  /// Shared apply — copies files, writes DB records, generates thumbnails.
  /// Copy is the only fatal step; DB/thumbnail failures are logged and skipped.
  Stream<ImportProgress> apply({
    required DiscoveryResult plan,
    required String libraryRoot,
  }) async* {
    if (plan.items.isEmpty) return;

    final db = EchoDatabase.instance;
    final mediaDao = MediaDao(db);

    int imported = 0;
    final applyErrors = <DiscoveryError>[];

    for (final item in plan.items) {
      try {
        await Directory(item.destPath).parent.create(recursive: true);
        await File(item.mediaPath).copy(item.destPath);
      } catch (e, st) {
        dev.log('Copy failed for ${item.mediaPath}: $e',
            stackTrace: st, name: '$runtimeType.apply');
        applyErrors.add(DiscoveryError(
          sourcePath: item.mediaPath,
          reason: 'File Copy Error',
        ));
        yield ImportProgress(
          imported: imported,
          total: plan.items.length,
          currentFile: item.filename,
          errors: List.unmodifiable(applyErrors),
        );
        continue;
      }

      imported++;

      try {
        if (DirUtils.isVideo(item.destPath)) {
          await ThumbnailService.generate(item.destPath);
        }
        await mediaDao.upsertMeta(item.meta, item.destPath, libraryRoot);
      } catch (e, st) {
        dev.log(
          'Post-copy failed for ${item.destPath}: $e',
          stackTrace: st,
          name: '$runtimeType.apply',
        );
      }

      yield ImportProgress(
        imported: imported,
        total: plan.items.length,
        currentFile: item.filename,
        errors: List.unmodifiable(applyErrors),
      );
    }
  }
}
