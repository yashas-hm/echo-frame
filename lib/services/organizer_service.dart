import 'dart:io';

import 'package:drift/drift.dart';
import 'package:echo_frame/database/daos/operation_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/month_folder.dart';
import 'package:echo_frame/models/organizer_result.dart';
import 'package:echo_frame/services/library_service.dart';
import 'package:echo_frame/services/metadata_service.dart';

class OrganizerProgress {
  final int applied;
  final int total;
  final String? currentFile;

  const OrganizerProgress({
    required this.applied,
    required this.total,
    this.currentFile,
  });

  double get fraction => total == 0 ? 1.0 : applied / total;
}

class OrganizerService {
  static Future<List<OperationResult>> preview({
    required String sourceDir,
    required String destRoot,
  }) async {
    final files = <String>[];
    await for (final entity in Directory(sourceDir).list(recursive: true)) {
      if (entity is File && LibraryService.isMedia(entity.path)) {
        files.add(entity.path);
      }
    }

    if (files.isEmpty) return [];

    final metas = await MetadataService.readAll(files);
    final results = <OperationResult>[];

    for (int i = 0; i < files.length; i++) {
      final meta = metas[i];
      if (meta == null) continue;

      final year = meta.capturedAt.year;
      final monthName = MonthFolder.monthNames[meta.capturedAt.month - 1];
      final filename = files[i].split('/').last;

      final rawDest = '$destRoot/$year/$monthName/$filename';
      final resolvedDest = _resolveConflict(rawDest);
      final destFilename = resolvedDest.split('/').last;

      results.add(OperationResult(
        sourcePath: files[i],
        destPath: resolvedDest,
        destRelative: '$year/$monthName/$destFilename',
        hasConflict: resolvedDest != rawDest,
      ));
    }

    results.sort((a, b) => a.destRelative.compareTo(b.destRelative));
    return results;
  }

  static Stream<OrganizerProgress> apply({
    required List<OperationResult> operations,
    required String batchId,
  }) async* {
    if (operations.isEmpty) return;

    final dao = OperationDao(EchoDatabase.instance);

    for (int i = 0; i < operations.length; i++) {
      final op = operations[i];

      await dao.insert(OperationRecordsCompanion(
        batchId: Value(batchId),
        opType: const Value('move'),
        sourcePath: Value(op.sourcePath),
        destPath: Value(op.destPath),
        appliedAt: Value(DateTime.now().toUtc()),
      ));

      await Directory(op.destPath).parent.create(recursive: true);
      await File(op.sourcePath).rename(op.destPath);

      yield OrganizerProgress(
        applied: i + 1,
        total: operations.length,
        currentFile: op.filename,
      );
    }
  }

  static Future<int> rollback(String batchId) async {
    final dao = OperationDao(EchoDatabase.instance);
    final records = await dao.getByBatchId(batchId);
    int count = 0;

    for (final record in records.reversed.toList()) {
      if (record.rolledBackAt != null) continue;
      try {
        final src = File(record.destPath);
        if (await src.exists()) {
          await Directory(record.sourcePath).parent.create(recursive: true);
          await src.rename(record.sourcePath);
          count++;
        }
      } catch (_) {}
    }

    await dao.markRolledBack(batchId);
    return count;
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
