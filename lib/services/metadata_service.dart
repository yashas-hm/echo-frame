import 'dart:io';

import 'package:echo_frame/models/metadata.dart';
import 'package:media_metadata_plus/media_metadata_plus.dart';

class MetadataService {
  static Future<Metadata> read(String filePath) async {
    final mtime = File(filePath).statSync().modified.toUtc();
    final meta = await MediaMetadata.read(filePath);
    return meta != null
        ? _fromPlugin(filePath, meta, mtime)
        : Metadata.fallback(path: filePath, mtime: mtime);
  }

  // Rust/Rayon handles parallelism internally — no compute() needed.
  static Future<List<Metadata?>> readAll(List<String> paths) async {
    if (paths.isEmpty) return [];
    final mtimes = {
      for (final p in paths) p: File(p).statSync().modified.toUtc()
    };
    final metas = await MediaMetadata.readAll(paths);
    return [
      for (int i = 0; i < paths.length; i++)
        metas[i] != null
            ? _fromPlugin(paths[i], metas[i]!, mtimes[paths[i]]!)
            : Metadata.fallback(path: paths[i], mtime: mtimes[paths[i]]!),
    ];
  }

  static Metadata _fromPlugin(
          String path, MediaMetadata meta, DateTime mtime) =>
      Metadata(
        path: path,
        capturedAt: meta.capturedAt ?? mtime,
        width: meta.width,
        height: meta.height,
        durationMs: meta.duration?.inMilliseconds,
        cameraMake: meta.cameraMake,
        cameraModel: meta.cameraModel,
        latitude: meta.gps?.lat,
        longitude: meta.gps?.lon,
        altitude: meta.gps?.alt,
        mediaType: meta.duration != null ? MediaType.video : MediaType.image,
      );
}
