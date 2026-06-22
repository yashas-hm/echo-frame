import 'dart:convert';

import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/metadata.dart';
import 'package:echo_frame/models/tag.dart';
import 'package:flutter/foundation.dart';

class MediaItem {
  final String id;
  final bool isFavorite;
  final bool isTrashed;
  final String filePath;
  final String? thumbnailPath;
  final List<Tag> tags;
  final Metadata _meta;

  const MediaItem({
    required this.id,
    required this.isFavorite,
    required this.isTrashed,
    required this.filePath,
    required Metadata meta,
    this.thumbnailPath,
    this.tags = const [],
  }) : _meta = meta;

  factory MediaItem.fromRecord(
    MediaRecord r,
    String filePath,
    List<Tag> tags,
  ) {
    final j = r.jsonData != null
        ? jsonDecode(r.jsonData!) as Map<String, dynamic>
        : const <String, dynamic>{};
    return MediaItem(
      id: r.id,
      isFavorite: r.isFavorite,
      isTrashed: r.isTrashed,
      filePath: filePath,
      thumbnailPath: j['thumbnailPath'] as String?,
      tags: tags,
      meta: Metadata(
        capturedAt:
            r.capturedAt ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
        modifiedAt: j['modifiedAt'] != null
            ? DateTime.parse(j['modifiedAt'] as String)
            : null,
        width: j['width'] as int?,
        height: j['height'] as int?,
        durationMs: j['durationMs'] as int?,
        cameraMake: r.cameraMake,
        cameraModel: r.cameraModel,
        latitude: (j['latitude'] as num?)?.toDouble(),
        longitude: (j['longitude'] as num?)?.toDouble(),
        altitude: (j['altitude'] as num?)?.toDouble(),
        mediaType: MediaType.values.firstWhere(
          (m) => m.name == r.mediaType,
          orElse: () => MediaType.unknown,
        ),
      ),
    );
  }

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

  MediaItem copyWith({
    bool? isFavorite,
    bool? isTrashed,
    String? filePath,
    ValueGetter<String?>? thumbnailPath,
    List<Tag>? tags,
    Metadata? meta,
  }) =>
      MediaItem(
        id: id,
        isFavorite: isFavorite ?? this.isFavorite,
        isTrashed: isTrashed ?? this.isTrashed,
        filePath: filePath ?? this.filePath,
        thumbnailPath:
            thumbnailPath != null ? thumbnailPath() : this.thumbnailPath,
        tags: tags ?? this.tags,
        meta: meta ?? _meta,
      );
}
