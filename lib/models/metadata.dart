enum MediaType { image, video, unknown }

class Metadata {
  final String path;
  final DateTime capturedAt;
  final int? width;
  final int? height;
  final int? durationMs;
  final String? cameraMake;
  final String? cameraModel;
  final double? latitude;
  final double? longitude;
  final double? altitude;
  final MediaType mediaType;

  const Metadata({
    required this.path,
    required this.capturedAt,
    this.width,
    this.height,
    this.durationMs,
    this.cameraMake,
    this.cameraModel,
    this.latitude,
    this.longitude,
    this.altitude,
    this.mediaType = MediaType.image,
  });

  factory Metadata.fallback({required String path, required DateTime mtime}) =>
      Metadata(path: path, capturedAt: mtime, mediaType: MediaType.unknown);

  factory Metadata.fromJson(Map<String, dynamic> json,
      {required String folderPath}) {
    final filename = json['filename'] as String;
    final durationMs = json['durationMs'] as int?;
    return Metadata(
      path: '$folderPath/$filename',
      capturedAt: DateTime.parse(json['capturedAt'] as String),
      width: json['width'] as int?,
      height: json['height'] as int?,
      cameraMake: json['cameraMake'] as String?,
      cameraModel: json['cameraModel'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      altitude: (json['altitude'] as num?)?.toDouble(),
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
        if (altitude != null) 'altitude': altitude,
        if (durationMs != null) 'durationMs': durationMs,
      };
}
