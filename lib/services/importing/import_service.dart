import 'dart:collection';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/metadata.dart';
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

/// Per-directory result yielded by [ImportService.walkDirectories].
class DirectoryScan {
  const DirectoryScan({
    required this.dirName,
    required this.totalFound,
    required this.mediaPaths,
    required this.jsonByName,
  });

  /// Display name of this directory (last path segment).
  final String dirName;

  /// Running total of media files found across all directories so far.
  final int totalFound;

  /// Media files found in this directory.
  final List<String> mediaPaths;

  /// JSON files in this directory keyed by filename — for sidecar lookup.
  final Map<String, String> jsonByName;
}

abstract class ImportService {
  /// BFS walk of [sourceDir]. Yields one [DirectoryScan] per directory,
  /// including media paths and JSON filenames for that directory.
  Stream<DirectoryScan> walkDirectories(String sourceDir) async* {
    int totalFound = 0;
    final queue = Queue<Directory>()..add(Directory(sourceDir));

    while (queue.isNotEmpty) {
      final dir = queue.removeFirst();

      List<FileSystemEntity> entries;
      try {
        entries = dir.listSync();
      } catch (e, st) {
        dev.log('Failed to list ${dir.path}: $e',
            stackTrace: st, name: '$runtimeType.walkDirectories');
        continue;
      }

      final mediaPaths = <String>[];
      final jsonByName = <String, String>{};

      for (final e in entries) {
        if (e is! File) continue;
        if (e.path.endsWith('.json')) {
          jsonByName[e.path.split('/').last] = e.path;
        } else if (LibraryService.isMedia(e.path)) {
          mediaPaths.add(e.path);
        }
      }

      totalFound += mediaPaths.length;
      yield DirectoryScan(
        dirName: dir.path.split('/').last,
        totalFound: totalFound,
        mediaPaths: mediaPaths,
        jsonByName: jsonByName,
      );

      for (final e in entries) {
        if (e is Directory) queue.add(e);
      }
    }
  }

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
    final driveId = await DriveService.volumeUuid(libraryRoot);

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
        if (LibraryService.isVideo(item.destPath)) {
          await ThumbnailService.generate(item.destPath);
        }
        await mediaDao.upsertMeta(item.meta, driveId, libraryRoot);
      } catch (e, st) {
        dev.log('Post-copy failed for ${item.destPath}: $e',
            stackTrace: st, name: '$runtimeType.apply');
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