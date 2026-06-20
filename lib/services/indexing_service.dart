import 'dart:developer' as dev;

import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/models/indexing_progress.dart';
import 'package:echo_frame/services/metadata_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show DirUtils;

enum IndexingPhase { scanning, reading, done }

class IndexingService {
  /// Runs on every library open. Walks disk, diffs against DB, indexes only new files.
  static Stream<IndexingProgress> autoIndex({
    required String libraryRoot,
  }) async* {
    final allPaths = <String>[];
    await for (final scan in DirUtils.walk(libraryRoot)) {
      allPaths.addAll(scan.mediaPaths);
      yield IndexingProgress(
        phase: IndexingPhase.scanning,
        currentDir: scan.dirName,
        filesFound: allPaths.length,
      );
    }

    final existingPaths = await MediaDao.instance.listFilePaths();
    final newPaths = allPaths.where((p) => !existingPaths.contains(p)).toList();

    if (newPaths.isEmpty) {
      yield const IndexingProgress(phase: IndexingPhase.done);
      return;
    }

    yield IndexingProgress(
      phase: IndexingPhase.reading,
      newFiles: newPaths.length,
    );

    await _fetchAndUpsert(newPaths, libraryRoot);

    yield IndexingProgress(
      phase: IndexingPhase.done,
      newFiles: newPaths.length,
    );
  }

  /// Runs only on first connect (no echo.db found). Indexes all files.
  static Stream<IndexingProgress> fullIndex({
    required String libraryRoot,
  }) async* {
    final allPaths = <String>[];
    await for (final scan in DirUtils.walk(libraryRoot)) {
      allPaths.addAll(scan.mediaPaths);
      yield IndexingProgress(
        phase: IndexingPhase.scanning,
        currentDir: scan.dirName,
        filesFound: allPaths.length,
      );
    }

    if (allPaths.isEmpty) {
      yield const IndexingProgress(phase: IndexingPhase.done);
      return;
    }

    yield IndexingProgress(
      phase: IndexingPhase.reading,
      newFiles: allPaths.length,
    );

    await _fetchAndUpsert(allPaths, libraryRoot);

    yield IndexingProgress(
      phase: IndexingPhase.done,
      newFiles: allPaths.length,
    );
  }

  static Future<void> _fetchAndUpsert(
    List<String> paths,
    String libraryRoot,
  ) async {
    final metas = await MetadataService.readAll(paths);
    for (int i = 0; i < paths.length; i++) {
      final m = metas[i];
      if (m == null) {
        dev.log(
          'No metadata for ${paths[i]}',
          name: 'IndexingService',
        );
        continue;
      }
      try {
        await MediaDao.instance.upsertMeta(m, paths[i], libraryRoot);
      } catch (e, st) {
        dev.log(
          'upsertMeta failed for ${paths[i]}: $e',
          stackTrace: st,
          name: 'IndexingService',
        );
      }
    }
  }
}
