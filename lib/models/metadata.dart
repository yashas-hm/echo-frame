import 'package:flutter/foundation.dart' show ValueGetter;

enum MediaType { image, video, unknown }

class Metadata {
  final DateTime capturedAt;
  final DateTime? modifiedAt;
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
    required this.capturedAt,
    this.modifiedAt,
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

  factory Metadata.fallback({required DateTime mtime}) => Metadata(
        capturedAt: mtime,
        mediaType: MediaType.unknown,
      );

  factory Metadata.fromJson(Map<String, dynamic> json) {
    final durationMs = json['durationMs'] as int?;
    return Metadata(
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

  Metadata copyWith({
    DateTime? capturedAt,
    ValueGetter<DateTime?>? modifiedAt,
    ValueGetter<int?>? width,
    ValueGetter<int?>? height,
    ValueGetter<int?>? durationMs,
    ValueGetter<String?>? cameraMake,
    ValueGetter<String?>? cameraModel,
    ValueGetter<double?>? latitude,
    ValueGetter<double?>? longitude,
    ValueGetter<double?>? altitude,
    MediaType? mediaType,
  }) =>
      Metadata(
        capturedAt: capturedAt ?? this.capturedAt,
        modifiedAt: modifiedAt != null ? modifiedAt() : this.modifiedAt,
        width: width != null ? width() : this.width,
        height: height != null ? height() : this.height,
        durationMs: durationMs != null ? durationMs() : this.durationMs,
        cameraMake: cameraMake != null ? cameraMake() : this.cameraMake,
        cameraModel: cameraModel != null ? cameraModel() : this.cameraModel,
        latitude: latitude != null ? latitude() : this.latitude,
        longitude: longitude != null ? longitude() : this.longitude,
        altitude: altitude != null ? altitude() : this.altitude,
        mediaType: mediaType ?? this.mediaType,
      );

  Map<String, dynamic> toJson({required String filename}) => {
        'filename': filename,
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
