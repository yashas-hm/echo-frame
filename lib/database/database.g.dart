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
  static const VerificationMeta _driveIdMeta =
      const VerificationMeta('driveId');
  @override
  late final GeneratedColumn<String> driveId = GeneratedColumn<String>(
      'drive_id', aliasedName, false,
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
        driveId,
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
        cameraMake,
        cameraModel,
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
    if (data.containsKey('drive_id')) {
      context.handle(_driveIdMeta,
          driveId.isAcceptableOrUnknown(data['drive_id']!, _driveIdMeta));
    } else if (isInserting) {
      context.missing(_driveIdMeta);
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
      driveId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drive_id'])!,
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
      cameraMake: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera_make']),
      cameraModel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera_model']),
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
  final String driveId;
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
  final String? cameraMake;
  final String? cameraModel;
  final bool isFavorite;
  final bool isTrashed;
  final bool hasJsonIndex;

  const MediaRecord(
      {required this.id,
      required this.filePath,
      required this.driveId,
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
      this.cameraMake,
      this.cameraModel,
      required this.isFavorite,
      required this.isTrashed,
      required this.hasJsonIndex});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_path'] = Variable<String>(filePath);
    map['drive_id'] = Variable<String>(driveId);
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
    if (!nullToAbsent || cameraMake != null) {
      map['camera_make'] = Variable<String>(cameraMake);
    }
    if (!nullToAbsent || cameraModel != null) {
      map['camera_model'] = Variable<String>(cameraModel);
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
      driveId: Value(driveId),
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
      cameraMake: cameraMake == null && nullToAbsent
          ? const Value.absent()
          : Value(cameraMake),
      cameraModel: cameraModel == null && nullToAbsent
          ? const Value.absent()
          : Value(cameraModel),
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
      driveId: serializer.fromJson<String>(json['driveId']),
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
      cameraMake: serializer.fromJson<String?>(json['cameraMake']),
      cameraModel: serializer.fromJson<String?>(json['cameraModel']),
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
      'driveId': serializer.toJson<String>(driveId),
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
      'cameraMake': serializer.toJson<String?>(cameraMake),
      'cameraModel': serializer.toJson<String?>(cameraModel),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isTrashed': serializer.toJson<bool>(isTrashed),
      'hasJsonIndex': serializer.toJson<bool>(hasJsonIndex),
    };
  }

  MediaRecord copyWith(
          {int? id,
          String? filePath,
          String? driveId,
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
          Value<String?> cameraMake = const Value.absent(),
          Value<String?> cameraModel = const Value.absent(),
          bool? isFavorite,
          bool? isTrashed,
          bool? hasJsonIndex}) =>
      MediaRecord(
        id: id ?? this.id,
        filePath: filePath ?? this.filePath,
        driveId: driveId ?? this.driveId,
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
        cameraMake: cameraMake.present ? cameraMake.value : this.cameraMake,
        cameraModel: cameraModel.present ? cameraModel.value : this.cameraModel,
        isFavorite: isFavorite ?? this.isFavorite,
        isTrashed: isTrashed ?? this.isTrashed,
        hasJsonIndex: hasJsonIndex ?? this.hasJsonIndex,
      );

  MediaRecord copyWithCompanion(MediaRecordsCompanion data) {
    return MediaRecord(
      id: data.id.present ? data.id.value : this.id,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      driveId: data.driveId.present ? data.driveId.value : this.driveId,
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
      cameraMake:
          data.cameraMake.present ? data.cameraMake.value : this.cameraMake,
      cameraModel:
          data.cameraModel.present ? data.cameraModel.value : this.cameraModel,
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
          ..write('driveId: $driveId, ')
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
          ..write('cameraMake: $cameraMake, ')
          ..write('cameraModel: $cameraModel, ')
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
        driveId,
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
        cameraMake,
        cameraModel,
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
          other.driveId == this.driveId &&
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
          other.cameraMake == this.cameraMake &&
          other.cameraModel == this.cameraModel &&
          other.isFavorite == this.isFavorite &&
          other.isTrashed == this.isTrashed &&
          other.hasJsonIndex == this.hasJsonIndex);
}

class MediaRecordsCompanion extends UpdateCompanion<MediaRecord> {
  final Value<int> id;
  final Value<String> filePath;
  final Value<String> driveId;
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
  final Value<String?> cameraMake;
  final Value<String?> cameraModel;
  final Value<bool> isFavorite;
  final Value<bool> isTrashed;
  final Value<bool> hasJsonIndex;

  const MediaRecordsCompanion({
    this.id = const Value.absent(),
    this.filePath = const Value.absent(),
    this.driveId = const Value.absent(),
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
    this.cameraMake = const Value.absent(),
    this.cameraModel = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isTrashed = const Value.absent(),
    this.hasJsonIndex = const Value.absent(),
  });

  MediaRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String filePath,
    required String driveId,
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
    this.cameraMake = const Value.absent(),
    this.cameraModel = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isTrashed = const Value.absent(),
    this.hasJsonIndex = const Value.absent(),
  })  : filePath = Value(filePath),
        driveId = Value(driveId),
        relativePath = Value(relativePath),
        filename = Value(filename),
        indexedAt = Value(indexedAt);

  static Insertable<MediaRecord> custom({
    Expression<int>? id,
    Expression<String>? filePath,
    Expression<String>? driveId,
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
    Expression<String>? cameraMake,
    Expression<String>? cameraModel,
    Expression<bool>? isFavorite,
    Expression<bool>? isTrashed,
    Expression<bool>? hasJsonIndex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (filePath != null) 'file_path': filePath,
      if (driveId != null) 'drive_id': driveId,
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
      if (cameraMake != null) 'camera_make': cameraMake,
      if (cameraModel != null) 'camera_model': cameraModel,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isTrashed != null) 'is_trashed': isTrashed,
      if (hasJsonIndex != null) 'has_json_index': hasJsonIndex,
    });
  }

  MediaRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? filePath,
      Value<String>? driveId,
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
      Value<String?>? cameraMake,
      Value<String?>? cameraModel,
      Value<bool>? isFavorite,
      Value<bool>? isTrashed,
      Value<bool>? hasJsonIndex}) {
    return MediaRecordsCompanion(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      driveId: driveId ?? this.driveId,
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
      cameraMake: cameraMake ?? this.cameraMake,
      cameraModel: cameraModel ?? this.cameraModel,
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
    if (driveId.present) {
      map['drive_id'] = Variable<String>(driveId.value);
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
    if (cameraMake.present) {
      map['camera_make'] = Variable<String>(cameraMake.value);
    }
    if (cameraModel.present) {
      map['camera_model'] = Variable<String>(cameraModel.value);
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
          ..write('driveId: $driveId, ')
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
          ..write('cameraMake: $cameraMake, ')
          ..write('cameraModel: $cameraModel, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isTrashed: $isTrashed, ')
          ..write('hasJsonIndex: $hasJsonIndex')
          ..write(')'))
        .toString();
  }
}

class $DriveRecordsTable extends DriveRecords
    with TableInfo<$DriveRecordsTable, DriveRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $DriveRecordsTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastMountPathMeta =
      const VerificationMeta('lastMountPath');
  @override
  late final GeneratedColumn<String> lastMountPath = GeneratedColumn<String>(
      'last_mount_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _firstIndexedAtMeta =
      const VerificationMeta('firstIndexedAt');
  @override
  late final GeneratedColumn<DateTime> firstIndexedAt =
      GeneratedColumn<DateTime>('first_indexed_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastScannedAtMeta =
      const VerificationMeta('lastScannedAt');
  @override
  late final GeneratedColumn<DateTime> lastScannedAt =
      GeneratedColumn<DateTime>('last_scanned_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isOnlineMeta =
      const VerificationMeta('isOnline');
  @override
  late final GeneratedColumn<bool> isOnline = GeneratedColumn<bool>(
      'is_online', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_online" IN (0, 1))'),
      defaultValue: const Constant(false));

  @override
  List<GeneratedColumn> get $columns =>
      [id, uuid, label, lastMountPath, firstIndexedAt, lastScannedAt, isOnline];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'drive_records';

  @override
  VerificationContext validateIntegrity(Insertable<DriveRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('last_mount_path')) {
      context.handle(
          _lastMountPathMeta,
          lastMountPath.isAcceptableOrUnknown(
              data['last_mount_path']!, _lastMountPathMeta));
    }
    if (data.containsKey('first_indexed_at')) {
      context.handle(
          _firstIndexedAtMeta,
          firstIndexedAt.isAcceptableOrUnknown(
              data['first_indexed_at']!, _firstIndexedAtMeta));
    } else if (isInserting) {
      context.missing(_firstIndexedAtMeta);
    }
    if (data.containsKey('last_scanned_at')) {
      context.handle(
          _lastScannedAtMeta,
          lastScannedAt.isAcceptableOrUnknown(
              data['last_scanned_at']!, _lastScannedAtMeta));
    }
    if (data.containsKey('is_online')) {
      context.handle(_isOnlineMeta,
          isOnline.isAcceptableOrUnknown(data['is_online']!, _isOnlineMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  DriveRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriveRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      lastMountPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_mount_path']),
      firstIndexedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}first_indexed_at'])!,
      lastScannedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_scanned_at']),
      isOnline: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_online'])!,
    );
  }

  @override
  $DriveRecordsTable createAlias(String alias) {
    return $DriveRecordsTable(attachedDatabase, alias);
  }
}

class DriveRecord extends DataClass implements Insertable<DriveRecord> {
  final int id;
  final String uuid;
  final String label;
  final String? lastMountPath;
  final DateTime firstIndexedAt;
  final DateTime? lastScannedAt;
  final bool isOnline;

  const DriveRecord(
      {required this.id,
      required this.uuid,
      required this.label,
      this.lastMountPath,
      required this.firstIndexedAt,
      this.lastScannedAt,
      required this.isOnline});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || lastMountPath != null) {
      map['last_mount_path'] = Variable<String>(lastMountPath);
    }
    map['first_indexed_at'] = Variable<DateTime>(firstIndexedAt);
    if (!nullToAbsent || lastScannedAt != null) {
      map['last_scanned_at'] = Variable<DateTime>(lastScannedAt);
    }
    map['is_online'] = Variable<bool>(isOnline);
    return map;
  }

  DriveRecordsCompanion toCompanion(bool nullToAbsent) {
    return DriveRecordsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      label: Value(label),
      lastMountPath: lastMountPath == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMountPath),
      firstIndexedAt: Value(firstIndexedAt),
      lastScannedAt: lastScannedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastScannedAt),
      isOnline: Value(isOnline),
    );
  }

  factory DriveRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriveRecord(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      label: serializer.fromJson<String>(json['label']),
      lastMountPath: serializer.fromJson<String?>(json['lastMountPath']),
      firstIndexedAt: serializer.fromJson<DateTime>(json['firstIndexedAt']),
      lastScannedAt: serializer.fromJson<DateTime?>(json['lastScannedAt']),
      isOnline: serializer.fromJson<bool>(json['isOnline']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'label': serializer.toJson<String>(label),
      'lastMountPath': serializer.toJson<String?>(lastMountPath),
      'firstIndexedAt': serializer.toJson<DateTime>(firstIndexedAt),
      'lastScannedAt': serializer.toJson<DateTime?>(lastScannedAt),
      'isOnline': serializer.toJson<bool>(isOnline),
    };
  }

  DriveRecord copyWith(
          {int? id,
          String? uuid,
          String? label,
          Value<String?> lastMountPath = const Value.absent(),
          DateTime? firstIndexedAt,
          Value<DateTime?> lastScannedAt = const Value.absent(),
          bool? isOnline}) =>
      DriveRecord(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        label: label ?? this.label,
        lastMountPath:
            lastMountPath.present ? lastMountPath.value : this.lastMountPath,
        firstIndexedAt: firstIndexedAt ?? this.firstIndexedAt,
        lastScannedAt:
            lastScannedAt.present ? lastScannedAt.value : this.lastScannedAt,
        isOnline: isOnline ?? this.isOnline,
      );

  DriveRecord copyWithCompanion(DriveRecordsCompanion data) {
    return DriveRecord(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      label: data.label.present ? data.label.value : this.label,
      lastMountPath: data.lastMountPath.present
          ? data.lastMountPath.value
          : this.lastMountPath,
      firstIndexedAt: data.firstIndexedAt.present
          ? data.firstIndexedAt.value
          : this.firstIndexedAt,
      lastScannedAt: data.lastScannedAt.present
          ? data.lastScannedAt.value
          : this.lastScannedAt,
      isOnline: data.isOnline.present ? data.isOnline.value : this.isOnline,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriveRecord(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('label: $label, ')
          ..write('lastMountPath: $lastMountPath, ')
          ..write('firstIndexedAt: $firstIndexedAt, ')
          ..write('lastScannedAt: $lastScannedAt, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, uuid, label, lastMountPath, firstIndexedAt, lastScannedAt, isOnline);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriveRecord &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.label == this.label &&
          other.lastMountPath == this.lastMountPath &&
          other.firstIndexedAt == this.firstIndexedAt &&
          other.lastScannedAt == this.lastScannedAt &&
          other.isOnline == this.isOnline);
}

class DriveRecordsCompanion extends UpdateCompanion<DriveRecord> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> label;
  final Value<String?> lastMountPath;
  final Value<DateTime> firstIndexedAt;
  final Value<DateTime?> lastScannedAt;
  final Value<bool> isOnline;

  const DriveRecordsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.label = const Value.absent(),
    this.lastMountPath = const Value.absent(),
    this.firstIndexedAt = const Value.absent(),
    this.lastScannedAt = const Value.absent(),
    this.isOnline = const Value.absent(),
  });

  DriveRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String label,
    this.lastMountPath = const Value.absent(),
    required DateTime firstIndexedAt,
    this.lastScannedAt = const Value.absent(),
    this.isOnline = const Value.absent(),
  })  : uuid = Value(uuid),
        label = Value(label),
        firstIndexedAt = Value(firstIndexedAt);

  static Insertable<DriveRecord> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? label,
    Expression<String>? lastMountPath,
    Expression<DateTime>? firstIndexedAt,
    Expression<DateTime>? lastScannedAt,
    Expression<bool>? isOnline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (label != null) 'label': label,
      if (lastMountPath != null) 'last_mount_path': lastMountPath,
      if (firstIndexedAt != null) 'first_indexed_at': firstIndexedAt,
      if (lastScannedAt != null) 'last_scanned_at': lastScannedAt,
      if (isOnline != null) 'is_online': isOnline,
    });
  }

  DriveRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? label,
      Value<String?>? lastMountPath,
      Value<DateTime>? firstIndexedAt,
      Value<DateTime?>? lastScannedAt,
      Value<bool>? isOnline}) {
    return DriveRecordsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      label: label ?? this.label,
      lastMountPath: lastMountPath ?? this.lastMountPath,
      firstIndexedAt: firstIndexedAt ?? this.firstIndexedAt,
      lastScannedAt: lastScannedAt ?? this.lastScannedAt,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (lastMountPath.present) {
      map['last_mount_path'] = Variable<String>(lastMountPath.value);
    }
    if (firstIndexedAt.present) {
      map['first_indexed_at'] = Variable<DateTime>(firstIndexedAt.value);
    }
    if (lastScannedAt.present) {
      map['last_scanned_at'] = Variable<DateTime>(lastScannedAt.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriveRecordsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('label: $label, ')
          ..write('lastMountPath: $lastMountPath, ')
          ..write('firstIndexedAt: $firstIndexedAt, ')
          ..write('lastScannedAt: $lastScannedAt, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }
}

class $OperationRecordsTable extends OperationRecords
    with TableInfo<$OperationRecordsTable, OperationRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $OperationRecordsTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _batchIdMeta =
      const VerificationMeta('batchId');
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
      'batch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _opTypeMeta = const VerificationMeta('opType');
  @override
  late final GeneratedColumn<String> opType = GeneratedColumn<String>(
      'op_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourcePathMeta =
      const VerificationMeta('sourcePath');
  @override
  late final GeneratedColumn<String> sourcePath = GeneratedColumn<String>(
      'source_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _destPathMeta =
      const VerificationMeta('destPath');
  @override
  late final GeneratedColumn<String> destPath = GeneratedColumn<String>(
      'dest_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _appliedAtMeta =
      const VerificationMeta('appliedAt');
  @override
  late final GeneratedColumn<DateTime> appliedAt = GeneratedColumn<DateTime>(
      'applied_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _rolledBackAtMeta =
      const VerificationMeta('rolledBackAt');
  @override
  late final GeneratedColumn<DateTime> rolledBackAt = GeneratedColumn<DateTime>(
      'rolled_back_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isDryRunMeta =
      const VerificationMeta('isDryRun');
  @override
  late final GeneratedColumn<bool> isDryRun = GeneratedColumn<bool>(
      'is_dry_run', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dry_run" IN (0, 1))'),
      defaultValue: const Constant(false));

  @override
  List<GeneratedColumn> get $columns => [
        id,
        batchId,
        opType,
        sourcePath,
        destPath,
        appliedAt,
        rolledBackAt,
        isDryRun
      ];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'operation_records';

  @override
  VerificationContext validateIntegrity(Insertable<OperationRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('batch_id')) {
      context.handle(_batchIdMeta,
          batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta));
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('op_type')) {
      context.handle(_opTypeMeta,
          opType.isAcceptableOrUnknown(data['op_type']!, _opTypeMeta));
    } else if (isInserting) {
      context.missing(_opTypeMeta);
    }
    if (data.containsKey('source_path')) {
      context.handle(
          _sourcePathMeta,
          sourcePath.isAcceptableOrUnknown(
              data['source_path']!, _sourcePathMeta));
    } else if (isInserting) {
      context.missing(_sourcePathMeta);
    }
    if (data.containsKey('dest_path')) {
      context.handle(_destPathMeta,
          destPath.isAcceptableOrUnknown(data['dest_path']!, _destPathMeta));
    } else if (isInserting) {
      context.missing(_destPathMeta);
    }
    if (data.containsKey('applied_at')) {
      context.handle(_appliedAtMeta,
          appliedAt.isAcceptableOrUnknown(data['applied_at']!, _appliedAtMeta));
    } else if (isInserting) {
      context.missing(_appliedAtMeta);
    }
    if (data.containsKey('rolled_back_at')) {
      context.handle(
          _rolledBackAtMeta,
          rolledBackAt.isAcceptableOrUnknown(
              data['rolled_back_at']!, _rolledBackAtMeta));
    }
    if (data.containsKey('is_dry_run')) {
      context.handle(_isDryRunMeta,
          isDryRun.isAcceptableOrUnknown(data['is_dry_run']!, _isDryRunMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  OperationRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OperationRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      batchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}batch_id'])!,
      opType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}op_type'])!,
      sourcePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_path'])!,
      destPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dest_path'])!,
      appliedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}applied_at'])!,
      rolledBackAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}rolled_back_at']),
      isDryRun: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dry_run'])!,
    );
  }

  @override
  $OperationRecordsTable createAlias(String alias) {
    return $OperationRecordsTable(attachedDatabase, alias);
  }
}

class OperationRecord extends DataClass implements Insertable<OperationRecord> {
  final int id;
  final String batchId;
  final String opType;
  final String sourcePath;
  final String destPath;
  final DateTime appliedAt;
  final DateTime? rolledBackAt;
  final bool isDryRun;

  const OperationRecord(
      {required this.id,
      required this.batchId,
      required this.opType,
      required this.sourcePath,
      required this.destPath,
      required this.appliedAt,
      this.rolledBackAt,
      required this.isDryRun});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['op_type'] = Variable<String>(opType);
    map['source_path'] = Variable<String>(sourcePath);
    map['dest_path'] = Variable<String>(destPath);
    map['applied_at'] = Variable<DateTime>(appliedAt);
    if (!nullToAbsent || rolledBackAt != null) {
      map['rolled_back_at'] = Variable<DateTime>(rolledBackAt);
    }
    map['is_dry_run'] = Variable<bool>(isDryRun);
    return map;
  }

  OperationRecordsCompanion toCompanion(bool nullToAbsent) {
    return OperationRecordsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      opType: Value(opType),
      sourcePath: Value(sourcePath),
      destPath: Value(destPath),
      appliedAt: Value(appliedAt),
      rolledBackAt: rolledBackAt == null && nullToAbsent
          ? const Value.absent()
          : Value(rolledBackAt),
      isDryRun: Value(isDryRun),
    );
  }

  factory OperationRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OperationRecord(
      id: serializer.fromJson<int>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      opType: serializer.fromJson<String>(json['opType']),
      sourcePath: serializer.fromJson<String>(json['sourcePath']),
      destPath: serializer.fromJson<String>(json['destPath']),
      appliedAt: serializer.fromJson<DateTime>(json['appliedAt']),
      rolledBackAt: serializer.fromJson<DateTime?>(json['rolledBackAt']),
      isDryRun: serializer.fromJson<bool>(json['isDryRun']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'batchId': serializer.toJson<String>(batchId),
      'opType': serializer.toJson<String>(opType),
      'sourcePath': serializer.toJson<String>(sourcePath),
      'destPath': serializer.toJson<String>(destPath),
      'appliedAt': serializer.toJson<DateTime>(appliedAt),
      'rolledBackAt': serializer.toJson<DateTime?>(rolledBackAt),
      'isDryRun': serializer.toJson<bool>(isDryRun),
    };
  }

  OperationRecord copyWith(
          {int? id,
          String? batchId,
          String? opType,
          String? sourcePath,
          String? destPath,
          DateTime? appliedAt,
          Value<DateTime?> rolledBackAt = const Value.absent(),
          bool? isDryRun}) =>
      OperationRecord(
        id: id ?? this.id,
        batchId: batchId ?? this.batchId,
        opType: opType ?? this.opType,
        sourcePath: sourcePath ?? this.sourcePath,
        destPath: destPath ?? this.destPath,
        appliedAt: appliedAt ?? this.appliedAt,
        rolledBackAt:
            rolledBackAt.present ? rolledBackAt.value : this.rolledBackAt,
        isDryRun: isDryRun ?? this.isDryRun,
      );

  OperationRecord copyWithCompanion(OperationRecordsCompanion data) {
    return OperationRecord(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      opType: data.opType.present ? data.opType.value : this.opType,
      sourcePath:
          data.sourcePath.present ? data.sourcePath.value : this.sourcePath,
      destPath: data.destPath.present ? data.destPath.value : this.destPath,
      appliedAt: data.appliedAt.present ? data.appliedAt.value : this.appliedAt,
      rolledBackAt: data.rolledBackAt.present
          ? data.rolledBackAt.value
          : this.rolledBackAt,
      isDryRun: data.isDryRun.present ? data.isDryRun.value : this.isDryRun,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OperationRecord(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('opType: $opType, ')
          ..write('sourcePath: $sourcePath, ')
          ..write('destPath: $destPath, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('rolledBackAt: $rolledBackAt, ')
          ..write('isDryRun: $isDryRun')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, batchId, opType, sourcePath, destPath,
      appliedAt, rolledBackAt, isDryRun);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OperationRecord &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.opType == this.opType &&
          other.sourcePath == this.sourcePath &&
          other.destPath == this.destPath &&
          other.appliedAt == this.appliedAt &&
          other.rolledBackAt == this.rolledBackAt &&
          other.isDryRun == this.isDryRun);
}

class OperationRecordsCompanion extends UpdateCompanion<OperationRecord> {
  final Value<int> id;
  final Value<String> batchId;
  final Value<String> opType;
  final Value<String> sourcePath;
  final Value<String> destPath;
  final Value<DateTime> appliedAt;
  final Value<DateTime?> rolledBackAt;
  final Value<bool> isDryRun;

  const OperationRecordsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.opType = const Value.absent(),
    this.sourcePath = const Value.absent(),
    this.destPath = const Value.absent(),
    this.appliedAt = const Value.absent(),
    this.rolledBackAt = const Value.absent(),
    this.isDryRun = const Value.absent(),
  });

  OperationRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String batchId,
    required String opType,
    required String sourcePath,
    required String destPath,
    required DateTime appliedAt,
    this.rolledBackAt = const Value.absent(),
    this.isDryRun = const Value.absent(),
  })  : batchId = Value(batchId),
        opType = Value(opType),
        sourcePath = Value(sourcePath),
        destPath = Value(destPath),
        appliedAt = Value(appliedAt);

  static Insertable<OperationRecord> custom({
    Expression<int>? id,
    Expression<String>? batchId,
    Expression<String>? opType,
    Expression<String>? sourcePath,
    Expression<String>? destPath,
    Expression<DateTime>? appliedAt,
    Expression<DateTime>? rolledBackAt,
    Expression<bool>? isDryRun,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (opType != null) 'op_type': opType,
      if (sourcePath != null) 'source_path': sourcePath,
      if (destPath != null) 'dest_path': destPath,
      if (appliedAt != null) 'applied_at': appliedAt,
      if (rolledBackAt != null) 'rolled_back_at': rolledBackAt,
      if (isDryRun != null) 'is_dry_run': isDryRun,
    });
  }

  OperationRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? batchId,
      Value<String>? opType,
      Value<String>? sourcePath,
      Value<String>? destPath,
      Value<DateTime>? appliedAt,
      Value<DateTime?>? rolledBackAt,
      Value<bool>? isDryRun}) {
    return OperationRecordsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      opType: opType ?? this.opType,
      sourcePath: sourcePath ?? this.sourcePath,
      destPath: destPath ?? this.destPath,
      appliedAt: appliedAt ?? this.appliedAt,
      rolledBackAt: rolledBackAt ?? this.rolledBackAt,
      isDryRun: isDryRun ?? this.isDryRun,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (opType.present) {
      map['op_type'] = Variable<String>(opType.value);
    }
    if (sourcePath.present) {
      map['source_path'] = Variable<String>(sourcePath.value);
    }
    if (destPath.present) {
      map['dest_path'] = Variable<String>(destPath.value);
    }
    if (appliedAt.present) {
      map['applied_at'] = Variable<DateTime>(appliedAt.value);
    }
    if (rolledBackAt.present) {
      map['rolled_back_at'] = Variable<DateTime>(rolledBackAt.value);
    }
    if (isDryRun.present) {
      map['is_dry_run'] = Variable<bool>(isDryRun.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OperationRecordsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('opType: $opType, ')
          ..write('sourcePath: $sourcePath, ')
          ..write('destPath: $destPath, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('rolledBackAt: $rolledBackAt, ')
          ..write('isDryRun: $isDryRun')
          ..write(')'))
        .toString();
  }
}

abstract class _$EchoDatabase extends GeneratedDatabase {
  _$EchoDatabase(QueryExecutor e) : super(e);

  $EchoDatabaseManager get managers => $EchoDatabaseManager(this);
  late final $MediaRecordsTable mediaRecords = $MediaRecordsTable(this);
  late final $DriveRecordsTable driveRecords = $DriveRecordsTable(this);
  late final $OperationRecordsTable operationRecords =
      $OperationRecordsTable(this);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [mediaRecords, driveRecords, operationRecords];
}

typedef $$MediaRecordsTableCreateCompanionBuilder = MediaRecordsCompanion
    Function({
  Value<int> id,
  required String filePath,
  required String driveId,
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
  Value<String?> cameraMake,
  Value<String?> cameraModel,
  Value<bool> isFavorite,
  Value<bool> isTrashed,
  Value<bool> hasJsonIndex,
});
typedef $$MediaRecordsTableUpdateCompanionBuilder = MediaRecordsCompanion
    Function({
  Value<int> id,
  Value<String> filePath,
  Value<String> driveId,
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
  Value<String?> cameraMake,
  Value<String?> cameraModel,
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

  ColumnFilters<String> get driveId => $composableBuilder(
      column: $table.driveId, builder: (column) => ColumnFilters(column));

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

  ColumnFilters<String> get cameraMake => $composableBuilder(
      column: $table.cameraMake, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cameraModel => $composableBuilder(
      column: $table.cameraModel, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get driveId => $composableBuilder(
      column: $table.driveId, builder: (column) => ColumnOrderings(column));

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

  ColumnOrderings<String> get cameraMake => $composableBuilder(
      column: $table.cameraMake, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cameraModel => $composableBuilder(
      column: $table.cameraModel, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get driveId =>
      $composableBuilder(column: $table.driveId, builder: (column) => column);

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

  GeneratedColumn<String> get cameraMake => $composableBuilder(
      column: $table.cameraMake, builder: (column) => column);

  GeneratedColumn<String> get cameraModel => $composableBuilder(
      column: $table.cameraModel, builder: (column) => column);

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
            Value<String> driveId = const Value.absent(),
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
            Value<String?> cameraMake = const Value.absent(),
            Value<String?> cameraModel = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isTrashed = const Value.absent(),
            Value<bool> hasJsonIndex = const Value.absent(),
          }) =>
              MediaRecordsCompanion(
            id: id,
            filePath: filePath,
            driveId: driveId,
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
            cameraMake: cameraMake,
            cameraModel: cameraModel,
            isFavorite: isFavorite,
            isTrashed: isTrashed,
            hasJsonIndex: hasJsonIndex,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String filePath,
            required String driveId,
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
            Value<String?> cameraMake = const Value.absent(),
            Value<String?> cameraModel = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isTrashed = const Value.absent(),
            Value<bool> hasJsonIndex = const Value.absent(),
          }) =>
              MediaRecordsCompanion.insert(
            id: id,
            filePath: filePath,
            driveId: driveId,
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
            cameraMake: cameraMake,
            cameraModel: cameraModel,
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
typedef $$DriveRecordsTableCreateCompanionBuilder = DriveRecordsCompanion
    Function({
  Value<int> id,
  required String uuid,
  required String label,
  Value<String?> lastMountPath,
  required DateTime firstIndexedAt,
  Value<DateTime?> lastScannedAt,
  Value<bool> isOnline,
});
typedef $$DriveRecordsTableUpdateCompanionBuilder = DriveRecordsCompanion
    Function({
  Value<int> id,
  Value<String> uuid,
  Value<String> label,
  Value<String?> lastMountPath,
  Value<DateTime> firstIndexedAt,
  Value<DateTime?> lastScannedAt,
  Value<bool> isOnline,
});

class $$DriveRecordsTableFilterComposer
    extends Composer<_$EchoDatabase, $DriveRecordsTable> {
  $$DriveRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastMountPath => $composableBuilder(
      column: $table.lastMountPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get firstIndexedAt => $composableBuilder(
      column: $table.firstIndexedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastScannedAt => $composableBuilder(
      column: $table.lastScannedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isOnline => $composableBuilder(
      column: $table.isOnline, builder: (column) => ColumnFilters(column));
}

class $$DriveRecordsTableOrderingComposer
    extends Composer<_$EchoDatabase, $DriveRecordsTable> {
  $$DriveRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastMountPath => $composableBuilder(
      column: $table.lastMountPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get firstIndexedAt => $composableBuilder(
      column: $table.firstIndexedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastScannedAt => $composableBuilder(
      column: $table.lastScannedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isOnline => $composableBuilder(
      column: $table.isOnline, builder: (column) => ColumnOrderings(column));
}

class $$DriveRecordsTableAnnotationComposer
    extends Composer<_$EchoDatabase, $DriveRecordsTable> {
  $$DriveRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get lastMountPath => $composableBuilder(
      column: $table.lastMountPath, builder: (column) => column);

  GeneratedColumn<DateTime> get firstIndexedAt => $composableBuilder(
      column: $table.firstIndexedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastScannedAt => $composableBuilder(
      column: $table.lastScannedAt, builder: (column) => column);

  GeneratedColumn<bool> get isOnline =>
      $composableBuilder(column: $table.isOnline, builder: (column) => column);
}

class $$DriveRecordsTableTableManager extends RootTableManager<
    _$EchoDatabase,
    $DriveRecordsTable,
    DriveRecord,
    $$DriveRecordsTableFilterComposer,
    $$DriveRecordsTableOrderingComposer,
    $$DriveRecordsTableAnnotationComposer,
    $$DriveRecordsTableCreateCompanionBuilder,
    $$DriveRecordsTableUpdateCompanionBuilder,
    (
      DriveRecord,
      BaseReferences<_$EchoDatabase, $DriveRecordsTable, DriveRecord>
    ),
    DriveRecord,
    PrefetchHooks Function()> {
  $$DriveRecordsTableTableManager(_$EchoDatabase db, $DriveRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DriveRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DriveRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DriveRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String?> lastMountPath = const Value.absent(),
            Value<DateTime> firstIndexedAt = const Value.absent(),
            Value<DateTime?> lastScannedAt = const Value.absent(),
            Value<bool> isOnline = const Value.absent(),
          }) =>
              DriveRecordsCompanion(
            id: id,
            uuid: uuid,
            label: label,
            lastMountPath: lastMountPath,
            firstIndexedAt: firstIndexedAt,
            lastScannedAt: lastScannedAt,
            isOnline: isOnline,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required String label,
            Value<String?> lastMountPath = const Value.absent(),
            required DateTime firstIndexedAt,
            Value<DateTime?> lastScannedAt = const Value.absent(),
            Value<bool> isOnline = const Value.absent(),
          }) =>
              DriveRecordsCompanion.insert(
            id: id,
            uuid: uuid,
            label: label,
            lastMountPath: lastMountPath,
            firstIndexedAt: firstIndexedAt,
            lastScannedAt: lastScannedAt,
            isOnline: isOnline,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DriveRecordsTableProcessedTableManager = ProcessedTableManager<
    _$EchoDatabase,
    $DriveRecordsTable,
    DriveRecord,
    $$DriveRecordsTableFilterComposer,
    $$DriveRecordsTableOrderingComposer,
    $$DriveRecordsTableAnnotationComposer,
    $$DriveRecordsTableCreateCompanionBuilder,
    $$DriveRecordsTableUpdateCompanionBuilder,
    (
      DriveRecord,
      BaseReferences<_$EchoDatabase, $DriveRecordsTable, DriveRecord>
    ),
    DriveRecord,
    PrefetchHooks Function()>;
typedef $$OperationRecordsTableCreateCompanionBuilder
    = OperationRecordsCompanion Function({
  Value<int> id,
  required String batchId,
  required String opType,
  required String sourcePath,
  required String destPath,
  required DateTime appliedAt,
  Value<DateTime?> rolledBackAt,
  Value<bool> isDryRun,
});
typedef $$OperationRecordsTableUpdateCompanionBuilder
    = OperationRecordsCompanion Function({
  Value<int> id,
  Value<String> batchId,
  Value<String> opType,
  Value<String> sourcePath,
  Value<String> destPath,
  Value<DateTime> appliedAt,
  Value<DateTime?> rolledBackAt,
  Value<bool> isDryRun,
});

class $$OperationRecordsTableFilterComposer
    extends Composer<_$EchoDatabase, $OperationRecordsTable> {
  $$OperationRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get batchId => $composableBuilder(
      column: $table.batchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get opType => $composableBuilder(
      column: $table.opType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourcePath => $composableBuilder(
      column: $table.sourcePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get destPath => $composableBuilder(
      column: $table.destPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get appliedAt => $composableBuilder(
      column: $table.appliedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get rolledBackAt => $composableBuilder(
      column: $table.rolledBackAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDryRun => $composableBuilder(
      column: $table.isDryRun, builder: (column) => ColumnFilters(column));
}

class $$OperationRecordsTableOrderingComposer
    extends Composer<_$EchoDatabase, $OperationRecordsTable> {
  $$OperationRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get batchId => $composableBuilder(
      column: $table.batchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get opType => $composableBuilder(
      column: $table.opType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourcePath => $composableBuilder(
      column: $table.sourcePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get destPath => $composableBuilder(
      column: $table.destPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get appliedAt => $composableBuilder(
      column: $table.appliedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get rolledBackAt => $composableBuilder(
      column: $table.rolledBackAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDryRun => $composableBuilder(
      column: $table.isDryRun, builder: (column) => ColumnOrderings(column));
}

class $$OperationRecordsTableAnnotationComposer
    extends Composer<_$EchoDatabase, $OperationRecordsTable> {
  $$OperationRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get batchId =>
      $composableBuilder(column: $table.batchId, builder: (column) => column);

  GeneratedColumn<String> get opType =>
      $composableBuilder(column: $table.opType, builder: (column) => column);

  GeneratedColumn<String> get sourcePath => $composableBuilder(
      column: $table.sourcePath, builder: (column) => column);

  GeneratedColumn<String> get destPath =>
      $composableBuilder(column: $table.destPath, builder: (column) => column);

  GeneratedColumn<DateTime> get appliedAt =>
      $composableBuilder(column: $table.appliedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get rolledBackAt => $composableBuilder(
      column: $table.rolledBackAt, builder: (column) => column);

  GeneratedColumn<bool> get isDryRun =>
      $composableBuilder(column: $table.isDryRun, builder: (column) => column);
}

class $$OperationRecordsTableTableManager extends RootTableManager<
    _$EchoDatabase,
    $OperationRecordsTable,
    OperationRecord,
    $$OperationRecordsTableFilterComposer,
    $$OperationRecordsTableOrderingComposer,
    $$OperationRecordsTableAnnotationComposer,
    $$OperationRecordsTableCreateCompanionBuilder,
    $$OperationRecordsTableUpdateCompanionBuilder,
    (
      OperationRecord,
      BaseReferences<_$EchoDatabase, $OperationRecordsTable, OperationRecord>
    ),
    OperationRecord,
    PrefetchHooks Function()> {
  $$OperationRecordsTableTableManager(
      _$EchoDatabase db, $OperationRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OperationRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OperationRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OperationRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> batchId = const Value.absent(),
            Value<String> opType = const Value.absent(),
            Value<String> sourcePath = const Value.absent(),
            Value<String> destPath = const Value.absent(),
            Value<DateTime> appliedAt = const Value.absent(),
            Value<DateTime?> rolledBackAt = const Value.absent(),
            Value<bool> isDryRun = const Value.absent(),
          }) =>
              OperationRecordsCompanion(
            id: id,
            batchId: batchId,
            opType: opType,
            sourcePath: sourcePath,
            destPath: destPath,
            appliedAt: appliedAt,
            rolledBackAt: rolledBackAt,
            isDryRun: isDryRun,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String batchId,
            required String opType,
            required String sourcePath,
            required String destPath,
            required DateTime appliedAt,
            Value<DateTime?> rolledBackAt = const Value.absent(),
            Value<bool> isDryRun = const Value.absent(),
          }) =>
              OperationRecordsCompanion.insert(
            id: id,
            batchId: batchId,
            opType: opType,
            sourcePath: sourcePath,
            destPath: destPath,
            appliedAt: appliedAt,
            rolledBackAt: rolledBackAt,
            isDryRun: isDryRun,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OperationRecordsTableProcessedTableManager = ProcessedTableManager<
    _$EchoDatabase,
    $OperationRecordsTable,
    OperationRecord,
    $$OperationRecordsTableFilterComposer,
    $$OperationRecordsTableOrderingComposer,
    $$OperationRecordsTableAnnotationComposer,
    $$OperationRecordsTableCreateCompanionBuilder,
    $$OperationRecordsTableUpdateCompanionBuilder,
    (
      OperationRecord,
      BaseReferences<_$EchoDatabase, $OperationRecordsTable, OperationRecord>
    ),
    OperationRecord,
    PrefetchHooks Function()>;

class $EchoDatabaseManager {
  final _$EchoDatabase _db;

  $EchoDatabaseManager(this._db);

  $$MediaRecordsTableTableManager get mediaRecords =>
      $$MediaRecordsTableTableManager(_db, _db.mediaRecords);

  $$DriveRecordsTableTableManager get driveRecords =>
      $$DriveRecordsTableTableManager(_db, _db.driveRecords);

  $$OperationRecordsTableTableManager get operationRecords =>
      $$OperationRecordsTableTableManager(_db, _db.operationRecords);
}
