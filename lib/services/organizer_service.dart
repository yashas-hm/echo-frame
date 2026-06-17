import 'dart:developer' as dev;

import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/folder_tree.dart';
import 'package:echo_frame/models/timeline/timeline_models.dart';
import 'package:echo_frame/services/import_service.dart';

class OrganizerService extends ImportService {
  @override
  Stream<DiscoverEvent> discover({
    required String sourceDir,
    required String destRoot,
  }) async* {
    final allMediaPaths = <String>[];

    await for (final scan in walkDirectories(sourceDir)) {
      yield DiscoverScanning(
          dirName: scan.dirName, filesFound: scan.totalFound);
      allMediaPaths.addAll(scan.mediaPaths);
    }

    final mmpByPath = await fetchMetadata(allMediaPaths);

    final planned = <DiscoveryData>[];
    final discoveryErrors = <DiscoveryError>[];
    final treeData = <int, Map<String, int>>{};

    for (final mediaPath in allMediaPaths) {
      final mmp = mmpByPath[mediaPath];

      if (mmp == null) {
        dev.log('Skipping $mediaPath — MMP null',
            name: 'OrganizerService.discover');
        discoveryErrors.add(DiscoveryError(
          sourcePath: mediaPath,
          reason: 'File Possibly Corrupted (No Metadata)',
        ));
        continue;
      }

      final year = mmp.capturedAt.year;
      final monthName = MonthFolder.monthNames[mmp.capturedAt.month - 1];
      final filename = mediaPath.split('/').last;
      final destPath =
          ImportService.resolveConflict('$destRoot/$year/$monthName/$filename');

      planned.add(DiscoveryData(
        mediaPath: mediaPath,
        destPath: destPath,
        meta: mmp.copyWith(path: destPath),
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