import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/import_progress.dart';
import 'package:echo_frame/models/media/media.dart' show Metadata;
import 'package:echo_frame/services/metadata_service.dart';
import 'package:echo_frame/services/thumbnail_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show DirUtils;

abstract class ImportService {
  /// Reads metadata in 500-file batches. Yields a [DiscoverReading] after each
  /// batch with [result] null; the final event carries the completed map.
  Stream<DiscoverReading> fetchMetadata(List<String> paths) async* {
    if (paths.isEmpty) {
      yield DiscoverReading(done: 0, total: 0, result: {});
      return;
    }
    const kBatchSize = 500;
    final total = paths.length;
    final map = <String, Metadata>{};
    for (int offset = 0; offset < total; offset += kBatchSize) {
      final end = (offset + kBatchSize).clamp(0, total);
      final batch = paths.sublist(offset, end);
      final results = await MetadataService.readAll(batch);
      for (int i = 0; i < batch.length; i++) {
        if (results[i] != null) map[batch[i]] = results[i]!;
      }
      yield DiscoverReading(
        done: end,
        total: total,
        result: end == total ? map : null,
      );
    }
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
  /// DB writes are flushed in a single transaction every [kDbBatchSize] files.
  Stream<ImportProgress> apply({
    required DiscoveryResult plan,
    required String libraryRoot,
  }) async* {
    if (plan.items.isEmpty) return;

    const kDbBatchSize = 100;
    int imported = 0;
    final applyErrors = <DiscoveryError>[];
    final dbItems = <(Metadata, String)>[];
    final items = plan.items;
    final total = items.length;

    // Pre-create all unique destination directories once before copying.
    final uniqueDirs = {
      for (final item in items) Directory(item.destPath).parent.path,
    };
    await Future.wait(
      uniqueDirs.map(
        (d) => Directory(d).create(recursive: true).catchError((e, st) {
          dev.log(
            'Failed to create directory $d: $e',
            stackTrace: st as StackTrace,
            name: '$runtimeType.apply',
          );
          return Directory(d);
        }),
      ),
    );

    for (final item in items) {
      try {
        await File(item.mediaPath).copy(item.destPath);
      } catch (e, st) {
        dev.log(
          'Copy failed for ${item.mediaPath}: $e',
          stackTrace: st,
          name: '$runtimeType.apply',
        );
        applyErrors.add(DiscoveryError(
          sourcePath: item.mediaPath,
          reason: 'File Copy Error',
        ));
        continue;
      }

      imported++;

      if (DirUtils.isVideo(item.destPath)) {
        final thumb = await ThumbnailService.generate(item.destPath);
        if (thumb == null) {
          applyErrors.add(DiscoveryError(
            sourcePath: item.destPath,
            reason: 'Thumbnail Generation Failed',
          ));
        }
      }

      dbItems.add((item.meta, item.destPath));

      if (dbItems.length >= kDbBatchSize) {
        await _upsertDb(dbItems, libraryRoot);
        dbItems.clear();
      }

      yield ImportProgress(
        imported: imported,
        total: total,
        currentFile: item.filename,
        errors: List.unmodifiable(applyErrors),
      );
    }

    if (dbItems.isNotEmpty) await _upsertDb(dbItems, libraryRoot);
  }

  Future<void> _upsertDb(
      List<(Metadata, String)> items, String libraryRoot) async {
    try {
      await MediaDao.instance.upsertBulk(
        items.map((t) => (t.$1, t.$2, libraryRoot)).toList(),
      );
    } catch (e, st) {
      dev.log(
        'Bulk DB write failed: $e',
        stackTrace: st,
        name: '$runtimeType._flushDb',
      );
    }
  }
}
