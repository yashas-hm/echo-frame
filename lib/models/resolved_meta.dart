enum MediaType { image, video, unknown }

class ResolvedMeta {
  final String path;
  final DateTime capturedAt;
  final int? width;
  final int? height;
  final int? durationMs;
  final String? cameraMake;
  final String? cameraModel;
  final double? latitude;
  final double? longitude;
  final MediaType mediaType;

  const ResolvedMeta({
    required this.path,
    required this.capturedAt,
    this.width,
    this.height,
    this.durationMs,
    this.cameraMake,
    this.cameraModel,
    this.latitude,
    this.longitude,
    this.mediaType = MediaType.image,
  });

  factory ResolvedMeta.fallback(
          {required String path, required DateTime mtime}) =>
      ResolvedMeta(path: path, capturedAt: mtime, mediaType: MediaType.unknown);

  factory ResolvedMeta.fromJson(Map<String, dynamic> json,
      {required String folderPath}) {
    final filename = json['filename'] as String;
    final durationMs = json['durationMs'] as int?;
    return ResolvedMeta(
      path: '$folderPath/$filename',
      capturedAt: DateTime.parse(json['capturedAt'] as String),
      width: json['width'] as int?,
      height: json['height'] as int?,
      cameraMake: json['cameraMake'] as String?,
      cameraModel: json['cameraModel'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      durationMs: durationMs,
      mediaType: durationMs != null ? MediaType.video : MediaType.image,
    );
  }

  Map<String, dynamic> toJson() => {
        'filename': path.split('/').last,
        'capturedAt': capturedAt.toIso8601String(),
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (cameraMake != null) 'cameraMake': cameraMake,
        if (cameraModel != null) 'cameraModel': cameraModel,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        if (durationMs != null) 'durationMs': durationMs,
      };
}
