import 'dart:io';

import 'package:echo_frame/models/media/media.dart' show Metadata, MediaType;
import 'package:media_metadata_plus/media_metadata_plus.dart';

class MetadataService {
  static Future<Metadata> read(String filePath) async {
    final mtime = File(filePath).statSync().modified.toUtc();
    final meta = await MediaMetadata.read(filePath);
    return meta != null
        ? _fromPlugin(meta, mtime, filePath)
        : Metadata.fallback(mtime: mtime, path: filePath);
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
            ? _fromPlugin(metas[i]!, mtimes[paths[i]]!, paths[i])
            : Metadata.fallback(mtime: mtimes[paths[i]]!, path: paths[i]),
    ];
  }

  static Metadata _fromPlugin(MediaMetadata meta, DateTime mtime, String path) =>
      Metadata(
        capturedAt: meta.capturedAt ?? mtime,
        modifiedAt: meta.modifiedAt,
        width: meta.width,
        height: meta.height,
        durationMs: meta.duration?.inMilliseconds,
        cameraMake: meta.cameraMake,
        cameraModel: meta.cameraModel,
        latitude: meta.gps?.lat,
        longitude: meta.gps?.lon,
        altitude: meta.gps?.alt,
        mediaType: MediaType.fromPath(path),
      );
}
