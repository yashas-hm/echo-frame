import 'dart:developer' as dev;

import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/folder_tree.dart';
import 'package:echo_frame/models/metadata.dart';
import 'package:echo_frame/services/importing/import_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show DirUtils;
import 'package:intl/intl.dart';

class OrganizerService extends ImportService {
  @override
  Stream<DiscoverEvent> discover({
    required String sourceDir,
    required String destRoot,
  }) async* {
    final allMediaPaths = <String>[];

    await for (final scan in DirUtils.walk(sourceDir)) {
      allMediaPaths.addAll(scan.mediaPaths);
      yield DiscoverScanning(
        dirName: scan.dirName,
        filesFound: allMediaPaths.length,
      );
    }

    var mmpByPath = <String, Metadata>{};
    await for (final reading in fetchMetadata(allMediaPaths)) {
      yield reading;
      if (reading.result != null) mmpByPath = reading.result!;
    }

    final planned = <DiscoveryData>[];
    final discoveryErrors = <DiscoveryError>[];
    final treeData = <int, Map<int, int>>{};
    final monthFmt = DateFormat('MMMM');

    for (final mediaPath in allMediaPaths) {
      final mmp = mmpByPath[mediaPath];

      if (mmp == null) {
        dev.log(
          'Skipping $mediaPath — MMP null',
          name: 'OrganizerService.discover',
        );
        discoveryErrors.add(DiscoveryError(
          sourcePath: mediaPath,
          reason: 'File Possibly Corrupted (No Metadata)',
        ));
        continue;
      }

      final year = mmp.capturedAt.year;
      final month = mmp.capturedAt.month;
      final monthName = monthFmt.format(mmp.capturedAt);
      final filename = mediaPath.split('/').last;
      final destPath =
          ImportService.resolveConflict('$destRoot/$year/$monthName/$filename');

      planned.add(DiscoveryData(
        mediaPath: mediaPath,
        destPath: destPath,
        meta: mmp,
      ));

      (treeData[year] ??= {})[month] = (treeData[year]![month] ?? 0) + 1;
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
