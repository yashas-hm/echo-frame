import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/metadata.dart';
import 'package:echo_frame/models/tag.dart';

class MediaItem {
  final int id;
  final bool isFavorite;
  final String filePath;
  final String? thumbnailPath;
  final List<Tag> tags;
  final Metadata _meta;

  const MediaItem({
    required this.id,
    required this.isFavorite,
    required this.filePath,
    required Metadata meta,
    this.thumbnailPath,
    this.tags = const [],
  }) : _meta = meta;

  factory MediaItem.fromRecord(
    MediaRecord r,
    String filePath,
    List<Tag> tags,
  ) =>
      MediaItem(
        id: r.id,
        isFavorite: r.isFavorite,
        filePath: filePath,
        thumbnailPath: r.thumbnailPath,
        tags: tags,
        meta: Metadata(
          capturedAt: r.capturedAt ??
              DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
          modifiedAt: r.modifiedAt,
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

  DateTime get capturedAt => _meta.capturedAt;

  DateTime? get modifiedAt => _meta.modifiedAt;

  int? get width => _meta.width;

  int? get height => _meta.height;

  int? get durationMs => _meta.durationMs;

  String? get cameraMake => _meta.cameraMake;

  String? get cameraModel => _meta.cameraModel;

  double? get latitude => _meta.latitude;

  double? get longitude => _meta.longitude;

  double? get altitude => _meta.altitude;

  MediaType get mediaType => _meta.mediaType;

  bool get isVideo => _meta.mediaType == MediaType.video;
}