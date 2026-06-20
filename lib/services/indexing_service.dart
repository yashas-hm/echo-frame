import 'dart:developer' as dev;

import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/indexing_progress.dart';
import 'package:echo_frame/services/metadata_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show DirUtils;

enum IndexingPhase { scanning, reading, done }

class IndexingService {
  /// Runs on every library open. Walks disk, diffs against DB, indexes only new files.
  static Stream<IndexingProgress> autoIndex({
    required String libraryRoot,
  }) async* {
    final db = EchoDatabase.instance;

    final allPaths = <String>[];
    await for (final scan in DirUtils.walk(libraryRoot)) {
      allPaths.addAll(scan.mediaPaths);
      yield IndexingProgress(
        phase: IndexingPhase.scanning,
        currentDir: scan.dirName,
        filesFound: allPaths.length,
      );
    }

    final existingPaths = await MediaDao(db).listFilePaths();
    final newPaths = allPaths.where((p) => !existingPaths.contains(p)).toList();

    if (newPaths.isEmpty) {
      yield const IndexingProgress(phase: IndexingPhase.done);
      return;
    }

    yield IndexingProgress(
      phase: IndexingPhase.reading,
      newFiles: newPaths.length,
    );

    await _fetchAndUpsert(newPaths, db, libraryRoot);

    yield IndexingProgress(
      phase: IndexingPhase.done,
      newFiles: newPaths.length,
    );
  }

  /// Runs only on first connect (no echo.db found). Indexes all files.
  static Stream<IndexingProgress> fullIndex({
    required String libraryRoot,
  }) async* {
    final db = EchoDatabase.instance;

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

    await _fetchAndUpsert(allPaths, db, libraryRoot);

    yield IndexingProgress(
      phase: IndexingPhase.done,
      newFiles: allPaths.length,
    );
  }

  static Future<void> _fetchAndUpsert(
    List<String> paths,
    EchoDatabase db,
    String libraryRoot,
  ) async {
    final metas = await MetadataService.readAll(paths);
    final mediaDao = MediaDao(db);
    for (int i = 0; i < paths.length; i++) {
      final m = metas[i];
      if (m == null) {
        dev.log('No metadata for ${paths[i]}', name: 'IndexingService');
        continue;
      }
      try {
        await mediaDao.upsertMeta(m, libraryRoot);
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
