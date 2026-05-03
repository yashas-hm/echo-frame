class EchoExifData {
  EchoExifData({
    required this.id,
    required this.title,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.modifiedAt,
    this.faces,
  });

  String id;
  String title;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? modifiedAt;
  List<String>? faces;
}
