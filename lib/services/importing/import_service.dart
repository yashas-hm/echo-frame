import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/import/import.dart' show ImportProgress;
import 'package:echo_frame/models/metadata.dart';
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

  Future<List<bool>> _copyBatch(List<DiscoveryData> items) =>
      Future.wait(items.map((item) async {
        try {
          await File(item.mediaPath).copy(item.destPath);
          return true;
        } catch (e, st) {
          dev.log(
            'Copy failed for ${item.mediaPath}: $e',
            stackTrace: st,
            name: '$runtimeType._copyBatch',
          );
          return false;
        }
      }));

  /// Shared apply — copies files, writes DB records, generates thumbnails.
  /// Copy is the only fatal step; DB/thumbnail failures are logged and skipped.
  ///
  /// Copies run [kCopyConcurrency] at a time. The next batch's copies are fired
  /// immediately after the current batch's results arrive, so file I/O overlaps
  /// with sequential FFmpeg thumbnail generation. DB writes are batched into a
  /// single transaction at the end to avoid 12k individual SQLite commits.
  Stream<ImportProgress> apply({
    required DiscoveryResult plan,
    required String libraryRoot,
  }) async* {
    if (plan.items.isEmpty) return;

    const kCopyConcurrency = 8;
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

    // Pipeline: kick off the first batch before the loop so the next batch's
    // copies always run concurrently with thumbnail generation (FFmpeg stays
    // single-threaded within the sequential inner loop).
    var batchStart = 0;
    var pendingCopy = _copyBatch(items.sublist(0, kCopyConcurrency.clamp(0, total)));

    while (batchStart < total) {
      final batchEnd = (batchStart + kCopyConcurrency).clamp(0, total);
      final batch = items.sublist(batchStart, batchEnd);
      final copyOk = await pendingCopy;

      // Fire next batch immediately before processing thumbnails.
      final nextStart = batchEnd;
      if (nextStart < total) {
        final nextEnd = (nextStart + kCopyConcurrency).clamp(0, total);
        pendingCopy = _copyBatch(items.sublist(nextStart, nextEnd));
      }

      for (int i = 0; i < batch.length; i++) {
        final item = batch[i];
        if (!copyOk[i]) {
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
      }

      yield ImportProgress(
        imported: imported,
        total: total,
        currentFile: batch.last.filename,
        errors: List.unmodifiable(applyErrors),
      );

      batchStart = nextStart;
    }

    // Single SQLite transaction for all successful copies.
    if (dbItems.isNotEmpty) {
      try {
        await MediaDao.instance.upsertBulk(
          dbItems.map((t) => (t.$1, t.$2, libraryRoot)).toList(),
        );
      } catch (e, st) {
        dev.log(
          'Bulk DB write failed: $e',
          stackTrace: st,
          name: '$runtimeType.apply',
        );
      }
    }
  }
}