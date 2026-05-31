import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/resolved_meta.dart';

class MediaItem {
  final int id;
  final String filePath;
  final DateTime? capturedAt;
  final int? width;
  final int? height;
  final int? durationMs;
  final String? cameraMake;
  final String? cameraModel;
  final double? latitude;
  final double? longitude;
  final bool isFavorite;
  final MediaType mediaType;

  const MediaItem({
    required this.id,
    required this.filePath,
    required this.mediaType,
    this.capturedAt,
    this.width,
    this.height,
    this.durationMs,
    this.cameraMake,
    this.cameraModel,
    this.latitude,
    this.longitude,
    this.isFavorite = false,
  });

  factory MediaItem.fromRecord(MediaRecord r) => MediaItem(
        id: r.id,
        filePath: r.filePath,
        capturedAt: r.capturedAt,
        width: r.width,
        height: r.height,
        durationMs: r.durationMs,
        cameraMake: r.cameraMake,
        cameraModel: r.cameraModel,
        latitude: r.latitude,
        longitude: r.longitude,
        isFavorite: r.isFavorite,
        mediaType: MediaType.values.firstWhere(
          (m) => m.name == r.mediaType,
          orElse: () => MediaType.unknown,
        ),
      );

  bool get isVideo => mediaType == MediaType.video;
}
