// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MediaRecordsTable extends MediaRecords
    with TableInfo<$MediaRecordsTable, MediaRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relativePathMeta =
      const VerificationMeta('relativePath');
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
      'relative_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filenameMeta =
      const VerificationMeta('filename');
  @override
  late final GeneratedColumn<String> filename = GeneratedColumn<String>(
      'filename', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mediaTypeMeta =
      const VerificationMeta('mediaType');
  @override
  late final GeneratedColumn<String> mediaType = GeneratedColumn<String>(
      'media_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('image'));
  static const VerificationMeta _capturedAtMeta =
      const VerificationMeta('capturedAt');
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
      'captured_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _modifiedAtMeta =
      const VerificationMeta('modifiedAt');
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
      'modified_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _indexedAtMeta =
      const VerificationMeta('indexedAt');
  @override
  late final GeneratedColumn<DateTime> indexedAt = GeneratedColumn<DateTime>(
      'indexed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _capturedYearMeta =
      const VerificationMeta('capturedYear');
  @override
  late final GeneratedColumn<int> capturedYear = GeneratedColumn<int>(
      'captured_year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _capturedMonthMeta =
      const VerificationMeta('capturedMonth');
  @override
  late final GeneratedColumn<int> capturedMonth = GeneratedColumn<int>(
      'captured_month', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
      'width', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _durationMsMeta =
      const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
      'duration_ms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _altitudeMeta =
      const VerificationMeta('altitude');
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
      'altitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cameraMakeMeta =
      const VerificationMeta('cameraMake');
  @override
  late final GeneratedColumn<String> cameraMake = GeneratedColumn<String>(
      'camera_make', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cameraModelMeta =
      const VerificationMeta('cameraModel');
  @override
  late final GeneratedColumn<String> cameraModel = GeneratedColumn<String>(
      'camera_model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _thumbnailPathMeta =
      const VerificationMeta('thumbnailPath');
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
      'thumbnail_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isTrashedMeta =
      const VerificationMeta('isTrashed');
  @override
  late final GeneratedColumn<bool> isTrashed = GeneratedColumn<bool>(
      'is_trashed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_trashed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasJsonIndexMeta =
      const VerificationMeta('hasJsonIndex');
  @override
  late final GeneratedColumn<bool> hasJsonIndex = GeneratedColumn<bool>(
      'has_json_index', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_json_index" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        filePath,
        relativePath,
        filename,
        mediaType,
        capturedAt,
        modifiedAt,
        indexedAt,
        capturedYear,
        capturedMonth,
        width,
        height,
        durationMs,
        latitude,
        longitude,
        altitude,
        cameraMake,
        cameraModel,
        thumbnailPath,
        isFavorite,
        isTrashed,
        hasJsonIndex
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_records';
  @override
  VerificationContext validateIntegrity(Insertable<MediaRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
          _relativePathMeta,
          relativePath.isAcceptableOrUnknown(
              data['relative_path']!, _relativePathMeta));
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename']!, _filenameMeta));
    } else if (isInserting) {
      context.missing(_filenameMeta);
    }
    if (data.containsKey('media_type')) {
      context.handle(_mediaTypeMeta,
          mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta));
    }
    if (data.containsKey('captured_at')) {
      context.handle(
          _capturedAtMeta,
          capturedAt.isAcceptableOrUnknown(
              data['captured_at']!, _capturedAtMeta));
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at']!, _modifiedAtMeta));
    }
    if (data.containsKey('indexed_at')) {
      context.handle(_indexedAtMeta,
          indexedAt.isAcceptableOrUnknown(data['indexed_at']!, _indexedAtMeta));
    } else if (isInserting) {
      context.missing(_indexedAtMeta);
    }
    if (data.containsKey('captured_year')) {
      context.handle(
          _capturedYearMeta,
          capturedYear.isAcceptableOrUnknown(
              data['captured_year']!, _capturedYearMeta));
    }
    if (data.containsKey('captured_month')) {
      context.handle(
          _capturedMonthMeta,
          capturedMonth.isAcceptableOrUnknown(
              data['captured_month']!, _capturedMonthMeta));
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('altitude')) {
      context.handle(_altitudeMeta,
          altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta));
    }
    if (data.containsKey('camera_make')) {
      context.handle(
          _cameraMakeMeta,
          cameraMake.isAcceptableOrUnknown(
              data['camera_make']!, _cameraMakeMeta));
    }
    if (data.containsKey('camera_model')) {
      context.handle(
          _cameraModelMeta,
          cameraModel.isAcceptableOrUnknown(
              data['camera_model']!, _cameraModelMeta));
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
          _thumbnailPathMeta,
          thumbnailPath.isAcceptableOrUnknown(
              data['thumbnail_path']!, _thumbnailPathMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('is_trashed')) {
      context.handle(_isTrashedMeta,
          isTrashed.isAcceptableOrUnknown(data['is_trashed']!, _isTrashedMeta));
    }
    if (data.containsKey('has_json_index')) {
      context.handle(
          _hasJsonIndexMeta,
          hasJsonIndex.isAcceptableOrUnknown(
              data['has_json_index']!, _hasJsonIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      relativePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}relative_path'])!,
      filename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filename'])!,
      mediaType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_type'])!,
      capturedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}captured_at']),
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at']),
      indexedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}indexed_at'])!,
      capturedYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}captured_year']),
      capturedMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}captured_month']),
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}width']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height']),
      durationMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_ms']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      altitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}altitude']),
      cameraMake: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera_make']),
      cameraModel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera_model']),
      thumbnailPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail_path']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      isTrashed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_trashed'])!,
      hasJsonIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_json_index'])!,
    );
  }

  @override
  $MediaRecordsTable createAlias(String alias) {
    return $MediaRecordsTable(attachedDatabase, alias);
  }
}

class MediaRecord extends DataClass implements Insertable<MediaRecord> {
  final int id;
  final String filePath;
  final String relativePath;
  final String filename;
  final String mediaType;
  final DateTime? capturedAt;
  final DateTime? modifiedAt;
  final DateTime indexedAt;
  final int? capturedYear;
  final int? capturedMonth;
  final int? width;
  final int? height;
  final int? durationMs;
  final double? latitude;
  final double? longitude;
  final double? altitude;
  final String? cameraMake;
  final String? cameraModel;
  final String? thumbnailPath;
  final bool isFavorite;
  final bool isTrashed;
  final bool hasJsonIndex;
  const MediaRecord(
      {required this.id,
      required this.filePath,
      required this.relativePath,
      required this.filename,
      required this.mediaType,
      this.capturedAt,
      this.modifiedAt,
      required this.indexedAt,
      this.capturedYear,
      this.capturedMonth,
      this.width,
      this.height,
      this.durationMs,
      this.latitude,
      this.longitude,
      this.altitude,
      this.cameraMake,
      this.cameraModel,
      this.thumbnailPath,
      required this.isFavorite,
      required this.isTrashed,
      required this.hasJsonIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_path'] = Variable<String>(filePath);
    map['relative_path'] = Variable<String>(relativePath);
    map['filename'] = Variable<String>(filename);
    map['media_type'] = Variable<String>(mediaType);
    if (!nullToAbsent || capturedAt != null) {
      map['captured_at'] = Variable<DateTime>(capturedAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<DateTime>(modifiedAt);
    }
    map['indexed_at'] = Variable<DateTime>(indexedAt);
    if (!nullToAbsent || capturedYear != null) {
      map['captured_year'] = Variable<int>(capturedYear);
    }
    if (!nullToAbsent || capturedMonth != null) {
      map['captured_month'] = Variable<int>(capturedMonth);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<double>(altitude);
    }
    if (!nullToAbsent || cameraMake != null) {
      map['camera_make'] = Variable<String>(cameraMake);
    }
    if (!nullToAbsent || cameraModel != null) {
      map['camera_model'] = Variable<String>(cameraModel);
    }
    if (!nullToAbsent || thumbnailPath != null) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_trashed'] = Variable<bool>(isTrashed);
    map['has_json_index'] = Variable<bool>(hasJsonIndex);
    return map;
  }

  MediaRecordsCompanion toCompanion(bool nullToAbsent) {
    return MediaRecordsCompanion(
      id: Value(id),
      filePath: Value(filePath),
      relativePath: Value(relativePath),
      filename: Value(filename),
      mediaType: Value(mediaType),
      capturedAt: capturedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(capturedAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      indexedAt: Value(indexedAt),
      capturedYear: capturedYear == null && nullToAbsent
          ? const Value.absent()
          : Value(capturedYear),
      capturedMonth: capturedMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(capturedMonth),
      width:
          width == null && nullToAbsent ? const Value.absent() : Value(width),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      cameraMake: cameraMake == null && nullToAbsent
          ? const Value.absent()
          : Value(cameraMake),
      cameraModel: cameraModel == null && nullToAbsent
          ? const Value.absent()
          : Value(cameraModel),
      thumbnailPath: thumbnailPath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailPath),
      isFavorite: Value(isFavorite),
      isTrashed: Value(isTrashed),
      hasJsonIndex: Value(hasJsonIndex),
    );
  }

  factory MediaRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaRecord(
      id: serializer.fromJson<int>(json['id']),
      filePath: serializer.fromJson<String>(json['filePath']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      filename: serializer.fromJson<String>(json['filename']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      capturedAt: serializer.fromJson<DateTime?>(json['capturedAt']),
      modifiedAt: serializer.fromJson<DateTime?>(json['modifiedAt']),
      indexedAt: serializer.fromJson<DateTime>(json['indexedAt']),
      capturedYear: serializer.fromJson<int?>(json['capturedYear']),
      capturedMonth: serializer.fromJson<int?>(json['capturedMonth']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      altitude: serializer.fromJson<double?>(json['altitude']),
      cameraMake: serializer.fromJson<String?>(json['cameraMake']),
      cameraModel: serializer.fromJson<String?>(json['cameraModel']),
      thumbnailPath: serializer.fromJson<String?>(json['thumbnailPath']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isTrashed: serializer.fromJson<bool>(json['isTrashed']),
      hasJsonIndex: serializer.fromJson<bool>(json['hasJsonIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'filePath': serializer.toJson<String>(filePath),
      'relativePath': serializer.toJson<String>(relativePath),
      'filename': serializer.toJson<String>(filename),
      'mediaType': serializer.toJson<String>(mediaType),
      'capturedAt': serializer.toJson<DateTime?>(capturedAt),
      'modifiedAt': serializer.toJson<DateTime?>(modifiedAt),
      'indexedAt': serializer.toJson<DateTime>(indexedAt),
      'capturedYear': serializer.toJson<int?>(capturedYear),
      'capturedMonth': serializer.toJson<int?>(capturedMonth),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'durationMs': serializer.toJson<int?>(durationMs),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'altitude': serializer.toJson<double?>(altitude),
      'cameraMake': serializer.toJson<String?>(cameraMake),
      'cameraModel': serializer.toJson<String?>(cameraModel),
      'thumbnailPath': serializer.toJson<String?>(thumbnailPath),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isTrashed': serializer.toJson<bool>(isTrashed),
      'hasJsonIndex': serializer.toJson<bool>(hasJsonIndex),
    };
  }

  MediaRecord copyWith(
          {int? id,
          String? filePath,
          String? relativePath,
          String? filename,
          String? mediaType,
          Value<DateTime?> capturedAt = const Value.absent(),
          Value<DateTime?> modifiedAt = const Value.absent(),
          DateTime? indexedAt,
          Value<int?> capturedYear = const Value.absent(),
          Value<int?> capturedMonth = const Value.absent(),
          Value<int?> width = const Value.absent(),
          Value<int?> height = const Value.absent(),
          Value<int?> durationMs = const Value.absent(),
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          Value<double?> altitude = const Value.absent(),
          Value<String?> cameraMake = const Value.absent(),
          Value<String?> cameraModel = const Value.absent(),
          Value<String?> thumbnailPath = const Value.absent(),
          bool? isFavorite,
          bool? isTrashed,
          bool? hasJsonIndex}) =>
      MediaRecord(
        id: id ?? this.id,
        filePath: filePath ?? this.filePath,
        relativePath: relativePath ?? this.relativePath,
        filename: filename ?? this.filename,
        mediaType: mediaType ?? this.mediaType,
        capturedAt: capturedAt.present ? capturedAt.value : this.capturedAt,
        modifiedAt: modifiedAt.present ? modifiedAt.value : this.modifiedAt,
        indexedAt: indexedAt ?? this.indexedAt,
        capturedYear:
            capturedYear.present ? capturedYear.value : this.capturedYear,
        capturedMonth:
            capturedMonth.present ? capturedMonth.value : this.capturedMonth,
        width: width.present ? width.value : this.width,
        height: height.present ? height.value : this.height,
        durationMs: durationMs.present ? durationMs.value : this.durationMs,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        altitude: altitude.present ? altitude.value : this.altitude,
        cameraMake: cameraMake.present ? cameraMake.value : this.cameraMake,
        cameraModel: cameraModel.present ? cameraModel.value : this.cameraModel,
        thumbnailPath:
            thumbnailPath.present ? thumbnailPath.value : this.thumbnailPath,
        isFavorite: isFavorite ?? this.isFavorite,
        isTrashed: isTrashed ?? this.isTrashed,
        hasJsonIndex: hasJsonIndex ?? this.hasJsonIndex,
      );
  MediaRecord copyWithCompanion(MediaRecordsCompanion data) {
    return MediaRecord(
      id: data.id.present ? data.id.value : this.id,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      filename: data.filename.present ? data.filename.value : this.filename,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      capturedAt:
          data.capturedAt.present ? data.capturedAt.value : this.capturedAt,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
      indexedAt: data.indexedAt.present ? data.indexedAt.value : this.indexedAt,
      capturedYear: data.capturedYear.present
          ? data.capturedYear.value
          : this.capturedYear,
      capturedMonth: data.capturedMonth.present
          ? data.capturedMonth.value
          : this.capturedMonth,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      durationMs:
          data.durationMs.present ? data.durationMs.value : this.durationMs,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      cameraMake:
          data.cameraMake.present ? data.cameraMake.value : this.cameraMake,
      cameraModel:
          data.cameraModel.present ? data.cameraModel.value : this.cameraModel,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      isTrashed: data.isTrashed.present ? data.isTrashed.value : this.isTrashed,
      hasJsonIndex: data.hasJsonIndex.present
          ? data.hasJsonIndex.value
          : this.hasJsonIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaRecord(')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('relativePath: $relativePath, ')
          ..write('filename: $filename, ')
          ..write('mediaType: $mediaType, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('indexedAt: $indexedAt, ')
          ..write('capturedYear: $capturedYear, ')
          ..write('capturedMonth: $capturedMonth, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('durationMs: $durationMs, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitude: $altitude, ')
          ..write('cameraMake: $cameraMake, ')
          ..write('cameraModel: $cameraModel, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isTrashed: $isTrashed, ')
          ..write('hasJsonIndex: $hasJsonIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        filePath,
        relativePath,
        filename,
        mediaType,
        capturedAt,
        modifiedAt,
        indexedAt,
        capturedYear,
        capturedMonth,
        width,
        height,
        durationMs,
        latitude,
        longitude,
        altitude,
        cameraMake,
        cameraModel,
        thumbnailPath,
        isFavorite,
        isTrashed,
        hasJsonIndex
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaRecord &&
          other.id == this.id &&
          other.filePath == this.filePath &&
          other.relativePath == this.relativePath &&
          other.filename == this.filename &&
          other.mediaType == this.mediaType &&
          other.capturedAt == this.capturedAt &&
          other.modifiedAt == this.modifiedAt &&
          other.indexedAt == this.indexedAt &&
          other.capturedYear == this.capturedYear &&
          other.capturedMonth == this.capturedMonth &&
          other.width == this.width &&
          other.height == this.height &&
          other.durationMs == this.durationMs &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.altitude == this.altitude &&
          other.cameraMake == this.cameraMake &&
          other.cameraModel == this.cameraModel &&
          other.thumbnailPath == this.thumbnailPath &&
          other.isFavorite == this.isFavorite &&
          other.isTrashed == this.isTrashed &&
          other.hasJsonIndex == this.hasJsonIndex);
}

class MediaRecordsCompanion extends UpdateCompanion<MediaRecord> {
  final Value<int> id;
  final Value<String> filePath;
  final Value<String> relativePath;
  final Value<String> filename;
  final Value<String> mediaType;
  final Value<DateTime?> capturedAt;
  final Value<DateTime?> modifiedAt;
  final Value<DateTime> indexedAt;
  final Value<int?> capturedYear;
  final Value<int?> capturedMonth;
  final Value<int?> width;
  final Value<int?> height;
  final Value<int?> durationMs;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<double?> altitude;
  final Value<String?> cameraMake;
  final Value<String?> cameraModel;
  final Value<String?> thumbnailPath;
  final Value<bool> isFavorite;
  final Value<bool> isTrashed;
  final Value<bool> hasJsonIndex;
  const MediaRecordsCompanion({
    this.id = const Value.absent(),
    this.filePath = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.filename = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.indexedAt = const Value.absent(),
    this.capturedYear = const Value.absent(),
    this.capturedMonth = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitude = const Value.absent(),
    this.cameraMake = const Value.absent(),
    this.cameraModel = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isTrashed = const Value.absent(),
    this.hasJsonIndex = const Value.absent(),
  });
  MediaRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String filePath,
    required String relativePath,
    required String filename,
    this.mediaType = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    required DateTime indexedAt,
    this.capturedYear = const Value.absent(),
    this.capturedMonth = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitude = const Value.absent(),
    this.cameraMake = const Value.absent(),
    this.cameraModel = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isTrashed = const Value.absent(),
    this.hasJsonIndex = const Value.absent(),
  })  : filePath = Value(filePath),
        relativePath = Value(relativePath),
        filename = Value(filename),
        indexedAt = Value(indexedAt);
  static Insertable<MediaRecord> custom({
    Expression<int>? id,
    Expression<String>? filePath,
    Expression<String>? relativePath,
    Expression<String>? filename,
    Expression<String>? mediaType,
    Expression<DateTime>? capturedAt,
    Expression<DateTime>? modifiedAt,
    Expression<DateTime>? indexedAt,
    Expression<int>? capturedYear,
    Expression<int>? capturedMonth,
    Expression<int>? width,
    Expression<int>? height,
    Expression<int>? durationMs,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? altitude,
    Expression<String>? cameraMake,
    Expression<String>? cameraModel,
    Expression<String>? thumbnailPath,
    Expression<bool>? isFavorite,
    Expression<bool>? isTrashed,
    Expression<bool>? hasJsonIndex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (filePath != null) 'file_path': filePath,
      if (relativePath != null) 'relative_path': relativePath,
      if (filename != null) 'filename': filename,
      if (mediaType != null) 'media_type': mediaType,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (indexedAt != null) 'indexed_at': indexedAt,
      if (capturedYear != null) 'captured_year': capturedYear,
      if (capturedMonth != null) 'captured_month': capturedMonth,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (durationMs != null) 'duration_ms': durationMs,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (altitude != null) 'altitude': altitude,
      if (cameraMake != null) 'camera_make': cameraMake,
      if (cameraModel != null) 'camera_model': cameraModel,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isTrashed != null) 'is_trashed': isTrashed,
      if (hasJsonIndex != null) 'has_json_index': hasJsonIndex,
    });
  }

  MediaRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? filePath,
      Value<String>? relativePath,
      Value<String>? filename,
      Value<String>? mediaType,
      Value<DateTime?>? capturedAt,
      Value<DateTime?>? modifiedAt,
      Value<DateTime>? indexedAt,
      Value<int?>? capturedYear,
      Value<int?>? capturedMonth,
      Value<int?>? width,
      Value<int?>? height,
      Value<int?>? durationMs,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<double?>? altitude,
      Value<String?>? cameraMake,
      Value<String?>? cameraModel,
      Value<String?>? thumbnailPath,
      Value<bool>? isFavorite,
      Value<bool>? isTrashed,
      Value<bool>? hasJsonIndex}) {
    return MediaRecordsCompanion(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      relativePath: relativePath ?? this.relativePath,
      filename: filename ?? this.filename,
      mediaType: mediaType ?? this.mediaType,
      capturedAt: capturedAt ?? this.capturedAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      indexedAt: indexedAt ?? this.indexedAt,
      capturedYear: capturedYear ?? this.capturedYear,
      capturedMonth: capturedMonth ?? this.capturedMonth,
      width: width ?? this.width,
      height: height ?? this.height,
      durationMs: durationMs ?? this.durationMs,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitude: altitude ?? this.altitude,
      cameraMake: cameraMake ?? this.cameraMake,
      cameraModel: cameraModel ?? this.cameraModel,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      isFavorite: isFavorite ?? this.isFavorite,
      isTrashed: isTrashed ?? this.isTrashed,
      hasJsonIndex: hasJsonIndex ?? this.hasJsonIndex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (indexedAt.present) {
      map['indexed_at'] = Variable<DateTime>(indexedAt.value);
    }
    if (capturedYear.present) {
      map['captured_year'] = Variable<int>(capturedYear.value);
    }
    if (capturedMonth.present) {
      map['captured_month'] = Variable<int>(capturedMonth.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (cameraMake.present) {
      map['camera_make'] = Variable<String>(cameraMake.value);
    }
    if (cameraModel.present) {
      map['camera_model'] = Variable<String>(cameraModel.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isTrashed.present) {
      map['is_trashed'] = Variable<bool>(isTrashed.value);
    }
    if (hasJsonIndex.present) {
      map['has_json_index'] = Variable<bool>(hasJsonIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaRecordsCompanion(')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('relativePath: $relativePath, ')
          ..write('filename: $filename, ')
          ..write('mediaType: $mediaType, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('indexedAt: $indexedAt, ')
          ..write('capturedYear: $capturedYear, ')
          ..write('capturedMonth: $capturedMonth, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('durationMs: $durationMs, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitude: $altitude, ')
          ..write('cameraMake: $cameraMake, ')
          ..write('cameraModel: $cameraModel, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isTrashed: $isTrashed, ')
          ..write('hasJsonIndex: $hasJsonIndex')
          ..write(')'))
        .toString();
  }
}

abstract class _$EchoDatabase extends GeneratedDatabase {
  _$EchoDatabase(QueryExecutor e) : super(e);
  $EchoDatabaseManager get managers => $EchoDatabaseManager(this);
  late final $MediaRecordsTable mediaRecords = $MediaRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mediaRecords];
}

typedef $$MediaRecordsTableCreateCompanionBuilder = MediaRecordsCompanion
    Function({
  Value<int> id,
  required String filePath,
  required String relativePath,
  required String filename,
  Value<String> mediaType,
  Value<DateTime?> capturedAt,
  Value<DateTime?> modifiedAt,
  required DateTime indexedAt,
  Value<int?> capturedYear,
  Value<int?> capturedMonth,
  Value<int?> width,
  Value<int?> height,
  Value<int?> durationMs,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<double?> altitude,
  Value<String?> cameraMake,
  Value<String?> cameraModel,
  Value<String?> thumbnailPath,
  Value<bool> isFavorite,
  Value<bool> isTrashed,
  Value<bool> hasJsonIndex,
});
typedef $$MediaRecordsTableUpdateCompanionBuilder = MediaRecordsCompanion
    Function({
  Value<int> id,
  Value<String> filePath,
  Value<String> relativePath,
  Value<String> filename,
  Value<String> mediaType,
  Value<DateTime?> capturedAt,
  Value<DateTime?> modifiedAt,
  Value<DateTime> indexedAt,
  Value<int?> capturedYear,
  Value<int?> capturedMonth,
  Value<int?> width,
  Value<int?> height,
  Value<int?> durationMs,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<double?> altitude,
  Value<String?> cameraMake,
  Value<String?> cameraModel,
  Value<String?> thumbnailPath,
  Value<bool> isFavorite,
  Value<bool> isTrashed,
  Value<bool> hasJsonIndex,
});

class $$MediaRecordsTableFilterComposer
    extends Composer<_$EchoDatabase, $MediaRecordsTable> {
  $$MediaRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relativePath => $composableBuilder(
      column: $table.relativePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filename => $composableBuilder(
      column: $table.filename, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mediaType => $composableBuilder(
      column: $table.mediaType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get indexedAt => $composableBuilder(
      column: $table.indexedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get capturedYear => $composableBuilder(
      column: $table.capturedYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get capturedMonth => $composableBuilder(
      column: $table.capturedMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get altitude => $composableBuilder(
      column: $table.altitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cameraMake => $composableBuilder(
      column: $table.cameraMake, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cameraModel => $composableBuilder(
      column: $table.cameraModel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
      column: $table.thumbnailPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isTrashed => $composableBuilder(
      column: $table.isTrashed, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasJsonIndex => $composableBuilder(
      column: $table.hasJsonIndex, builder: (column) => ColumnFilters(column));
}

class $$MediaRecordsTableOrderingComposer
    extends Composer<_$EchoDatabase, $MediaRecordsTable> {
  $$MediaRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relativePath => $composableBuilder(
      column: $table.relativePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filename => $composableBuilder(
      column: $table.filename, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mediaType => $composableBuilder(
      column: $table.mediaType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get indexedAt => $composableBuilder(
      column: $table.indexedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get capturedYear => $composableBuilder(
      column: $table.capturedYear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get capturedMonth => $composableBuilder(
      column: $table.capturedMonth,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get altitude => $composableBuilder(
      column: $table.altitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cameraMake => $composableBuilder(
      column: $table.cameraMake, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cameraModel => $composableBuilder(
      column: $table.cameraModel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
      column: $table.thumbnailPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isTrashed => $composableBuilder(
      column: $table.isTrashed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasJsonIndex => $composableBuilder(
      column: $table.hasJsonIndex,
      builder: (column) => ColumnOrderings(column));
}

class $$MediaRecordsTableAnnotationComposer
    extends Composer<_$EchoDatabase, $MediaRecordsTable> {
  $$MediaRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
      column: $table.relativePath, builder: (column) => column);

  GeneratedColumn<String> get filename =>
      $composableBuilder(column: $table.filename, builder: (column) => column);

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get indexedAt =>
      $composableBuilder(column: $table.indexedAt, builder: (column) => column);

  GeneratedColumn<int> get capturedYear => $composableBuilder(
      column: $table.capturedYear, builder: (column) => column);

  GeneratedColumn<int> get capturedMonth => $composableBuilder(
      column: $table.capturedMonth, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<String> get cameraMake => $composableBuilder(
      column: $table.cameraMake, builder: (column) => column);

  GeneratedColumn<String> get cameraModel => $composableBuilder(
      column: $table.cameraModel, builder: (column) => column);

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
      column: $table.thumbnailPath, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<bool> get isTrashed =>
      $composableBuilder(column: $table.isTrashed, builder: (column) => column);

  GeneratedColumn<bool> get hasJsonIndex => $composableBuilder(
      column: $table.hasJsonIndex, builder: (column) => column);
}

class $$MediaRecordsTableTableManager extends RootTableManager<
    _$EchoDatabase,
    $MediaRecordsTable,
    MediaRecord,
    $$MediaRecordsTableFilterComposer,
    $$MediaRecordsTableOrderingComposer,
    $$MediaRecordsTableAnnotationComposer,
    $$MediaRecordsTableCreateCompanionBuilder,
    $$MediaRecordsTableUpdateCompanionBuilder,
    (
      MediaRecord,
      BaseReferences<_$EchoDatabase, $MediaRecordsTable, MediaRecord>
    ),
    MediaRecord,
    PrefetchHooks Function()> {
  $$MediaRecordsTableTableManager(_$EchoDatabase db, $MediaRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<String> relativePath = const Value.absent(),
            Value<String> filename = const Value.absent(),
            Value<String> mediaType = const Value.absent(),
            Value<DateTime?> capturedAt = const Value.absent(),
            Value<DateTime?> modifiedAt = const Value.absent(),
            Value<DateTime> indexedAt = const Value.absent(),
            Value<int?> capturedYear = const Value.absent(),
            Value<int?> capturedMonth = const Value.absent(),
            Value<int?> width = const Value.absent(),
            Value<int?> height = const Value.absent(),
            Value<int?> durationMs = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<double?> altitude = const Value.absent(),
            Value<String?> cameraMake = const Value.absent(),
            Value<String?> cameraModel = const Value.absent(),
            Value<String?> thumbnailPath = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isTrashed = const Value.absent(),
            Value<bool> hasJsonIndex = const Value.absent(),
          }) =>
              MediaRecordsCompanion(
            id: id,
            filePath: filePath,
            relativePath: relativePath,
            filename: filename,
            mediaType: mediaType,
            capturedAt: capturedAt,
            modifiedAt: modifiedAt,
            indexedAt: indexedAt,
            capturedYear: capturedYear,
            capturedMonth: capturedMonth,
            width: width,
            height: height,
            durationMs: durationMs,
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            cameraMake: cameraMake,
            cameraModel: cameraModel,
            thumbnailPath: thumbnailPath,
            isFavorite: isFavorite,
            isTrashed: isTrashed,
            hasJsonIndex: hasJsonIndex,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String filePath,
            required String relativePath,
            required String filename,
            Value<String> mediaType = const Value.absent(),
            Value<DateTime?> capturedAt = const Value.absent(),
            Value<DateTime?> modifiedAt = const Value.absent(),
            required DateTime indexedAt,
            Value<int?> capturedYear = const Value.absent(),
            Value<int?> capturedMonth = const Value.absent(),
            Value<int?> width = const Value.absent(),
            Value<int?> height = const Value.absent(),
            Value<int?> durationMs = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<double?> altitude = const Value.absent(),
            Value<String?> cameraMake = const Value.absent(),
            Value<String?> cameraModel = const Value.absent(),
            Value<String?> thumbnailPath = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isTrashed = const Value.absent(),
            Value<bool> hasJsonIndex = const Value.absent(),
          }) =>
              MediaRecordsCompanion.insert(
            id: id,
            filePath: filePath,
            relativePath: relativePath,
            filename: filename,
            mediaType: mediaType,
            capturedAt: capturedAt,
            modifiedAt: modifiedAt,
            indexedAt: indexedAt,
            capturedYear: capturedYear,
            capturedMonth: capturedMonth,
            width: width,
            height: height,
            durationMs: durationMs,
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            cameraMake: cameraMake,
            cameraModel: cameraModel,
            thumbnailPath: thumbnailPath,
            isFavorite: isFavorite,
            isTrashed: isTrashed,
            hasJsonIndex: hasJsonIndex,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MediaRecordsTableProcessedTableManager = ProcessedTableManager<
    _$EchoDatabase,
    $MediaRecordsTable,
    MediaRecord,
    $$MediaRecordsTableFilterComposer,
    $$MediaRecordsTableOrderingComposer,
    $$MediaRecordsTableAnnotationComposer,
    $$MediaRecordsTableCreateCompanionBuilder,
    $$MediaRecordsTableUpdateCompanionBuilder,
    (
      MediaRecord,
      BaseReferences<_$EchoDatabase, $MediaRecordsTable, MediaRecord>
    ),
    MediaRecord,
    PrefetchHooks Function()>;

class $EchoDatabaseManager {
  final _$EchoDatabase _db;
  $EchoDatabaseManager(this._db);
  $$MediaRecordsTableTableManager get mediaRecords =>
      $$MediaRecordsTableTableManager(_db, _db.mediaRecords);
}
