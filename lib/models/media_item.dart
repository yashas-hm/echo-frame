import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/metadata.dart';

class MediaItem {
  final int id;
  final bool isFavorite;
  final String filePath;
  final String? thumbnailPath;
  final Metadata meta;

  const MediaItem({
    required this.id,
    required this.isFavorite,
    required this.filePath,
    required this.meta,
    this.thumbnailPath,
  });

  factory MediaItem.fromRecord(MediaRecord r, String filePath) => MediaItem(
        id: r.id,
        isFavorite: r.isFavorite,
        filePath: filePath,
        thumbnailPath: r.thumbnailPath,
        meta: Metadata(
          capturedAt: r.capturedAt ??
              DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
          width: r.width,
          height: r.height,
          durationMs: r.durationMs,
          cameraMake: r.cameraMake,
          cameraModel: r.cameraModel,
          latitude: r.latitude,
          longitude: r.longitude,
          altitude: r.altitude,
          mediaType: MediaType.values.firstWhere(
            (m) => m.name == r.mediaType,
            orElse: () => MediaType.unknown,
          ),
        ),
      );

  DateTime get capturedAt => meta.capturedAt;

  int? get width => meta.width;

  int? get height => meta.height;

  int? get durationMs => meta.durationMs;

  String? get cameraMake => meta.cameraMake;

  String? get cameraModel => meta.cameraModel;

  double? get latitude => meta.latitude;

  double? get longitude => meta.longitude;

  double? get altitude => meta.altitude;

  MediaType get mediaType => meta.mediaType;

  bool get isVideo => meta.mediaType == MediaType.video;
}
