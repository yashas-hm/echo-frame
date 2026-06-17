import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/daos/operation_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/folder_tree.dart';
import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/discovery/takeout_sidecar.dart';
import 'package:echo_frame/models/metadata.dart';
import 'package:echo_frame/models/timeline/timeline_models.dart';
import 'package:echo_frame/services/drive_service.dart';
import 'package:echo_frame/services/library_service.dart';
import 'package:echo_frame/services/metadata_service.dart';
import 'package:echo_frame/services/thumbnail_service.dart';

class ImportProgress {
  const ImportProgress({
    required this.imported,
    required this.total,
    this.currentFile,
    this.errors = const [],
  });

  final int imported;
  final int total;
  final String? currentFile;
  final List<DiscoveryError> errors;

  int get processed => imported + errors.length;
  double get fraction => total == 0 ? 1.0 : processed / total;
}

class TakeoutService {
  static Stream<DiscoverEvent> discover({
    required String takeoutDir,
    required String libraryRoot,
  }) async* {
    final allMediaPaths = <String>[];
    final sidecarMap = <String, TakeoutSidecar>{};

    // BFS walk: yield scanning events per directory.
    final queue = Queue<Directory>()..add(Directory(takeoutDir));

    while (queue.isNotEmpty) {
      final dir = queue.removeFirst();
      final dirName = dir.path.split('/').last;

      yield DiscoverScanning(dirName: dirName, filesFound: allMediaPaths.length);

      List<FileSystemEntity> entries;
      try {
        entries = dir.listSync();
      } catch (e, st) {
        dev.log('Failed to list directory ${dir.path}: $e',
            stackTrace: st, name: 'TakeoutService.discover');
        continue;
      }

      // Index JSON files by their filename for O(1) sidecar lookup.
      final jsonByName = <String, String>{};
      for (final e in entries) {
        if (e is File && e.path.endsWith('.json')) {
          jsonByName[e.path.split('/').last] = e.path;
        }
      }

      for (final e in entries) {
        if (e is! File) continue;
        final mediaPath = e.path;
        if (!LibraryService.isMedia(mediaPath)) continue;

        allMediaPaths.add(mediaPath);

        final filename = mediaPath.split('/').last;
        // Sidecar: any file named `<filename>.<anything>.json` in the same dir.
        final sidecarEntry = jsonByName.entries
            .where((j) => j.key.startsWith('$filename.') && j.key.endsWith('.json'))
            .firstOrNull;

        if (sidecarEntry != null) {
          try {
            final raw = File(sidecarEntry.value).readAsStringSync();
            final json = jsonDecode(raw) as Map<String, dynamic>;
            if (json['photoTakenTime'] != null || json['creationTime'] != null) {
              sidecarMap[mediaPath] = TakeoutSidecar.fromJson(json);
            }
          } catch (e, st) {
            dev.log('Failed to parse sidecar ${sidecarEntry.value}: $e',
                stackTrace: st, name: 'TakeoutService.discover');
          }
        }
      }

      for (final e in entries) {
        if (e is Directory) queue.add(e);
      }
    }

    // Single batched FFI call for all media — MMP provides dimensions, duration,
    // camera make/model, and media type regardless of whether a sidecar exists.
    final mmpResults = await MetadataService.readAll(allMediaPaths);
    final mmpByPath = <String, Metadata>{};
    for (int i = 0; i < allMediaPaths.length; i++) {
      if (mmpResults[i] != null) mmpByPath[allMediaPaths[i]] = mmpResults[i]!;
    }

    // Build PlannedImports and FolderTree.
    // Files MMP couldn't read are recorded as discovery errors and excluded.
    final planned = <DiscoveryData>[];
    final discoveryErrors = <DiscoveryError>[];
    final treeData = <int, Map<String, int>>{};

    for (final mediaPath in allMediaPaths) {
      final sidecar = sidecarMap[mediaPath];
      final mmp = mmpByPath[mediaPath];

      if (mmp == null) {
        dev.log('Skipping $mediaPath — MMP returned null (possibly corrupted)',
            name: 'TakeoutService.discover');
        discoveryErrors.add(DiscoveryError(
          sourcePath: mediaPath,
          reason: 'File Possibly Corrupted (No Metadata)',
        ));
        continue;
      }

      final capturedAt = sidecar?.photoTakenTime ?? mmp.capturedAt;

      final year = capturedAt.year;
      final monthName = MonthFolder.monthNames[capturedAt.month - 1];
      final filename = mediaPath.split('/').last;
      final rawDest = '$libraryRoot/$year/$monthName/$filename';
      final destPath = _resolveConflict(rawDest);

      final mergedMeta = Metadata(
        path: destPath,
        capturedAt: capturedAt,
        width: mmp.width,
        height: mmp.height,
        durationMs: mmp.durationMs,
        cameraMake: mmp.cameraMake,
        cameraModel: mmp.cameraModel,
        latitude: sidecar?.latitude ?? mmp.latitude,
        longitude: sidecar?.longitude ?? mmp.longitude,
        altitude: sidecar?.altitude ?? mmp.altitude,
        mediaType: mmp.mediaType,
      );

      planned.add(DiscoveryData(
        mediaPath: mediaPath,
        destPath: destPath,
        meta: mergedMeta,
      ));

      (treeData[year] ??= {})[monthName] =
          (treeData[year]![monthName] ?? 0) + 1;
    }

    yield DiscoverDone(
      plan: DiscoveryResult(
        items: planned,
        tree: FolderTree.fromMap(treeData),
        errors: discoveryErrors,
      ),
    );
  }

  static Stream<ImportProgress> apply({
    required DiscoveryResult plan,
    required String libraryRoot,
    required String batchId,
  }) async* {
    if (plan.items.isEmpty) return;

    final db = EchoDatabase.instance;
    final mediaDao = MediaDao(db);
    final opDao = OperationDao(db);
    final driveId = await DriveService.volumeUuid(libraryRoot);

    int imported = 0;
    final applyErrors = <DiscoveryError>[];

    for (final item in plan.items) {
      // Copy is the only fatal operation — skip the file if it fails.
      try {
        await Directory(item.destPath).parent.create(recursive: true);
        await File(item.mediaPath).copy(item.destPath);
      } catch (e, st) {
        dev.log('Copy failed for ${item.mediaPath}: $e',
            stackTrace: st, name: 'TakeoutService.apply');
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

      // Best-effort: DB write and thumbnail after successful copy.
      try {
        await opDao.insert(OperationRecordsCompanion(
          batchId: Value(batchId),
          opType: const Value('copy'),
          sourcePath: Value(item.mediaPath),
          destPath: Value(item.destPath),
          appliedAt: Value(DateTime.now().toUtc()),
        ));
        if (LibraryService.isVideo(item.destPath)) {
          await ThumbnailService.generate(item.destPath);
        }
        await mediaDao.upsertMeta(item.meta, driveId, libraryRoot);
      } catch (e, st) {
        dev.log('Post-copy operations failed for ${item.destPath}: $e',
            stackTrace: st, name: 'TakeoutService.apply');
      }

      yield ImportProgress(
        imported: imported,
        total: plan.items.length,
        currentFile: item.filename,
        errors: List.unmodifiable(applyErrors),
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