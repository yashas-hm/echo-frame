class TakeoutMeta {
  final String title;
  final String? description;
  final DateTime? photoTakenTime;
  final double? latitude;
  final double? longitude;

  const TakeoutMeta({
    required this.title,
    this.description,
    this.photoTakenTime,
    this.latitude,
    this.longitude,
  });

  factory TakeoutMeta.fromJson(Map<String, dynamic> json) {
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
    // geoData preferred; fall back to geoDataExif
    for (final key in ['geoData', 'geoDataExif']) {
      final geo = json[key] as Map<String, dynamic>?;
      if (geo == null) continue;
      final lat = (geo['latitude'] as num?)?.toDouble();
      final lon = (geo['longitude'] as num?)?.toDouble();
      // Takeout stores 0.0,0.0 when no GPS data exists
      if (lat != null && lon != null && (lat != 0.0 || lon != 0.0)) {
        latitude = lat;
        longitude = lon;
        break;
      }
    }

    return TakeoutMeta(
      title: json['title'] as String? ?? '',
      description: (json['description'] as String?)?.isEmpty == true
          ? null
          : json['description'] as String?,
      photoTakenTime: photoTakenTime,
      latitude: latitude,
      longitude: longitude,
    );
  }
}