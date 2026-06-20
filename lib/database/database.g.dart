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
  static const VerificationMeta _jsonDataMeta =
      const VerificationMeta('jsonData');
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
      'json_data', aliasedName, true,
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        relativePath,
        filename,
        mediaType,
        capturedAt,
        capturedYear,
        capturedMonth,
        cameraMake,
        cameraModel,
        jsonData,
        isFavorite,
        isTrashed
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
    if (data.containsKey('json_data')) {
      context.handle(_jsonDataMeta,
          jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta));
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
      relativePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}relative_path'])!,
      filename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filename'])!,
      mediaType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_type'])!,
      capturedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}captured_at']),
      capturedYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}captured_year']),
      capturedMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}captured_month']),
      cameraMake: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera_make']),
      cameraModel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera_model']),
      jsonData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}json_data']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      isTrashed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_trashed'])!,
    );
  }

  @override
  $MediaRecordsTable createAlias(String alias) {
    return $MediaRecordsTable(attachedDatabase, alias);
  }
}

class MediaRecord extends DataClass implements Insertable<MediaRecord> {
  final int id;
  final String relativePath;
  final String filename;
  final String mediaType;
  final DateTime? capturedAt;
  final int? capturedYear;
  final int? capturedMonth;
  final String? cameraMake;
  final String? cameraModel;
  final String? jsonData;
  final bool isFavorite;
  final bool isTrashed;
  const MediaRecord(
      {required this.id,
      required this.relativePath,
      required this.filename,
      required this.mediaType,
      this.capturedAt,
      this.capturedYear,
      this.capturedMonth,
      this.cameraMake,
      this.cameraModel,
      this.jsonData,
      required this.isFavorite,
      required this.isTrashed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['relative_path'] = Variable<String>(relativePath);
    map['filename'] = Variable<String>(filename);
    map['media_type'] = Variable<String>(mediaType);
    if (!nullToAbsent || capturedAt != null) {
      map['captured_at'] = Variable<DateTime>(capturedAt);
    }
    if (!nullToAbsent || capturedYear != null) {
      map['captured_year'] = Variable<int>(capturedYear);
    }
    if (!nullToAbsent || capturedMonth != null) {
      map['captured_month'] = Variable<int>(capturedMonth);
    }
    if (!nullToAbsent || cameraMake != null) {
      map['camera_make'] = Variable<String>(cameraMake);
    }
    if (!nullToAbsent || cameraModel != null) {
      map['camera_model'] = Variable<String>(cameraModel);
    }
    if (!nullToAbsent || jsonData != null) {
      map['json_data'] = Variable<String>(jsonData);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_trashed'] = Variable<bool>(isTrashed);
    return map;
  }

  MediaRecordsCompanion toCompanion(bool nullToAbsent) {
    return MediaRecordsCompanion(
      id: Value(id),
      relativePath: Value(relativePath),
      filename: Value(filename),
      mediaType: Value(mediaType),
      capturedAt: capturedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(capturedAt),
      capturedYear: capturedYear == null && nullToAbsent
          ? const Value.absent()
          : Value(capturedYear),
      capturedMonth: capturedMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(capturedMonth),
      cameraMake: cameraMake == null && nullToAbsent
          ? const Value.absent()
          : Value(cameraMake),
      cameraModel: cameraModel == null && nullToAbsent
          ? const Value.absent()
          : Value(cameraModel),
      jsonData: jsonData == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonData),
      isFavorite: Value(isFavorite),
      isTrashed: Value(isTrashed),
    );
  }

  factory MediaRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaRecord(
      id: serializer.fromJson<int>(json['id']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      filename: serializer.fromJson<String>(json['filename']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      capturedAt: serializer.fromJson<DateTime?>(json['capturedAt']),
      capturedYear: serializer.fromJson<int?>(json['capturedYear']),
      capturedMonth: serializer.fromJson<int?>(json['capturedMonth']),
      cameraMake: serializer.fromJson<String?>(json['cameraMake']),
      cameraModel: serializer.fromJson<String?>(json['cameraModel']),
      jsonData: serializer.fromJson<String?>(json['jsonData']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isTrashed: serializer.fromJson<bool>(json['isTrashed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'relativePath': serializer.toJson<String>(relativePath),
      'filename': serializer.toJson<String>(filename),
      'mediaType': serializer.toJson<String>(mediaType),
      'capturedAt': serializer.toJson<DateTime?>(capturedAt),
      'capturedYear': serializer.toJson<int?>(capturedYear),
      'capturedMonth': serializer.toJson<int?>(capturedMonth),
      'cameraMake': serializer.toJson<String?>(cameraMake),
      'cameraModel': serializer.toJson<String?>(cameraModel),
      'jsonData': serializer.toJson<String?>(jsonData),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isTrashed': serializer.toJson<bool>(isTrashed),
    };
  }

  MediaRecord copyWith(
          {int? id,
          String? relativePath,
          String? filename,
          String? mediaType,
          Value<DateTime?> capturedAt = const Value.absent(),
          Value<int?> capturedYear = const Value.absent(),
          Value<int?> capturedMonth = const Value.absent(),
          Value<String?> cameraMake = const Value.absent(),
          Value<String?> cameraModel = const Value.absent(),
          Value<String?> jsonData = const Value.absent(),
          bool? isFavorite,
          bool? isTrashed}) =>
      MediaRecord(
        id: id ?? this.id,
        relativePath: relativePath ?? this.relativePath,
        filename: filename ?? this.filename,
        mediaType: mediaType ?? this.mediaType,
        capturedAt: capturedAt.present ? capturedAt.value : this.capturedAt,
        capturedYear:
            capturedYear.present ? capturedYear.value : this.capturedYear,
        capturedMonth:
            capturedMonth.present ? capturedMonth.value : this.capturedMonth,
        cameraMake: cameraMake.present ? cameraMake.value : this.cameraMake,
        cameraModel: cameraModel.present ? cameraModel.value : this.cameraModel,
        jsonData: jsonData.present ? jsonData.value : this.jsonData,
        isFavorite: isFavorite ?? this.isFavorite,
        isTrashed: isTrashed ?? this.isTrashed,
      );
  MediaRecord copyWithCompanion(MediaRecordsCompanion data) {
    return MediaRecord(
      id: data.id.present ? data.id.value : this.id,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      filename: data.filename.present ? data.filename.value : this.filename,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      capturedAt:
          data.capturedAt.present ? data.capturedAt.value : this.capturedAt,
      capturedYear: data.capturedYear.present
          ? data.capturedYear.value
          : this.capturedYear,
      capturedMonth: data.capturedMonth.present
          ? data.capturedMonth.value
          : this.capturedMonth,
      cameraMake:
          data.cameraMake.present ? data.cameraMake.value : this.cameraMake,
      cameraModel:
          data.cameraModel.present ? data.cameraModel.value : this.cameraModel,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      isTrashed: data.isTrashed.present ? data.isTrashed.value : this.isTrashed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaRecord(')
          ..write('id: $id, ')
          ..write('relativePath: $relativePath, ')
          ..write('filename: $filename, ')
          ..write('mediaType: $mediaType, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('capturedYear: $capturedYear, ')
          ..write('capturedMonth: $capturedMonth, ')
          ..write('cameraMake: $cameraMake, ')
          ..write('cameraModel: $cameraModel, ')
          ..write('jsonData: $jsonData, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isTrashed: $isTrashed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      relativePath,
      filename,
      mediaType,
      capturedAt,
      capturedYear,
      capturedMonth,
      cameraMake,
      cameraModel,
      jsonData,
      isFavorite,
      isTrashed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaRecord &&
          other.id == this.id &&
          other.relativePath == this.relativePath &&
          other.filename == this.filename &&
          other.mediaType == this.mediaType &&
          other.capturedAt == this.capturedAt &&
          other.capturedYear == this.capturedYear &&
          other.capturedMonth == this.capturedMonth &&
          other.cameraMake == this.cameraMake &&
          other.cameraModel == this.cameraModel &&
          other.jsonData == this.jsonData &&
          other.isFavorite == this.isFavorite &&
          other.isTrashed == this.isTrashed);
}

class MediaRecordsCompanion extends UpdateCompanion<MediaRecord> {
  final Value<int> id;
  final Value<String> relativePath;
  final Value<String> filename;
  final Value<String> mediaType;
  final Value<DateTime?> capturedAt;
  final Value<int?> capturedYear;
  final Value<int?> capturedMonth;
  final Value<String?> cameraMake;
  final Value<String?> cameraModel;
  final Value<String?> jsonData;
  final Value<bool> isFavorite;
  final Value<bool> isTrashed;
  const MediaRecordsCompanion({
    this.id = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.filename = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.capturedYear = const Value.absent(),
    this.capturedMonth = const Value.absent(),
    this.cameraMake = const Value.absent(),
    this.cameraModel = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isTrashed = const Value.absent(),
  });
  MediaRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String relativePath,
    required String filename,
    this.mediaType = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.capturedYear = const Value.absent(),
    this.capturedMonth = const Value.absent(),
    this.cameraMake = const Value.absent(),
    this.cameraModel = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isTrashed = const Value.absent(),
  })  : relativePath = Value(relativePath),
        filename = Value(filename);
  static Insertable<MediaRecord> custom({
    Expression<int>? id,
    Expression<String>? relativePath,
    Expression<String>? filename,
    Expression<String>? mediaType,
    Expression<DateTime>? capturedAt,
    Expression<int>? capturedYear,
    Expression<int>? capturedMonth,
    Expression<String>? cameraMake,
    Expression<String>? cameraModel,
    Expression<String>? jsonData,
    Expression<bool>? isFavorite,
    Expression<bool>? isTrashed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (relativePath != null) 'relative_path': relativePath,
      if (filename != null) 'filename': filename,
      if (mediaType != null) 'media_type': mediaType,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (capturedYear != null) 'captured_year': capturedYear,
      if (capturedMonth != null) 'captured_month': capturedMonth,
      if (cameraMake != null) 'camera_make': cameraMake,
      if (cameraModel != null) 'camera_model': cameraModel,
      if (jsonData != null) 'json_data': jsonData,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isTrashed != null) 'is_trashed': isTrashed,
    });
  }

  MediaRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? relativePath,
      Value<String>? filename,
      Value<String>? mediaType,
      Value<DateTime?>? capturedAt,
      Value<int?>? capturedYear,
      Value<int?>? capturedMonth,
      Value<String?>? cameraMake,
      Value<String?>? cameraModel,
      Value<String?>? jsonData,
      Value<bool>? isFavorite,
      Value<bool>? isTrashed}) {
    return MediaRecordsCompanion(
      id: id ?? this.id,
      relativePath: relativePath ?? this.relativePath,
      filename: filename ?? this.filename,
      mediaType: mediaType ?? this.mediaType,
      capturedAt: capturedAt ?? this.capturedAt,
      capturedYear: capturedYear ?? this.capturedYear,
      capturedMonth: capturedMonth ?? this.capturedMonth,
      cameraMake: cameraMake ?? this.cameraMake,
      cameraModel: cameraModel ?? this.cameraModel,
      jsonData: jsonData ?? this.jsonData,
      isFavorite: isFavorite ?? this.isFavorite,
      isTrashed: isTrashed ?? this.isTrashed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    if (capturedYear.present) {
      map['captured_year'] = Variable<int>(capturedYear.value);
    }
    if (capturedMonth.present) {
      map['captured_month'] = Variable<int>(capturedMonth.value);
    }
    if (cameraMake.present) {
      map['camera_make'] = Variable<String>(cameraMake.value);
    }
    if (cameraModel.present) {
      map['camera_model'] = Variable<String>(cameraModel.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isTrashed.present) {
      map['is_trashed'] = Variable<bool>(isTrashed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaRecordsCompanion(')
          ..write('id: $id, ')
          ..write('relativePath: $relativePath, ')
          ..write('filename: $filename, ')
          ..write('mediaType: $mediaType, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('capturedYear: $capturedYear, ')
          ..write('capturedMonth: $capturedMonth, ')
          ..write('cameraMake: $cameraMake, ')
          ..write('cameraModel: $cameraModel, ')
          ..write('jsonData: $jsonData, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isTrashed: $isTrashed')
          ..write(')'))
        .toString();
  }
}

class $TagRecordsTable extends TagRecords
    with TableInfo<$TagRecordsTable, TagRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [uuid, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tag_records';
  @override
  VerificationContext validateIntegrity(Insertable<TagRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  TagRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagRecord(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $TagRecordsTable createAlias(String alias) {
    return $TagRecordsTable(attachedDatabase, alias);
  }
}

class TagRecord extends DataClass implements Insertable<TagRecord> {
  final String uuid;
  final String value;
  const TagRecord({required this.uuid, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['value'] = Variable<String>(value);
    return map;
  }

  TagRecordsCompanion toCompanion(bool nullToAbsent) {
    return TagRecordsCompanion(
      uuid: Value(uuid),
      value: Value(value),
    );
  }

  factory TagRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagRecord(
      uuid: serializer.fromJson<String>(json['uuid']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'value': serializer.toJson<String>(value),
    };
  }

  TagRecord copyWith({String? uuid, String? value}) => TagRecord(
        uuid: uuid ?? this.uuid,
        value: value ?? this.value,
      );
  TagRecord copyWithCompanion(TagRecordsCompanion data) {
    return TagRecord(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagRecord(')
          ..write('uuid: $uuid, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagRecord &&
          other.uuid == this.uuid &&
          other.value == this.value);
}

class TagRecordsCompanion extends UpdateCompanion<TagRecord> {
  final Value<String> uuid;
  final Value<String> value;
  final Value<int> rowid;
  const TagRecordsCompanion({
    this.uuid = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagRecordsCompanion.insert({
    required String uuid,
    required String value,
    this.rowid = const Value.absent(),
  })  : uuid = Value(uuid),
        value = Value(value);
  static Insertable<TagRecord> custom({
    Expression<String>? uuid,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagRecordsCompanion copyWith(
      {Value<String>? uuid, Value<String>? value, Value<int>? rowid}) {
    return TagRecordsCompanion(
      uuid: uuid ?? this.uuid,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagRecordsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediaTagRecordsTable extends MediaTagRecords
    with TableInfo<$MediaTagRecordsTable, MediaTagRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaTagRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mediaIdMeta =
      const VerificationMeta('mediaId');
  @override
  late final GeneratedColumn<int> mediaId = GeneratedColumn<int>(
      'media_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tagUuidMeta =
      const VerificationMeta('tagUuid');
  @override
  late final GeneratedColumn<String> tagUuid = GeneratedColumn<String>(
      'tag_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tag_records (uuid)'));
  @override
  List<GeneratedColumn> get $columns => [mediaId, tagUuid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_tag_records';
  @override
  VerificationContext validateIntegrity(Insertable<MediaTagRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('media_id')) {
      context.handle(_mediaIdMeta,
          mediaId.isAcceptableOrUnknown(data['media_id']!, _mediaIdMeta));
    } else if (isInserting) {
      context.missing(_mediaIdMeta);
    }
    if (data.containsKey('tag_uuid')) {
      context.handle(_tagUuidMeta,
          tagUuid.isAcceptableOrUnknown(data['tag_uuid']!, _tagUuidMeta));
    } else if (isInserting) {
      context.missing(_tagUuidMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mediaId, tagUuid};
  @override
  MediaTagRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaTagRecord(
      mediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}media_id'])!,
      tagUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_uuid'])!,
    );
  }

  @override
  $MediaTagRecordsTable createAlias(String alias) {
    return $MediaTagRecordsTable(attachedDatabase, alias);
  }
}

class MediaTagRecord extends DataClass implements Insertable<MediaTagRecord> {
  final int mediaId;
  final String tagUuid;
  const MediaTagRecord({required this.mediaId, required this.tagUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['media_id'] = Variable<int>(mediaId);
    map['tag_uuid'] = Variable<String>(tagUuid);
    return map;
  }

  MediaTagRecordsCompanion toCompanion(bool nullToAbsent) {
    return MediaTagRecordsCompanion(
      mediaId: Value(mediaId),
      tagUuid: Value(tagUuid),
    );
  }

  factory MediaTagRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaTagRecord(
      mediaId: serializer.fromJson<int>(json['mediaId']),
      tagUuid: serializer.fromJson<String>(json['tagUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mediaId': serializer.toJson<int>(mediaId),
      'tagUuid': serializer.toJson<String>(tagUuid),
    };
  }

  MediaTagRecord copyWith({int? mediaId, String? tagUuid}) => MediaTagRecord(
        mediaId: mediaId ?? this.mediaId,
        tagUuid: tagUuid ?? this.tagUuid,
      );
  MediaTagRecord copyWithCompanion(MediaTagRecordsCompanion data) {
    return MediaTagRecord(
      mediaId: data.mediaId.present ? data.mediaId.value : this.mediaId,
      tagUuid: data.tagUuid.present ? data.tagUuid.value : this.tagUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaTagRecord(')
          ..write('mediaId: $mediaId, ')
          ..write('tagUuid: $tagUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mediaId, tagUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaTagRecord &&
          other.mediaId == this.mediaId &&
          other.tagUuid == this.tagUuid);
}

class MediaTagRecordsCompanion extends UpdateCompanion<MediaTagRecord> {
  final Value<int> mediaId;
  final Value<String> tagUuid;
  final Value<int> rowid;
  const MediaTagRecordsCompanion({
    this.mediaId = const Value.absent(),
    this.tagUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaTagRecordsCompanion.insert({
    required int mediaId,
    required String tagUuid,
    this.rowid = const Value.absent(),
  })  : mediaId = Value(mediaId),
        tagUuid = Value(tagUuid);
  static Insertable<MediaTagRecord> custom({
    Expression<int>? mediaId,
    Expression<String>? tagUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mediaId != null) 'media_id': mediaId,
      if (tagUuid != null) 'tag_uuid': tagUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaTagRecordsCompanion copyWith(
      {Value<int>? mediaId, Value<String>? tagUuid, Value<int>? rowid}) {
    return MediaTagRecordsCompanion(
      mediaId: mediaId ?? this.mediaId,
      tagUuid: tagUuid ?? this.tagUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mediaId.present) {
      map['media_id'] = Variable<int>(mediaId.value);
    }
    if (tagUuid.present) {
      map['tag_uuid'] = Variable<String>(tagUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaTagRecordsCompanion(')
          ..write('mediaId: $mediaId, ')
          ..write('tagUuid: $tagUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$EchoDatabase extends GeneratedDatabase {
  _$EchoDatabase(QueryExecutor e) : super(e);
  $EchoDatabaseManager get managers => $EchoDatabaseManager(this);
  late final $MediaRecordsTable mediaRecords = $MediaRecordsTable(this);
  late final $TagRecordsTable tagRecords = $TagRecordsTable(this);
  late final $MediaTagRecordsTable mediaTagRecords =
      $MediaTagRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [mediaRecords, tagRecords, mediaTagRecords];
}

typedef $$MediaRecordsTableCreateCompanionBuilder = MediaRecordsCompanion
    Function({
  Value<int> id,
  required String relativePath,
  required String filename,
  Value<String> mediaType,
  Value<DateTime?> capturedAt,
  Value<int?> capturedYear,
  Value<int?> capturedMonth,
  Value<String?> cameraMake,
  Value<String?> cameraModel,
  Value<String?> jsonData,
  Value<bool> isFavorite,
  Value<bool> isTrashed,
});
typedef $$MediaRecordsTableUpdateCompanionBuilder = MediaRecordsCompanion
    Function({
  Value<int> id,
  Value<String> relativePath,
  Value<String> filename,
  Value<String> mediaType,
  Value<DateTime?> capturedAt,
  Value<int?> capturedYear,
  Value<int?> capturedMonth,
  Value<String?> cameraMake,
  Value<String?> cameraModel,
  Value<String?> jsonData,
  Value<bool> isFavorite,
  Value<bool> isTrashed,
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

  ColumnFilters<String> get relativePath => $composableBuilder(
      column: $table.relativePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filename => $composableBuilder(
      column: $table.filename, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mediaType => $composableBuilder(
      column: $table.mediaType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get capturedYear => $composableBuilder(
      column: $table.capturedYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get capturedMonth => $composableBuilder(
      column: $table.capturedMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cameraMake => $composableBuilder(
      column: $table.cameraMake, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cameraModel => $composableBuilder(
      column: $table.cameraModel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isTrashed => $composableBuilder(
      column: $table.isTrashed, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get relativePath => $composableBuilder(
      column: $table.relativePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filename => $composableBuilder(
      column: $table.filename, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mediaType => $composableBuilder(
      column: $table.mediaType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get capturedYear => $composableBuilder(
      column: $table.capturedYear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get capturedMonth => $composableBuilder(
      column: $table.capturedMonth,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cameraMake => $composableBuilder(
      column: $table.cameraMake, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cameraModel => $composableBuilder(
      column: $table.cameraModel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jsonData => $composableBuilder(
      column: $table.jsonData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isTrashed => $composableBuilder(
      column: $table.isTrashed, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get relativePath => $composableBuilder(
      column: $table.relativePath, builder: (column) => column);

  GeneratedColumn<String> get filename =>
      $composableBuilder(column: $table.filename, builder: (column) => column);

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => column);

  GeneratedColumn<int> get capturedYear => $composableBuilder(
      column: $table.capturedYear, builder: (column) => column);

  GeneratedColumn<int> get capturedMonth => $composableBuilder(
      column: $table.capturedMonth, builder: (column) => column);

  GeneratedColumn<String> get cameraMake => $composableBuilder(
      column: $table.cameraMake, builder: (column) => column);

  GeneratedColumn<String> get cameraModel => $composableBuilder(
      column: $table.cameraModel, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<bool> get isTrashed =>
      $composableBuilder(column: $table.isTrashed, builder: (column) => column);
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
            Value<String> relativePath = const Value.absent(),
            Value<String> filename = const Value.absent(),
            Value<String> mediaType = const Value.absent(),
            Value<DateTime?> capturedAt = const Value.absent(),
            Value<int?> capturedYear = const Value.absent(),
            Value<int?> capturedMonth = const Value.absent(),
            Value<String?> cameraMake = const Value.absent(),
            Value<String?> cameraModel = const Value.absent(),
            Value<String?> jsonData = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isTrashed = const Value.absent(),
          }) =>
              MediaRecordsCompanion(
            id: id,
            relativePath: relativePath,
            filename: filename,
            mediaType: mediaType,
            capturedAt: capturedAt,
            capturedYear: capturedYear,
            capturedMonth: capturedMonth,
            cameraMake: cameraMake,
            cameraModel: cameraModel,
            jsonData: jsonData,
            isFavorite: isFavorite,
            isTrashed: isTrashed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String relativePath,
            required String filename,
            Value<String> mediaType = const Value.absent(),
            Value<DateTime?> capturedAt = const Value.absent(),
            Value<int?> capturedYear = const Value.absent(),
            Value<int?> capturedMonth = const Value.absent(),
            Value<String?> cameraMake = const Value.absent(),
            Value<String?> cameraModel = const Value.absent(),
            Value<String?> jsonData = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isTrashed = const Value.absent(),
          }) =>
              MediaRecordsCompanion.insert(
            id: id,
            relativePath: relativePath,
            filename: filename,
            mediaType: mediaType,
            capturedAt: capturedAt,
            capturedYear: capturedYear,
            capturedMonth: capturedMonth,
            cameraMake: cameraMake,
            cameraModel: cameraModel,
            jsonData: jsonData,
            isFavorite: isFavorite,
            isTrashed: isTrashed,
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
typedef $$TagRecordsTableCreateCompanionBuilder = TagRecordsCompanion Function({
  required String uuid,
  required String value,
  Value<int> rowid,
});
typedef $$TagRecordsTableUpdateCompanionBuilder = TagRecordsCompanion Function({
  Value<String> uuid,
  Value<String> value,
  Value<int> rowid,
});

final class $$TagRecordsTableReferences
    extends BaseReferences<_$EchoDatabase, $TagRecordsTable, TagRecord> {
  $$TagRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MediaTagRecordsTable, List<MediaTagRecord>>
      _mediaTagRecordsRefsTable(_$EchoDatabase db) =>
          MultiTypedResultKey.fromTable(db.mediaTagRecords,
              aliasName: $_aliasNameGenerator(
                  db.tagRecords.uuid, db.mediaTagRecords.tagUuid));

  $$MediaTagRecordsTableProcessedTableManager get mediaTagRecordsRefs {
    final manager = $$MediaTagRecordsTableTableManager(
            $_db, $_db.mediaTagRecords)
        .filter((f) => f.tagUuid.uuid.sqlEquals($_itemColumn<String>('uuid')!));

    final cache =
        $_typedResult.readTableOrNull(_mediaTagRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TagRecordsTableFilterComposer
    extends Composer<_$EchoDatabase, $TagRecordsTable> {
  $$TagRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  Expression<bool> mediaTagRecordsRefs(
      Expression<bool> Function($$MediaTagRecordsTableFilterComposer f) f) {
    final $$MediaTagRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.mediaTagRecords,
        getReferencedColumn: (t) => t.tagUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MediaTagRecordsTableFilterComposer(
              $db: $db,
              $table: $db.mediaTagRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TagRecordsTableOrderingComposer
    extends Composer<_$EchoDatabase, $TagRecordsTable> {
  $$TagRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$TagRecordsTableAnnotationComposer
    extends Composer<_$EchoDatabase, $TagRecordsTable> {
  $$TagRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  Expression<T> mediaTagRecordsRefs<T extends Object>(
      Expression<T> Function($$MediaTagRecordsTableAnnotationComposer a) f) {
    final $$MediaTagRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.mediaTagRecords,
        getReferencedColumn: (t) => t.tagUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MediaTagRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.mediaTagRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TagRecordsTableTableManager extends RootTableManager<
    _$EchoDatabase,
    $TagRecordsTable,
    TagRecord,
    $$TagRecordsTableFilterComposer,
    $$TagRecordsTableOrderingComposer,
    $$TagRecordsTableAnnotationComposer,
    $$TagRecordsTableCreateCompanionBuilder,
    $$TagRecordsTableUpdateCompanionBuilder,
    (TagRecord, $$TagRecordsTableReferences),
    TagRecord,
    PrefetchHooks Function({bool mediaTagRecordsRefs})> {
  $$TagRecordsTableTableManager(_$EchoDatabase db, $TagRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TagRecordsCompanion(
            uuid: uuid,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uuid,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              TagRecordsCompanion.insert(
            uuid: uuid,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TagRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({mediaTagRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (mediaTagRecordsRefs) db.mediaTagRecords
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mediaTagRecordsRefs)
                    await $_getPrefetchedData<TagRecord, $TagRecordsTable,
                            MediaTagRecord>(
                        currentTable: table,
                        referencedTable: $$TagRecordsTableReferences
                            ._mediaTagRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TagRecordsTableReferences(db, table, p0)
                                .mediaTagRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.tagUuid == item.uuid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TagRecordsTableProcessedTableManager = ProcessedTableManager<
    _$EchoDatabase,
    $TagRecordsTable,
    TagRecord,
    $$TagRecordsTableFilterComposer,
    $$TagRecordsTableOrderingComposer,
    $$TagRecordsTableAnnotationComposer,
    $$TagRecordsTableCreateCompanionBuilder,
    $$TagRecordsTableUpdateCompanionBuilder,
    (TagRecord, $$TagRecordsTableReferences),
    TagRecord,
    PrefetchHooks Function({bool mediaTagRecordsRefs})>;
typedef $$MediaTagRecordsTableCreateCompanionBuilder = MediaTagRecordsCompanion
    Function({
  required int mediaId,
  required String tagUuid,
  Value<int> rowid,
});
typedef $$MediaTagRecordsTableUpdateCompanionBuilder = MediaTagRecordsCompanion
    Function({
  Value<int> mediaId,
  Value<String> tagUuid,
  Value<int> rowid,
});

final class $$MediaTagRecordsTableReferences extends BaseReferences<
    _$EchoDatabase, $MediaTagRecordsTable, MediaTagRecord> {
  $$MediaTagRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TagRecordsTable _tagUuidTable(_$EchoDatabase db) =>
      db.tagRecords.createAlias(
          $_aliasNameGenerator(db.mediaTagRecords.tagUuid, db.tagRecords.uuid));

  $$TagRecordsTableProcessedTableManager get tagUuid {
    final $_column = $_itemColumn<String>('tag_uuid')!;

    final manager = $$TagRecordsTableTableManager($_db, $_db.tagRecords)
        .filter((f) => f.uuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MediaTagRecordsTableFilterComposer
    extends Composer<_$EchoDatabase, $MediaTagRecordsTable> {
  $$MediaTagRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get mediaId => $composableBuilder(
      column: $table.mediaId, builder: (column) => ColumnFilters(column));

  $$TagRecordsTableFilterComposer get tagUuid {
    final $$TagRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagUuid,
        referencedTable: $db.tagRecords,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagRecordsTableFilterComposer(
              $db: $db,
              $table: $db.tagRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MediaTagRecordsTableOrderingComposer
    extends Composer<_$EchoDatabase, $MediaTagRecordsTable> {
  $$MediaTagRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get mediaId => $composableBuilder(
      column: $table.mediaId, builder: (column) => ColumnOrderings(column));

  $$TagRecordsTableOrderingComposer get tagUuid {
    final $$TagRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagUuid,
        referencedTable: $db.tagRecords,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.tagRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MediaTagRecordsTableAnnotationComposer
    extends Composer<_$EchoDatabase, $MediaTagRecordsTable> {
  $$MediaTagRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get mediaId =>
      $composableBuilder(column: $table.mediaId, builder: (column) => column);

  $$TagRecordsTableAnnotationComposer get tagUuid {
    final $$TagRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagUuid,
        referencedTable: $db.tagRecords,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.tagRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MediaTagRecordsTableTableManager extends RootTableManager<
    _$EchoDatabase,
    $MediaTagRecordsTable,
    MediaTagRecord,
    $$MediaTagRecordsTableFilterComposer,
    $$MediaTagRecordsTableOrderingComposer,
    $$MediaTagRecordsTableAnnotationComposer,
    $$MediaTagRecordsTableCreateCompanionBuilder,
    $$MediaTagRecordsTableUpdateCompanionBuilder,
    (MediaTagRecord, $$MediaTagRecordsTableReferences),
    MediaTagRecord,
    PrefetchHooks Function({bool tagUuid})> {
  $$MediaTagRecordsTableTableManager(
      _$EchoDatabase db, $MediaTagRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaTagRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaTagRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaTagRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> mediaId = const Value.absent(),
            Value<String> tagUuid = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaTagRecordsCompanion(
            mediaId: mediaId,
            tagUuid: tagUuid,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int mediaId,
            required String tagUuid,
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaTagRecordsCompanion.insert(
            mediaId: mediaId,
            tagUuid: tagUuid,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MediaTagRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({tagUuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (tagUuid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tagUuid,
                    referencedTable:
                        $$MediaTagRecordsTableReferences._tagUuidTable(db),
                    referencedColumn:
                        $$MediaTagRecordsTableReferences._tagUuidTable(db).uuid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MediaTagRecordsTableProcessedTableManager = ProcessedTableManager<
    _$EchoDatabase,
    $MediaTagRecordsTable,
    MediaTagRecord,
    $$MediaTagRecordsTableFilterComposer,
    $$MediaTagRecordsTableOrderingComposer,
    $$MediaTagRecordsTableAnnotationComposer,
    $$MediaTagRecordsTableCreateCompanionBuilder,
    $$MediaTagRecordsTableUpdateCompanionBuilder,
    (MediaTagRecord, $$MediaTagRecordsTableReferences),
    MediaTagRecord,
    PrefetchHooks Function({bool tagUuid})>;

class $EchoDatabaseManager {
  final _$EchoDatabase _db;
  $EchoDatabaseManager(this._db);
  $$MediaRecordsTableTableManager get mediaRecords =>
      $$MediaRecordsTableTableManager(_db, _db.mediaRecords);
  $$TagRecordsTableTableManager get tagRecords =>
      $$TagRecordsTableTableManager(_db, _db.tagRecords);
  $$MediaTagRecordsTableTableManager get mediaTagRecords =>
      $$MediaTagRecordsTableTableManager(_db, _db.mediaTagRecords);
}
