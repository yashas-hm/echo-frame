import 'package:isar/isar.dart';

part 'media_schema.g.dart';

enum MediaType { image, video, unknown }

@Collection()
class MediaRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String filePath;

  late String driveId;
  late String relativePath;
  late String filename;

  @Enumerated(EnumType.name)
  late MediaType mediaType;

  @Index()
  DateTime? capturedAt;
  DateTime? modifiedAt;
  late DateTime indexedAt;

  @Index(composite: [CompositeIndex('capturedMonth')])
  int? capturedYear;
  int? capturedMonth;

  int? width;
  int? height;
  int? durationMs;

  double? latitude;
  double? longitude;

  String? cameraMake;
  String? cameraModel;

  bool isFavorite = false;
  bool isTrashed = false;
  bool hasJsonIndex = false;

  @Index(type: IndexType.value)
  String get searchText =>
      [filename, cameraMake, cameraModel].whereType<String>().join(' ');
}
