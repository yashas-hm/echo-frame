import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/metadata.dart';

class MediaItem {
  final int id;
  final bool isFavorite;
  final Metadata meta;

  const MediaItem({
    required this.id,
    required this.isFavorite,
    required this.meta,
  });

  factory MediaItem.fromRecord(MediaRecord r) => MediaItem(
        id: r.id,
        isFavorite: r.isFavorite,
        meta: Metadata(
          path: r.filePath,
          capturedAt: r.capturedAt ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
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

  // Convenience accessors — delegates to meta so UI call sites are unchanged.
  String get filePath => meta.path;
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
