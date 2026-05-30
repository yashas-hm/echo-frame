import 'dart:io';

import 'package:echo_frame/models/resolved_meta.dart';
import 'package:media_metadata_plus/media_metadata_plus.dart';

class MetadataService {
  static Future<ResolvedMeta> read(String filePath) async {
    final mtime = File(filePath).statSync().modified.toUtc();
    final meta = await MediaMetadata.read(filePath);
    return meta != null ? _fromPlugin(filePath, meta, mtime) : ResolvedMeta.fallback(path: filePath, mtime: mtime);
  }

  // Rust/Rayon handles parallelism internally — no compute() needed.
  static Future<List<ResolvedMeta?>> readAll(List<String> paths) async {
    if (paths.isEmpty) return [];
    final mtimes = {for (final p in paths) p: File(p).statSync().modified.toUtc()};
    final metas = await MediaMetadata.readAll(paths);
    return [
      for (int i = 0; i < paths.length; i++)
        metas[i] != null
            ? _fromPlugin(paths[i], metas[i]!, mtimes[paths[i]]!)
            : ResolvedMeta.fallback(path: paths[i], mtime: mtimes[paths[i]]!),
    ];
  }

  static ResolvedMeta _fromPlugin(String path, MediaMetadata meta, DateTime mtime) =>
      ResolvedMeta(
        path: path,
        capturedAt: meta.capturedAt ?? mtime,
        width: meta.width,
        height: meta.height,
        durationMs: meta.duration?.inMilliseconds,
        cameraMake: meta.cameraMake,
        cameraModel: meta.cameraModel,
        latitude: meta.gps?.lat,
        longitude: meta.gps?.lon,
        mediaType: meta.duration != null ? MediaType.video : MediaType.image,
      );
}
