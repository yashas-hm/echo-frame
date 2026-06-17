import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/discovery/takeout_sidecar.dart';
import 'package:echo_frame/models/folder_tree.dart';
import 'package:echo_frame/models/timeline/timeline_models.dart';
import 'package:echo_frame/services/import_service.dart';

export 'package:echo_frame/services/import_service.dart' show ImportProgress;

class TakeoutService extends ImportService {
  @override
  Stream<DiscoverEvent> discover({
    required String sourceDir,
    required String destRoot,
  }) async* {
    final allMediaPaths = <String>[];
    final sidecarMap = <String, TakeoutSidecar>{};

    await for (final scan in walkDirectories(sourceDir)) {
      yield DiscoverScanning(
          dirName: scan.dirName, filesFound: scan.totalFound);

      allMediaPaths.addAll(scan.mediaPaths);

      for (final mediaPath in scan.mediaPaths) {
        final filename = mediaPath.split('/').last;
        final sidecarEntry = scan.jsonByName.entries
            .where((j) =>
                j.key.startsWith('$filename.') && j.key.endsWith('.json'))
            .firstOrNull;

        if (sidecarEntry != null) {
          try {
            final raw = File(sidecarEntry.value).readAsStringSync();
            final json = jsonDecode(raw) as Map<String, dynamic>;
            if (json['photoTakenTime'] != null ||
                json['creationTime'] != null) {
              sidecarMap[mediaPath] = TakeoutSidecar.fromJson(json);
            }
          } catch (e, st) {
            dev.log('Failed to parse sidecar ${sidecarEntry.value}: $e',
                stackTrace: st, name: 'TakeoutService.discover');
          }
        }
      }
    }

    final mmpByPath = await fetchMetadata(allMediaPaths);

    final planned = <DiscoveryData>[];
    final discoveryErrors = <DiscoveryError>[];
    final treeData = <int, Map<String, int>>{};

    for (final mediaPath in allMediaPaths) {
      final sidecar = sidecarMap[mediaPath];
      final mmp = mmpByPath[mediaPath];

      if (mmp == null) {
        dev.log('Skipping $mediaPath — MMP null',
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
      final destPath =
          ImportService.resolveConflict('$destRoot/$year/$monthName/$filename');

      planned.add(DiscoveryData(
        mediaPath: mediaPath,
        destPath: destPath,
        meta: mmp.copyWith(
          path: destPath,
          capturedAt: capturedAt,
          latitude: () => sidecar?.latitude ?? mmp.latitude,
          longitude: () => sidecar?.longitude ?? mmp.longitude,
          altitude: () => sidecar?.altitude ?? mmp.altitude,
        ),
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
}
