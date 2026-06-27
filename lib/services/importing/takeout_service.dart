import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/discovery/takeout_sidecar.dart';
import 'package:echo_frame/models/folder_tree.dart';
import 'package:echo_frame/models/media/media.dart' show Metadata;
import 'package:echo_frame/services/importing/import_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show DirUtils;
import 'package:intl/intl.dart';

class TakeoutService extends ImportService {
  @override
  Stream<DiscoverEvent> discover({
    required String sourceDir,
    required String destRoot,
  }) async* {
    final allMediaPaths = <String>[];
    // mediaFilename → all sidecar full paths across the entire tree.
    // Keyed by media name (e.g. "photo.jpg") not sidecar name ("photo.jpg.json")
    // so matching is O(1) per media file instead of a linear scan.
    final jsonByMediaName = <String, List<String>>{};

    await for (final scan in DirUtils.walk(sourceDir)) {
      allMediaPaths.addAll(scan.mediaPaths);
      for (final entry in scan.jsonByName.entries) {
        final jsonName = entry.key;
        if (!jsonName.endsWith('.json')) continue;
        final mediaName = jsonName.substring(0, jsonName.length - 5);
        jsonByMediaName.putIfAbsent(mediaName, () => []).add(entry.value);
      }
      yield DiscoverScanning(
        dirName: scan.dirName,
        filesFound: allMediaPaths.length,
      );
    }

    // O(N) matching: prefer same-directory sidecar, fall back to any match.
    final sidecarPaths = <String, String>{};
    for (final mediaPath in allMediaPaths) {
      final filename = mediaPath.split('/').last;
      final candidates = jsonByMediaName[filename];
      if (candidates == null || candidates.isEmpty) continue;
      final mediaDir = mediaPath.substring(0, mediaPath.lastIndexOf('/'));
      sidecarPaths[mediaPath] = candidates.firstWhere(
        (p) => p.startsWith('$mediaDir/'),
        orElse: () => candidates.first,
      );
    }

    final sidecarMap = <String, TakeoutSidecar>{};
    for (final entry in sidecarPaths.entries) {
      final path = entry.value;
      try {
        yield DiscoverTakeoutSideCar(
          dirName: path.substring(sourceDir.length, path.lastIndexOf('/')),
          filesFound: sidecarMap.length,
        );
        final raw = await File(path).readAsString();
        final json = jsonDecode(raw) as Map<String, dynamic>;
        if (json['photoTakenTime'] != null || json['creationTime'] != null) {
          sidecarMap[entry.key] = TakeoutSidecar.fromJson(json);
        }
      } catch (e, st) {
        dev.log(
          'Failed to parse sidecar $path: $e',
          stackTrace: st,
          name: 'TakeoutService.discover',
        );
      }
    }

    yield DiscoverReading(done: 0, total: allMediaPaths.length);

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
      final sidecar = sidecarMap[mediaPath];
      final mmp = mmpByPath[mediaPath];

      if (mmp == null) {
        dev.log(
          'Skipping $mediaPath -> MMP null',
          name: 'TakeoutService.discover',
        );
        discoveryErrors.add(DiscoveryError(
          sourcePath: mediaPath,
          reason: 'File Possibly Corrupted (No Metadata)',
        ));
        continue;
      }

      final capturedAt = sidecar?.photoTakenTime ?? mmp.capturedAt;
      final year = capturedAt.year;
      final month = capturedAt.month;
      final monthName = monthFmt.format(capturedAt);
      final filename = mediaPath.split('/').last;
      final destPath =
          ImportService.resolveConflict('$destRoot/$year/$monthName/$filename');

      planned.add(DiscoveryData(
        mediaPath: mediaPath,
        destPath: destPath,
        meta: mmp.copyWith(
          capturedAt: capturedAt,
          latitude: () => sidecar?.latitude ?? mmp.latitude,
          longitude: () => sidecar?.longitude ?? mmp.longitude,
          altitude: () => sidecar?.altitude ?? mmp.altitude,
        ),
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
