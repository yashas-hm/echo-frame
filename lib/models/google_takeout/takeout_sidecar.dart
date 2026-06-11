part of 'takeout_models.dart';

/// Metadata parsed from a Google Takeout supplemental JSON sidecar.
/// Internal to the import pipeline — not a domain model.
class TakeoutSidecar {
  final String title;
  final DateTime? photoTakenTime;
  final double? latitude;
  final double? longitude;
  final double? altitude;

  const TakeoutSidecar({
    required this.title,
    this.photoTakenTime,
    this.latitude,
    this.longitude,
    this.altitude,
  });

  factory TakeoutSidecar.fromJson(Map<String, dynamic> json) {
    DateTime? photoTakenTime;
    final takenData = json['photoTakenTime'] as Map<String, dynamic>?;
    if (takenData != null) {
      final ts = int.tryParse(takenData['timestamp'] as String? ?? '');
      if (ts != null) {
        photoTakenTime =
            DateTime.fromMillisecondsSinceEpoch(ts * 1000, isUtc: true);
      }
    }

    double? latitude;
    double? longitude;
    double? altitude;
    for (final key in ['geoData', 'geoDataExif']) {
      final geo = json[key] as Map<String, dynamic>?;
      if (geo == null) continue;
      final lat = (geo['latitude'] as num?)?.toDouble();
      final lon = (geo['longitude'] as num?)?.toDouble();
      // Takeout stores 0.0,0.0 when no GPS data exists.
      if (lat != null && lon != null && (lat != 0.0 || lon != 0.0)) {
        latitude = lat;
        longitude = lon;
        altitude = (geo['altitude'] as num?)?.toDouble();
        break;
      }
    }

    return TakeoutSidecar(
      title: json['title'] as String? ?? '',
      photoTakenTime: photoTakenTime,
      latitude: latitude,
      longitude: longitude,
      altitude: altitude,
    );
  }
}