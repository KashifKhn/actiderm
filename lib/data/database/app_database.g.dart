// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SkinSpotsTable extends SkinSpots
    with TableInfo<$SkinSpotsTable, DbSkinSpot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkinSpotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdDateMeta = const VerificationMeta(
    'createdDate',
  );
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
    'created_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyPartMeta = const VerificationMeta(
    'bodyPart',
  );
  @override
  late final GeneratedColumn<String> bodyPart = GeneratedColumn<String>(
    'body_part',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subPartMeta = const VerificationMeta(
    'subPart',
  );
  @override
  late final GeneratedColumn<String> subPart = GeneratedColumn<String>(
    'sub_part',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    notes,
    createdDate,
    lastModified,
    bodyPart,
    subPart,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skin_spots';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbSkinSpot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_date')) {
      context.handle(
        _createdDateMeta,
        createdDate.isAcceptableOrUnknown(
          data['created_date']!,
          _createdDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdDateMeta);
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('body_part')) {
      context.handle(
        _bodyPartMeta,
        bodyPart.isAcceptableOrUnknown(data['body_part']!, _bodyPartMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyPartMeta);
    }
    if (data.containsKey('sub_part')) {
      context.handle(
        _subPartMeta,
        subPart.isAcceptableOrUnknown(data['sub_part']!, _subPartMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbSkinSpot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbSkinSpot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_date'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modified'],
      )!,
      bodyPart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_part'],
      )!,
      subPart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_part'],
      ),
    );
  }

  @override
  $SkinSpotsTable createAlias(String alias) {
    return $SkinSpotsTable(attachedDatabase, alias);
  }
}

class DbSkinSpot extends DataClass implements Insertable<DbSkinSpot> {
  final String id;
  final String title;
  final String? notes;
  final DateTime createdDate;
  final DateTime lastModified;
  final String bodyPart;
  final String? subPart;
  const DbSkinSpot({
    required this.id,
    required this.title,
    this.notes,
    required this.createdDate,
    required this.lastModified,
    required this.bodyPart,
    this.subPart,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_date'] = Variable<DateTime>(createdDate);
    map['last_modified'] = Variable<DateTime>(lastModified);
    map['body_part'] = Variable<String>(bodyPart);
    if (!nullToAbsent || subPart != null) {
      map['sub_part'] = Variable<String>(subPart);
    }
    return map;
  }

  SkinSpotsCompanion toCompanion(bool nullToAbsent) {
    return SkinSpotsCompanion(
      id: Value(id),
      title: Value(title),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdDate: Value(createdDate),
      lastModified: Value(lastModified),
      bodyPart: Value(bodyPart),
      subPart: subPart == null && nullToAbsent
          ? const Value.absent()
          : Value(subPart),
    );
  }

  factory DbSkinSpot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbSkinSpot(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      lastModified: serializer.fromJson<DateTime>(json['lastModified']),
      bodyPart: serializer.fromJson<String>(json['bodyPart']),
      subPart: serializer.fromJson<String?>(json['subPart']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String?>(notes),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'lastModified': serializer.toJson<DateTime>(lastModified),
      'bodyPart': serializer.toJson<String>(bodyPart),
      'subPart': serializer.toJson<String?>(subPart),
    };
  }

  DbSkinSpot copyWith({
    String? id,
    String? title,
    Value<String?> notes = const Value.absent(),
    DateTime? createdDate,
    DateTime? lastModified,
    String? bodyPart,
    Value<String?> subPart = const Value.absent(),
  }) => DbSkinSpot(
    id: id ?? this.id,
    title: title ?? this.title,
    notes: notes.present ? notes.value : this.notes,
    createdDate: createdDate ?? this.createdDate,
    lastModified: lastModified ?? this.lastModified,
    bodyPart: bodyPart ?? this.bodyPart,
    subPart: subPart.present ? subPart.value : this.subPart,
  );
  DbSkinSpot copyWithCompanion(SkinSpotsCompanion data) {
    return DbSkinSpot(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdDate: data.createdDate.present
          ? data.createdDate.value
          : this.createdDate,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      bodyPart: data.bodyPart.present ? data.bodyPart.value : this.bodyPart,
      subPart: data.subPart.present ? data.subPart.value : this.subPart,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbSkinSpot(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('createdDate: $createdDate, ')
          ..write('lastModified: $lastModified, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('subPart: $subPart')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    notes,
    createdDate,
    lastModified,
    bodyPart,
    subPart,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbSkinSpot &&
          other.id == this.id &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.createdDate == this.createdDate &&
          other.lastModified == this.lastModified &&
          other.bodyPart == this.bodyPart &&
          other.subPart == this.subPart);
}

class SkinSpotsCompanion extends UpdateCompanion<DbSkinSpot> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> notes;
  final Value<DateTime> createdDate;
  final Value<DateTime> lastModified;
  final Value<String> bodyPart;
  final Value<String?> subPart;
  final Value<int> rowid;
  const SkinSpotsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.bodyPart = const Value.absent(),
    this.subPart = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkinSpotsCompanion.insert({
    required String id,
    required String title,
    this.notes = const Value.absent(),
    required DateTime createdDate,
    required DateTime lastModified,
    required String bodyPart,
    this.subPart = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       createdDate = Value(createdDate),
       lastModified = Value(lastModified),
       bodyPart = Value(bodyPart);
  static Insertable<DbSkinSpot> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<DateTime>? createdDate,
    Expression<DateTime>? lastModified,
    Expression<String>? bodyPart,
    Expression<String>? subPart,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (createdDate != null) 'created_date': createdDate,
      if (lastModified != null) 'last_modified': lastModified,
      if (bodyPart != null) 'body_part': bodyPart,
      if (subPart != null) 'sub_part': subPart,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkinSpotsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? notes,
    Value<DateTime>? createdDate,
    Value<DateTime>? lastModified,
    Value<String>? bodyPart,
    Value<String?>? subPart,
    Value<int>? rowid,
  }) {
    return SkinSpotsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      createdDate: createdDate ?? this.createdDate,
      lastModified: lastModified ?? this.lastModified,
      bodyPart: bodyPart ?? this.bodyPart,
      subPart: subPart ?? this.subPart,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    if (bodyPart.present) {
      map['body_part'] = Variable<String>(bodyPart.value);
    }
    if (subPart.present) {
      map['sub_part'] = Variable<String>(subPart.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkinSpotsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('createdDate: $createdDate, ')
          ..write('lastModified: $lastModified, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('subPart: $subPart, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkinSpotPhotosTable extends SkinSpotPhotos
    with TableInfo<$SkinSpotPhotosTable, DbSkinSpotPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkinSpotPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spotIdMeta = const VerificationMeta('spotId');
  @override
  late final GeneratedColumn<String> spotId = GeneratedColumn<String>(
    'spot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skin_spots (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateTakenMeta = const VerificationMeta(
    'dateTaken',
  );
  @override
  late final GeneratedColumn<DateTime> dateTaken = GeneratedColumn<DateTime>(
    'date_taken',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    spotId,
    imagePath,
    dateTaken,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skin_spot_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbSkinSpotPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('spot_id')) {
      context.handle(
        _spotIdMeta,
        spotId.isAcceptableOrUnknown(data['spot_id']!, _spotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_spotIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('date_taken')) {
      context.handle(
        _dateTakenMeta,
        dateTaken.isAcceptableOrUnknown(data['date_taken']!, _dateTakenMeta),
      );
    } else if (isInserting) {
      context.missing(_dateTakenMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbSkinSpotPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbSkinSpotPhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      spotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spot_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      dateTaken: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_taken'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $SkinSpotPhotosTable createAlias(String alias) {
    return $SkinSpotPhotosTable(attachedDatabase, alias);
  }
}

class DbSkinSpotPhoto extends DataClass implements Insertable<DbSkinSpotPhoto> {
  final String id;
  final String spotId;
  final String? imagePath;
  final DateTime dateTaken;
  final String? notes;
  const DbSkinSpotPhoto({
    required this.id,
    required this.spotId,
    this.imagePath,
    required this.dateTaken,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['spot_id'] = Variable<String>(spotId);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['date_taken'] = Variable<DateTime>(dateTaken);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SkinSpotPhotosCompanion toCompanion(bool nullToAbsent) {
    return SkinSpotPhotosCompanion(
      id: Value(id),
      spotId: Value(spotId),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      dateTaken: Value(dateTaken),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory DbSkinSpotPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbSkinSpotPhoto(
      id: serializer.fromJson<String>(json['id']),
      spotId: serializer.fromJson<String>(json['spotId']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      dateTaken: serializer.fromJson<DateTime>(json['dateTaken']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'spotId': serializer.toJson<String>(spotId),
      'imagePath': serializer.toJson<String?>(imagePath),
      'dateTaken': serializer.toJson<DateTime>(dateTaken),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  DbSkinSpotPhoto copyWith({
    String? id,
    String? spotId,
    Value<String?> imagePath = const Value.absent(),
    DateTime? dateTaken,
    Value<String?> notes = const Value.absent(),
  }) => DbSkinSpotPhoto(
    id: id ?? this.id,
    spotId: spotId ?? this.spotId,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    dateTaken: dateTaken ?? this.dateTaken,
    notes: notes.present ? notes.value : this.notes,
  );
  DbSkinSpotPhoto copyWithCompanion(SkinSpotPhotosCompanion data) {
    return DbSkinSpotPhoto(
      id: data.id.present ? data.id.value : this.id,
      spotId: data.spotId.present ? data.spotId.value : this.spotId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      dateTaken: data.dateTaken.present ? data.dateTaken.value : this.dateTaken,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbSkinSpotPhoto(')
          ..write('id: $id, ')
          ..write('spotId: $spotId, ')
          ..write('imagePath: $imagePath, ')
          ..write('dateTaken: $dateTaken, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, spotId, imagePath, dateTaken, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbSkinSpotPhoto &&
          other.id == this.id &&
          other.spotId == this.spotId &&
          other.imagePath == this.imagePath &&
          other.dateTaken == this.dateTaken &&
          other.notes == this.notes);
}

class SkinSpotPhotosCompanion extends UpdateCompanion<DbSkinSpotPhoto> {
  final Value<String> id;
  final Value<String> spotId;
  final Value<String?> imagePath;
  final Value<DateTime> dateTaken;
  final Value<String?> notes;
  final Value<int> rowid;
  const SkinSpotPhotosCompanion({
    this.id = const Value.absent(),
    this.spotId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.dateTaken = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkinSpotPhotosCompanion.insert({
    required String id,
    required String spotId,
    this.imagePath = const Value.absent(),
    required DateTime dateTaken,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       spotId = Value(spotId),
       dateTaken = Value(dateTaken);
  static Insertable<DbSkinSpotPhoto> custom({
    Expression<String>? id,
    Expression<String>? spotId,
    Expression<String>? imagePath,
    Expression<DateTime>? dateTaken,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (spotId != null) 'spot_id': spotId,
      if (imagePath != null) 'image_path': imagePath,
      if (dateTaken != null) 'date_taken': dateTaken,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkinSpotPhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? spotId,
    Value<String?>? imagePath,
    Value<DateTime>? dateTaken,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return SkinSpotPhotosCompanion(
      id: id ?? this.id,
      spotId: spotId ?? this.spotId,
      imagePath: imagePath ?? this.imagePath,
      dateTaken: dateTaken ?? this.dateTaken,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (spotId.present) {
      map['spot_id'] = Variable<String>(spotId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (dateTaken.present) {
      map['date_taken'] = Variable<DateTime>(dateTaken.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkinSpotPhotosCompanion(')
          ..write('id: $id, ')
          ..write('spotId: $spotId, ')
          ..write('imagePath: $imagePath, ')
          ..write('dateTaken: $dateTaken, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkinLesionRecordsTable extends SkinLesionRecords
    with TableInfo<$SkinLesionRecordsTable, DbSkinLesionRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkinLesionRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spotIdMeta = const VerificationMeta('spotId');
  @override
  late final GeneratedColumn<String> spotId = GeneratedColumn<String>(
    'spot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skin_spots (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<String> timestamp = GeneratedColumn<String>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latencyMeta = const VerificationMeta(
    'latency',
  );
  @override
  late final GeneratedColumn<String> latency = GeneratedColumn<String>(
    'latency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lesionTypeMeta = const VerificationMeta(
    'lesionType',
  );
  @override
  late final GeneratedColumn<String> lesionType = GeneratedColumn<String>(
    'lesion_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symmetryMeta = const VerificationMeta(
    'symmetry',
  );
  @override
  late final GeneratedColumn<String> symmetry = GeneratedColumn<String>(
    'symmetry',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bordersMeta = const VerificationMeta(
    'borders',
  );
  @override
  late final GeneratedColumn<String> borders = GeneratedColumn<String>(
    'borders',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textureMeta = const VerificationMeta(
    'texture',
  );
  @override
  late final GeneratedColumn<String> texture = GeneratedColumn<String>(
    'texture',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    spotId,
    imagePath,
    timestamp,
    latency,
    lesionType,
    color,
    symmetry,
    borders,
    texture,
    summary,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skin_lesion_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbSkinLesionRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('spot_id')) {
      context.handle(
        _spotIdMeta,
        spotId.isAcceptableOrUnknown(data['spot_id']!, _spotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_spotIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('latency')) {
      context.handle(
        _latencyMeta,
        latency.isAcceptableOrUnknown(data['latency']!, _latencyMeta),
      );
    }
    if (data.containsKey('lesion_type')) {
      context.handle(
        _lesionTypeMeta,
        lesionType.isAcceptableOrUnknown(data['lesion_type']!, _lesionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_lesionTypeMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('symmetry')) {
      context.handle(
        _symmetryMeta,
        symmetry.isAcceptableOrUnknown(data['symmetry']!, _symmetryMeta),
      );
    } else if (isInserting) {
      context.missing(_symmetryMeta);
    }
    if (data.containsKey('borders')) {
      context.handle(
        _bordersMeta,
        borders.isAcceptableOrUnknown(data['borders']!, _bordersMeta),
      );
    } else if (isInserting) {
      context.missing(_bordersMeta);
    }
    if (data.containsKey('texture')) {
      context.handle(
        _textureMeta,
        texture.isAcceptableOrUnknown(data['texture']!, _textureMeta),
      );
    } else if (isInserting) {
      context.missing(_textureMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbSkinLesionRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbSkinLesionRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      spotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spot_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timestamp'],
      )!,
      latency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}latency'],
      ),
      lesionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesion_type'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      symmetry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symmetry'],
      )!,
      borders: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}borders'],
      )!,
      texture: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}texture'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
    );
  }

  @override
  $SkinLesionRecordsTable createAlias(String alias) {
    return $SkinLesionRecordsTable(attachedDatabase, alias);
  }
}

class DbSkinLesionRecord extends DataClass
    implements Insertable<DbSkinLesionRecord> {
  final String id;
  final String spotId;
  final String imagePath;
  final String timestamp;
  final String? latency;
  final String lesionType;
  final String color;
  final String symmetry;
  final String borders;
  final String texture;
  final String summary;
  const DbSkinLesionRecord({
    required this.id,
    required this.spotId,
    required this.imagePath,
    required this.timestamp,
    this.latency,
    required this.lesionType,
    required this.color,
    required this.symmetry,
    required this.borders,
    required this.texture,
    required this.summary,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['spot_id'] = Variable<String>(spotId);
    map['image_path'] = Variable<String>(imagePath);
    map['timestamp'] = Variable<String>(timestamp);
    if (!nullToAbsent || latency != null) {
      map['latency'] = Variable<String>(latency);
    }
    map['lesion_type'] = Variable<String>(lesionType);
    map['color'] = Variable<String>(color);
    map['symmetry'] = Variable<String>(symmetry);
    map['borders'] = Variable<String>(borders);
    map['texture'] = Variable<String>(texture);
    map['summary'] = Variable<String>(summary);
    return map;
  }

  SkinLesionRecordsCompanion toCompanion(bool nullToAbsent) {
    return SkinLesionRecordsCompanion(
      id: Value(id),
      spotId: Value(spotId),
      imagePath: Value(imagePath),
      timestamp: Value(timestamp),
      latency: latency == null && nullToAbsent
          ? const Value.absent()
          : Value(latency),
      lesionType: Value(lesionType),
      color: Value(color),
      symmetry: Value(symmetry),
      borders: Value(borders),
      texture: Value(texture),
      summary: Value(summary),
    );
  }

  factory DbSkinLesionRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbSkinLesionRecord(
      id: serializer.fromJson<String>(json['id']),
      spotId: serializer.fromJson<String>(json['spotId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
      latency: serializer.fromJson<String?>(json['latency']),
      lesionType: serializer.fromJson<String>(json['lesionType']),
      color: serializer.fromJson<String>(json['color']),
      symmetry: serializer.fromJson<String>(json['symmetry']),
      borders: serializer.fromJson<String>(json['borders']),
      texture: serializer.fromJson<String>(json['texture']),
      summary: serializer.fromJson<String>(json['summary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'spotId': serializer.toJson<String>(spotId),
      'imagePath': serializer.toJson<String>(imagePath),
      'timestamp': serializer.toJson<String>(timestamp),
      'latency': serializer.toJson<String?>(latency),
      'lesionType': serializer.toJson<String>(lesionType),
      'color': serializer.toJson<String>(color),
      'symmetry': serializer.toJson<String>(symmetry),
      'borders': serializer.toJson<String>(borders),
      'texture': serializer.toJson<String>(texture),
      'summary': serializer.toJson<String>(summary),
    };
  }

  DbSkinLesionRecord copyWith({
    String? id,
    String? spotId,
    String? imagePath,
    String? timestamp,
    Value<String?> latency = const Value.absent(),
    String? lesionType,
    String? color,
    String? symmetry,
    String? borders,
    String? texture,
    String? summary,
  }) => DbSkinLesionRecord(
    id: id ?? this.id,
    spotId: spotId ?? this.spotId,
    imagePath: imagePath ?? this.imagePath,
    timestamp: timestamp ?? this.timestamp,
    latency: latency.present ? latency.value : this.latency,
    lesionType: lesionType ?? this.lesionType,
    color: color ?? this.color,
    symmetry: symmetry ?? this.symmetry,
    borders: borders ?? this.borders,
    texture: texture ?? this.texture,
    summary: summary ?? this.summary,
  );
  DbSkinLesionRecord copyWithCompanion(SkinLesionRecordsCompanion data) {
    return DbSkinLesionRecord(
      id: data.id.present ? data.id.value : this.id,
      spotId: data.spotId.present ? data.spotId.value : this.spotId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      latency: data.latency.present ? data.latency.value : this.latency,
      lesionType: data.lesionType.present
          ? data.lesionType.value
          : this.lesionType,
      color: data.color.present ? data.color.value : this.color,
      symmetry: data.symmetry.present ? data.symmetry.value : this.symmetry,
      borders: data.borders.present ? data.borders.value : this.borders,
      texture: data.texture.present ? data.texture.value : this.texture,
      summary: data.summary.present ? data.summary.value : this.summary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbSkinLesionRecord(')
          ..write('id: $id, ')
          ..write('spotId: $spotId, ')
          ..write('imagePath: $imagePath, ')
          ..write('timestamp: $timestamp, ')
          ..write('latency: $latency, ')
          ..write('lesionType: $lesionType, ')
          ..write('color: $color, ')
          ..write('symmetry: $symmetry, ')
          ..write('borders: $borders, ')
          ..write('texture: $texture, ')
          ..write('summary: $summary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    spotId,
    imagePath,
    timestamp,
    latency,
    lesionType,
    color,
    symmetry,
    borders,
    texture,
    summary,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbSkinLesionRecord &&
          other.id == this.id &&
          other.spotId == this.spotId &&
          other.imagePath == this.imagePath &&
          other.timestamp == this.timestamp &&
          other.latency == this.latency &&
          other.lesionType == this.lesionType &&
          other.color == this.color &&
          other.symmetry == this.symmetry &&
          other.borders == this.borders &&
          other.texture == this.texture &&
          other.summary == this.summary);
}

class SkinLesionRecordsCompanion extends UpdateCompanion<DbSkinLesionRecord> {
  final Value<String> id;
  final Value<String> spotId;
  final Value<String> imagePath;
  final Value<String> timestamp;
  final Value<String?> latency;
  final Value<String> lesionType;
  final Value<String> color;
  final Value<String> symmetry;
  final Value<String> borders;
  final Value<String> texture;
  final Value<String> summary;
  final Value<int> rowid;
  const SkinLesionRecordsCompanion({
    this.id = const Value.absent(),
    this.spotId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.latency = const Value.absent(),
    this.lesionType = const Value.absent(),
    this.color = const Value.absent(),
    this.symmetry = const Value.absent(),
    this.borders = const Value.absent(),
    this.texture = const Value.absent(),
    this.summary = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkinLesionRecordsCompanion.insert({
    required String id,
    required String spotId,
    required String imagePath,
    required String timestamp,
    this.latency = const Value.absent(),
    required String lesionType,
    required String color,
    required String symmetry,
    required String borders,
    required String texture,
    required String summary,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       spotId = Value(spotId),
       imagePath = Value(imagePath),
       timestamp = Value(timestamp),
       lesionType = Value(lesionType),
       color = Value(color),
       symmetry = Value(symmetry),
       borders = Value(borders),
       texture = Value(texture),
       summary = Value(summary);
  static Insertable<DbSkinLesionRecord> custom({
    Expression<String>? id,
    Expression<String>? spotId,
    Expression<String>? imagePath,
    Expression<String>? timestamp,
    Expression<String>? latency,
    Expression<String>? lesionType,
    Expression<String>? color,
    Expression<String>? symmetry,
    Expression<String>? borders,
    Expression<String>? texture,
    Expression<String>? summary,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (spotId != null) 'spot_id': spotId,
      if (imagePath != null) 'image_path': imagePath,
      if (timestamp != null) 'timestamp': timestamp,
      if (latency != null) 'latency': latency,
      if (lesionType != null) 'lesion_type': lesionType,
      if (color != null) 'color': color,
      if (symmetry != null) 'symmetry': symmetry,
      if (borders != null) 'borders': borders,
      if (texture != null) 'texture': texture,
      if (summary != null) 'summary': summary,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkinLesionRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? spotId,
    Value<String>? imagePath,
    Value<String>? timestamp,
    Value<String?>? latency,
    Value<String>? lesionType,
    Value<String>? color,
    Value<String>? symmetry,
    Value<String>? borders,
    Value<String>? texture,
    Value<String>? summary,
    Value<int>? rowid,
  }) {
    return SkinLesionRecordsCompanion(
      id: id ?? this.id,
      spotId: spotId ?? this.spotId,
      imagePath: imagePath ?? this.imagePath,
      timestamp: timestamp ?? this.timestamp,
      latency: latency ?? this.latency,
      lesionType: lesionType ?? this.lesionType,
      color: color ?? this.color,
      symmetry: symmetry ?? this.symmetry,
      borders: borders ?? this.borders,
      texture: texture ?? this.texture,
      summary: summary ?? this.summary,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (spotId.present) {
      map['spot_id'] = Variable<String>(spotId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<String>(timestamp.value);
    }
    if (latency.present) {
      map['latency'] = Variable<String>(latency.value);
    }
    if (lesionType.present) {
      map['lesion_type'] = Variable<String>(lesionType.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (symmetry.present) {
      map['symmetry'] = Variable<String>(symmetry.value);
    }
    if (borders.present) {
      map['borders'] = Variable<String>(borders.value);
    }
    if (texture.present) {
      map['texture'] = Variable<String>(texture.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkinLesionRecordsCompanion(')
          ..write('id: $id, ')
          ..write('spotId: $spotId, ')
          ..write('imagePath: $imagePath, ')
          ..write('timestamp: $timestamp, ')
          ..write('latency: $latency, ')
          ..write('lesionType: $lesionType, ')
          ..write('color: $color, ')
          ..write('symmetry: $symmetry, ')
          ..write('borders: $borders, ')
          ..write('texture: $texture, ')
          ..write('summary: $summary, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BodyPartStatusesTable extends BodyPartStatuses
    with TableInfo<$BodyPartStatusesTable, DbBodyPartStatus> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyPartStatusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyPartMeta = const VerificationMeta(
    'bodyPart',
  );
  @override
  late final GeneratedColumn<String> bodyPart = GeneratedColumn<String>(
    'body_part',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subPartMeta = const VerificationMeta(
    'subPart',
  );
  @override
  late final GeneratedColumn<String> subPart = GeneratedColumn<String>(
    'sub_part',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scanStatusMeta = const VerificationMeta(
    'scanStatus',
  );
  @override
  late final GeneratedColumn<String> scanStatus = GeneratedColumn<String>(
    'scan_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoCountMeta = const VerificationMeta(
    'photoCount',
  );
  @override
  late final GeneratedColumn<int> photoCount = GeneratedColumn<int>(
    'photo_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastScannedMeta = const VerificationMeta(
    'lastScanned',
  );
  @override
  late final GeneratedColumn<DateTime> lastScanned = GeneratedColumn<DateTime>(
    'last_scanned',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bodyPart,
    subPart,
    scanStatus,
    photoCount,
    lastScanned,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_part_statuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbBodyPartStatus> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('body_part')) {
      context.handle(
        _bodyPartMeta,
        bodyPart.isAcceptableOrUnknown(data['body_part']!, _bodyPartMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyPartMeta);
    }
    if (data.containsKey('sub_part')) {
      context.handle(
        _subPartMeta,
        subPart.isAcceptableOrUnknown(data['sub_part']!, _subPartMeta),
      );
    }
    if (data.containsKey('scan_status')) {
      context.handle(
        _scanStatusMeta,
        scanStatus.isAcceptableOrUnknown(data['scan_status']!, _scanStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_scanStatusMeta);
    }
    if (data.containsKey('photo_count')) {
      context.handle(
        _photoCountMeta,
        photoCount.isAcceptableOrUnknown(data['photo_count']!, _photoCountMeta),
      );
    }
    if (data.containsKey('last_scanned')) {
      context.handle(
        _lastScannedMeta,
        lastScanned.isAcceptableOrUnknown(
          data['last_scanned']!,
          _lastScannedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbBodyPartStatus map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBodyPartStatus(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bodyPart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_part'],
      )!,
      subPart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_part'],
      ),
      scanStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scan_status'],
      )!,
      photoCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}photo_count'],
      )!,
      lastScanned: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_scanned'],
      ),
    );
  }

  @override
  $BodyPartStatusesTable createAlias(String alias) {
    return $BodyPartStatusesTable(attachedDatabase, alias);
  }
}

class DbBodyPartStatus extends DataClass
    implements Insertable<DbBodyPartStatus> {
  final String id;
  final String bodyPart;
  final String? subPart;
  final String scanStatus;
  final int photoCount;
  final DateTime? lastScanned;
  const DbBodyPartStatus({
    required this.id,
    required this.bodyPart,
    this.subPart,
    required this.scanStatus,
    required this.photoCount,
    this.lastScanned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['body_part'] = Variable<String>(bodyPart);
    if (!nullToAbsent || subPart != null) {
      map['sub_part'] = Variable<String>(subPart);
    }
    map['scan_status'] = Variable<String>(scanStatus);
    map['photo_count'] = Variable<int>(photoCount);
    if (!nullToAbsent || lastScanned != null) {
      map['last_scanned'] = Variable<DateTime>(lastScanned);
    }
    return map;
  }

  BodyPartStatusesCompanion toCompanion(bool nullToAbsent) {
    return BodyPartStatusesCompanion(
      id: Value(id),
      bodyPart: Value(bodyPart),
      subPart: subPart == null && nullToAbsent
          ? const Value.absent()
          : Value(subPart),
      scanStatus: Value(scanStatus),
      photoCount: Value(photoCount),
      lastScanned: lastScanned == null && nullToAbsent
          ? const Value.absent()
          : Value(lastScanned),
    );
  }

  factory DbBodyPartStatus.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBodyPartStatus(
      id: serializer.fromJson<String>(json['id']),
      bodyPart: serializer.fromJson<String>(json['bodyPart']),
      subPart: serializer.fromJson<String?>(json['subPart']),
      scanStatus: serializer.fromJson<String>(json['scanStatus']),
      photoCount: serializer.fromJson<int>(json['photoCount']),
      lastScanned: serializer.fromJson<DateTime?>(json['lastScanned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bodyPart': serializer.toJson<String>(bodyPart),
      'subPart': serializer.toJson<String?>(subPart),
      'scanStatus': serializer.toJson<String>(scanStatus),
      'photoCount': serializer.toJson<int>(photoCount),
      'lastScanned': serializer.toJson<DateTime?>(lastScanned),
    };
  }

  DbBodyPartStatus copyWith({
    String? id,
    String? bodyPart,
    Value<String?> subPart = const Value.absent(),
    String? scanStatus,
    int? photoCount,
    Value<DateTime?> lastScanned = const Value.absent(),
  }) => DbBodyPartStatus(
    id: id ?? this.id,
    bodyPart: bodyPart ?? this.bodyPart,
    subPart: subPart.present ? subPart.value : this.subPart,
    scanStatus: scanStatus ?? this.scanStatus,
    photoCount: photoCount ?? this.photoCount,
    lastScanned: lastScanned.present ? lastScanned.value : this.lastScanned,
  );
  DbBodyPartStatus copyWithCompanion(BodyPartStatusesCompanion data) {
    return DbBodyPartStatus(
      id: data.id.present ? data.id.value : this.id,
      bodyPart: data.bodyPart.present ? data.bodyPart.value : this.bodyPart,
      subPart: data.subPart.present ? data.subPart.value : this.subPart,
      scanStatus: data.scanStatus.present
          ? data.scanStatus.value
          : this.scanStatus,
      photoCount: data.photoCount.present
          ? data.photoCount.value
          : this.photoCount,
      lastScanned: data.lastScanned.present
          ? data.lastScanned.value
          : this.lastScanned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbBodyPartStatus(')
          ..write('id: $id, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('subPart: $subPart, ')
          ..write('scanStatus: $scanStatus, ')
          ..write('photoCount: $photoCount, ')
          ..write('lastScanned: $lastScanned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bodyPart, subPart, scanStatus, photoCount, lastScanned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBodyPartStatus &&
          other.id == this.id &&
          other.bodyPart == this.bodyPart &&
          other.subPart == this.subPart &&
          other.scanStatus == this.scanStatus &&
          other.photoCount == this.photoCount &&
          other.lastScanned == this.lastScanned);
}

class BodyPartStatusesCompanion extends UpdateCompanion<DbBodyPartStatus> {
  final Value<String> id;
  final Value<String> bodyPart;
  final Value<String?> subPart;
  final Value<String> scanStatus;
  final Value<int> photoCount;
  final Value<DateTime?> lastScanned;
  final Value<int> rowid;
  const BodyPartStatusesCompanion({
    this.id = const Value.absent(),
    this.bodyPart = const Value.absent(),
    this.subPart = const Value.absent(),
    this.scanStatus = const Value.absent(),
    this.photoCount = const Value.absent(),
    this.lastScanned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BodyPartStatusesCompanion.insert({
    required String id,
    required String bodyPart,
    this.subPart = const Value.absent(),
    required String scanStatus,
    this.photoCount = const Value.absent(),
    this.lastScanned = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bodyPart = Value(bodyPart),
       scanStatus = Value(scanStatus);
  static Insertable<DbBodyPartStatus> custom({
    Expression<String>? id,
    Expression<String>? bodyPart,
    Expression<String>? subPart,
    Expression<String>? scanStatus,
    Expression<int>? photoCount,
    Expression<DateTime>? lastScanned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bodyPart != null) 'body_part': bodyPart,
      if (subPart != null) 'sub_part': subPart,
      if (scanStatus != null) 'scan_status': scanStatus,
      if (photoCount != null) 'photo_count': photoCount,
      if (lastScanned != null) 'last_scanned': lastScanned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BodyPartStatusesCompanion copyWith({
    Value<String>? id,
    Value<String>? bodyPart,
    Value<String?>? subPart,
    Value<String>? scanStatus,
    Value<int>? photoCount,
    Value<DateTime?>? lastScanned,
    Value<int>? rowid,
  }) {
    return BodyPartStatusesCompanion(
      id: id ?? this.id,
      bodyPart: bodyPart ?? this.bodyPart,
      subPart: subPart ?? this.subPart,
      scanStatus: scanStatus ?? this.scanStatus,
      photoCount: photoCount ?? this.photoCount,
      lastScanned: lastScanned ?? this.lastScanned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bodyPart.present) {
      map['body_part'] = Variable<String>(bodyPart.value);
    }
    if (subPart.present) {
      map['sub_part'] = Variable<String>(subPart.value);
    }
    if (scanStatus.present) {
      map['scan_status'] = Variable<String>(scanStatus.value);
    }
    if (photoCount.present) {
      map['photo_count'] = Variable<int>(photoCount.value);
    }
    if (lastScanned.present) {
      map['last_scanned'] = Variable<DateTime>(lastScanned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyPartStatusesCompanion(')
          ..write('id: $id, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('subPart: $subPart, ')
          ..write('scanStatus: $scanStatus, ')
          ..write('photoCount: $photoCount, ')
          ..write('lastScanned: $lastScanned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkinReportsTable extends SkinReports
    with TableInfo<$SkinReportsTable, DbSkinReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkinReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportIdMeta = const VerificationMeta(
    'reportId',
  );
  @override
  late final GeneratedColumn<String> reportId = GeneratedColumn<String>(
    'report_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdDateMeta = const VerificationMeta(
    'createdDate',
  );
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
    'created_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pdfPathMeta = const VerificationMeta(
    'pdfPath',
  );
  @override
  late final GeneratedColumn<String> pdfPath = GeneratedColumn<String>(
    'pdf_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filterBodyPartMeta = const VerificationMeta(
    'filterBodyPart',
  );
  @override
  late final GeneratedColumn<String> filterBodyPart = GeneratedColumn<String>(
    'filter_body_part',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateRangeStartMeta = const VerificationMeta(
    'dateRangeStart',
  );
  @override
  late final GeneratedColumn<DateTime> dateRangeStart =
      GeneratedColumn<DateTime>(
        'date_range_start',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dateRangeEndMeta = const VerificationMeta(
    'dateRangeEnd',
  );
  @override
  late final GeneratedColumn<DateTime> dateRangeEnd = GeneratedColumn<DateTime>(
    'date_range_end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPhotosMeta = const VerificationMeta(
    'totalPhotos',
  );
  @override
  late final GeneratedColumn<int> totalPhotos = GeneratedColumn<int>(
    'total_photos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalScansMeta = const VerificationMeta(
    'totalScans',
  );
  @override
  late final GeneratedColumn<int> totalScans = GeneratedColumn<int>(
    'total_scans',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reportId,
    createdDate,
    pdfPath,
    filterBodyPart,
    dateRangeStart,
    dateRangeEnd,
    totalPhotos,
    totalScans,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skin_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbSkinReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('report_id')) {
      context.handle(
        _reportIdMeta,
        reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIdMeta);
    }
    if (data.containsKey('created_date')) {
      context.handle(
        _createdDateMeta,
        createdDate.isAcceptableOrUnknown(
          data['created_date']!,
          _createdDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdDateMeta);
    }
    if (data.containsKey('pdf_path')) {
      context.handle(
        _pdfPathMeta,
        pdfPath.isAcceptableOrUnknown(data['pdf_path']!, _pdfPathMeta),
      );
    } else if (isInserting) {
      context.missing(_pdfPathMeta);
    }
    if (data.containsKey('filter_body_part')) {
      context.handle(
        _filterBodyPartMeta,
        filterBodyPart.isAcceptableOrUnknown(
          data['filter_body_part']!,
          _filterBodyPartMeta,
        ),
      );
    }
    if (data.containsKey('date_range_start')) {
      context.handle(
        _dateRangeStartMeta,
        dateRangeStart.isAcceptableOrUnknown(
          data['date_range_start']!,
          _dateRangeStartMeta,
        ),
      );
    }
    if (data.containsKey('date_range_end')) {
      context.handle(
        _dateRangeEndMeta,
        dateRangeEnd.isAcceptableOrUnknown(
          data['date_range_end']!,
          _dateRangeEndMeta,
        ),
      );
    }
    if (data.containsKey('total_photos')) {
      context.handle(
        _totalPhotosMeta,
        totalPhotos.isAcceptableOrUnknown(
          data['total_photos']!,
          _totalPhotosMeta,
        ),
      );
    }
    if (data.containsKey('total_scans')) {
      context.handle(
        _totalScansMeta,
        totalScans.isAcceptableOrUnknown(data['total_scans']!, _totalScansMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbSkinReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbSkinReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reportId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_id'],
      )!,
      createdDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_date'],
      )!,
      pdfPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_path'],
      )!,
      filterBodyPart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}filter_body_part'],
      ),
      dateRangeStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_range_start'],
      ),
      dateRangeEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_range_end'],
      ),
      totalPhotos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_photos'],
      )!,
      totalScans: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_scans'],
      )!,
    );
  }

  @override
  $SkinReportsTable createAlias(String alias) {
    return $SkinReportsTable(attachedDatabase, alias);
  }
}

class DbSkinReport extends DataClass implements Insertable<DbSkinReport> {
  final String id;
  final String reportId;
  final DateTime createdDate;
  final String pdfPath;
  final String? filterBodyPart;
  final DateTime? dateRangeStart;
  final DateTime? dateRangeEnd;
  final int totalPhotos;
  final int totalScans;
  const DbSkinReport({
    required this.id,
    required this.reportId,
    required this.createdDate,
    required this.pdfPath,
    this.filterBodyPart,
    this.dateRangeStart,
    this.dateRangeEnd,
    required this.totalPhotos,
    required this.totalScans,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['report_id'] = Variable<String>(reportId);
    map['created_date'] = Variable<DateTime>(createdDate);
    map['pdf_path'] = Variable<String>(pdfPath);
    if (!nullToAbsent || filterBodyPart != null) {
      map['filter_body_part'] = Variable<String>(filterBodyPart);
    }
    if (!nullToAbsent || dateRangeStart != null) {
      map['date_range_start'] = Variable<DateTime>(dateRangeStart);
    }
    if (!nullToAbsent || dateRangeEnd != null) {
      map['date_range_end'] = Variable<DateTime>(dateRangeEnd);
    }
    map['total_photos'] = Variable<int>(totalPhotos);
    map['total_scans'] = Variable<int>(totalScans);
    return map;
  }

  SkinReportsCompanion toCompanion(bool nullToAbsent) {
    return SkinReportsCompanion(
      id: Value(id),
      reportId: Value(reportId),
      createdDate: Value(createdDate),
      pdfPath: Value(pdfPath),
      filterBodyPart: filterBodyPart == null && nullToAbsent
          ? const Value.absent()
          : Value(filterBodyPart),
      dateRangeStart: dateRangeStart == null && nullToAbsent
          ? const Value.absent()
          : Value(dateRangeStart),
      dateRangeEnd: dateRangeEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(dateRangeEnd),
      totalPhotos: Value(totalPhotos),
      totalScans: Value(totalScans),
    );
  }

  factory DbSkinReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbSkinReport(
      id: serializer.fromJson<String>(json['id']),
      reportId: serializer.fromJson<String>(json['reportId']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      pdfPath: serializer.fromJson<String>(json['pdfPath']),
      filterBodyPart: serializer.fromJson<String?>(json['filterBodyPart']),
      dateRangeStart: serializer.fromJson<DateTime?>(json['dateRangeStart']),
      dateRangeEnd: serializer.fromJson<DateTime?>(json['dateRangeEnd']),
      totalPhotos: serializer.fromJson<int>(json['totalPhotos']),
      totalScans: serializer.fromJson<int>(json['totalScans']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reportId': serializer.toJson<String>(reportId),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'pdfPath': serializer.toJson<String>(pdfPath),
      'filterBodyPart': serializer.toJson<String?>(filterBodyPart),
      'dateRangeStart': serializer.toJson<DateTime?>(dateRangeStart),
      'dateRangeEnd': serializer.toJson<DateTime?>(dateRangeEnd),
      'totalPhotos': serializer.toJson<int>(totalPhotos),
      'totalScans': serializer.toJson<int>(totalScans),
    };
  }

  DbSkinReport copyWith({
    String? id,
    String? reportId,
    DateTime? createdDate,
    String? pdfPath,
    Value<String?> filterBodyPart = const Value.absent(),
    Value<DateTime?> dateRangeStart = const Value.absent(),
    Value<DateTime?> dateRangeEnd = const Value.absent(),
    int? totalPhotos,
    int? totalScans,
  }) => DbSkinReport(
    id: id ?? this.id,
    reportId: reportId ?? this.reportId,
    createdDate: createdDate ?? this.createdDate,
    pdfPath: pdfPath ?? this.pdfPath,
    filterBodyPart: filterBodyPart.present
        ? filterBodyPart.value
        : this.filterBodyPart,
    dateRangeStart: dateRangeStart.present
        ? dateRangeStart.value
        : this.dateRangeStart,
    dateRangeEnd: dateRangeEnd.present ? dateRangeEnd.value : this.dateRangeEnd,
    totalPhotos: totalPhotos ?? this.totalPhotos,
    totalScans: totalScans ?? this.totalScans,
  );
  DbSkinReport copyWithCompanion(SkinReportsCompanion data) {
    return DbSkinReport(
      id: data.id.present ? data.id.value : this.id,
      reportId: data.reportId.present ? data.reportId.value : this.reportId,
      createdDate: data.createdDate.present
          ? data.createdDate.value
          : this.createdDate,
      pdfPath: data.pdfPath.present ? data.pdfPath.value : this.pdfPath,
      filterBodyPart: data.filterBodyPart.present
          ? data.filterBodyPart.value
          : this.filterBodyPart,
      dateRangeStart: data.dateRangeStart.present
          ? data.dateRangeStart.value
          : this.dateRangeStart,
      dateRangeEnd: data.dateRangeEnd.present
          ? data.dateRangeEnd.value
          : this.dateRangeEnd,
      totalPhotos: data.totalPhotos.present
          ? data.totalPhotos.value
          : this.totalPhotos,
      totalScans: data.totalScans.present
          ? data.totalScans.value
          : this.totalScans,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbSkinReport(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('createdDate: $createdDate, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('filterBodyPart: $filterBodyPart, ')
          ..write('dateRangeStart: $dateRangeStart, ')
          ..write('dateRangeEnd: $dateRangeEnd, ')
          ..write('totalPhotos: $totalPhotos, ')
          ..write('totalScans: $totalScans')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    reportId,
    createdDate,
    pdfPath,
    filterBodyPart,
    dateRangeStart,
    dateRangeEnd,
    totalPhotos,
    totalScans,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbSkinReport &&
          other.id == this.id &&
          other.reportId == this.reportId &&
          other.createdDate == this.createdDate &&
          other.pdfPath == this.pdfPath &&
          other.filterBodyPart == this.filterBodyPart &&
          other.dateRangeStart == this.dateRangeStart &&
          other.dateRangeEnd == this.dateRangeEnd &&
          other.totalPhotos == this.totalPhotos &&
          other.totalScans == this.totalScans);
}

class SkinReportsCompanion extends UpdateCompanion<DbSkinReport> {
  final Value<String> id;
  final Value<String> reportId;
  final Value<DateTime> createdDate;
  final Value<String> pdfPath;
  final Value<String?> filterBodyPart;
  final Value<DateTime?> dateRangeStart;
  final Value<DateTime?> dateRangeEnd;
  final Value<int> totalPhotos;
  final Value<int> totalScans;
  final Value<int> rowid;
  const SkinReportsCompanion({
    this.id = const Value.absent(),
    this.reportId = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.pdfPath = const Value.absent(),
    this.filterBodyPart = const Value.absent(),
    this.dateRangeStart = const Value.absent(),
    this.dateRangeEnd = const Value.absent(),
    this.totalPhotos = const Value.absent(),
    this.totalScans = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkinReportsCompanion.insert({
    required String id,
    required String reportId,
    required DateTime createdDate,
    required String pdfPath,
    this.filterBodyPart = const Value.absent(),
    this.dateRangeStart = const Value.absent(),
    this.dateRangeEnd = const Value.absent(),
    this.totalPhotos = const Value.absent(),
    this.totalScans = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reportId = Value(reportId),
       createdDate = Value(createdDate),
       pdfPath = Value(pdfPath);
  static Insertable<DbSkinReport> custom({
    Expression<String>? id,
    Expression<String>? reportId,
    Expression<DateTime>? createdDate,
    Expression<String>? pdfPath,
    Expression<String>? filterBodyPart,
    Expression<DateTime>? dateRangeStart,
    Expression<DateTime>? dateRangeEnd,
    Expression<int>? totalPhotos,
    Expression<int>? totalScans,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportId != null) 'report_id': reportId,
      if (createdDate != null) 'created_date': createdDate,
      if (pdfPath != null) 'pdf_path': pdfPath,
      if (filterBodyPart != null) 'filter_body_part': filterBodyPart,
      if (dateRangeStart != null) 'date_range_start': dateRangeStart,
      if (dateRangeEnd != null) 'date_range_end': dateRangeEnd,
      if (totalPhotos != null) 'total_photos': totalPhotos,
      if (totalScans != null) 'total_scans': totalScans,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkinReportsCompanion copyWith({
    Value<String>? id,
    Value<String>? reportId,
    Value<DateTime>? createdDate,
    Value<String>? pdfPath,
    Value<String?>? filterBodyPart,
    Value<DateTime?>? dateRangeStart,
    Value<DateTime?>? dateRangeEnd,
    Value<int>? totalPhotos,
    Value<int>? totalScans,
    Value<int>? rowid,
  }) {
    return SkinReportsCompanion(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      createdDate: createdDate ?? this.createdDate,
      pdfPath: pdfPath ?? this.pdfPath,
      filterBodyPart: filterBodyPart ?? this.filterBodyPart,
      dateRangeStart: dateRangeStart ?? this.dateRangeStart,
      dateRangeEnd: dateRangeEnd ?? this.dateRangeEnd,
      totalPhotos: totalPhotos ?? this.totalPhotos,
      totalScans: totalScans ?? this.totalScans,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<String>(reportId.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (pdfPath.present) {
      map['pdf_path'] = Variable<String>(pdfPath.value);
    }
    if (filterBodyPart.present) {
      map['filter_body_part'] = Variable<String>(filterBodyPart.value);
    }
    if (dateRangeStart.present) {
      map['date_range_start'] = Variable<DateTime>(dateRangeStart.value);
    }
    if (dateRangeEnd.present) {
      map['date_range_end'] = Variable<DateTime>(dateRangeEnd.value);
    }
    if (totalPhotos.present) {
      map['total_photos'] = Variable<int>(totalPhotos.value);
    }
    if (totalScans.present) {
      map['total_scans'] = Variable<int>(totalScans.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkinReportsCompanion(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('createdDate: $createdDate, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('filterBodyPart: $filterBodyPart, ')
          ..write('dateRangeStart: $dateRangeStart, ')
          ..write('dateRangeEnd: $dateRangeEnd, ')
          ..write('totalPhotos: $totalPhotos, ')
          ..write('totalScans: $totalScans, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SkinSpotsTable skinSpots = $SkinSpotsTable(this);
  late final $SkinSpotPhotosTable skinSpotPhotos = $SkinSpotPhotosTable(this);
  late final $SkinLesionRecordsTable skinLesionRecords =
      $SkinLesionRecordsTable(this);
  late final $BodyPartStatusesTable bodyPartStatuses = $BodyPartStatusesTable(
    this,
  );
  late final $SkinReportsTable skinReports = $SkinReportsTable(this);
  late final SkinSpotDao skinSpotDao = SkinSpotDao(this as AppDatabase);
  late final BodyPartStatusDao bodyPartStatusDao = BodyPartStatusDao(
    this as AppDatabase,
  );
  late final SkinReportDao skinReportDao = SkinReportDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    skinSpots,
    skinSpotPhotos,
    skinLesionRecords,
    bodyPartStatuses,
    skinReports,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'skin_spots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('skin_spot_photos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'skin_spots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('skin_lesion_records', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SkinSpotsTableCreateCompanionBuilder =
    SkinSpotsCompanion Function({
      required String id,
      required String title,
      Value<String?> notes,
      required DateTime createdDate,
      required DateTime lastModified,
      required String bodyPart,
      Value<String?> subPart,
      Value<int> rowid,
    });
typedef $$SkinSpotsTableUpdateCompanionBuilder =
    SkinSpotsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> notes,
      Value<DateTime> createdDate,
      Value<DateTime> lastModified,
      Value<String> bodyPart,
      Value<String?> subPart,
      Value<int> rowid,
    });

final class $$SkinSpotsTableReferences
    extends BaseReferences<_$AppDatabase, $SkinSpotsTable, DbSkinSpot> {
  $$SkinSpotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SkinSpotPhotosTable, List<DbSkinSpotPhoto>>
  _skinSpotPhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.skinSpotPhotos,
    aliasName: $_aliasNameGenerator(db.skinSpots.id, db.skinSpotPhotos.spotId),
  );

  $$SkinSpotPhotosTableProcessedTableManager get skinSpotPhotosRefs {
    final manager = $$SkinSpotPhotosTableTableManager(
      $_db,
      $_db.skinSpotPhotos,
    ).filter((f) => f.spotId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_skinSpotPhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SkinLesionRecordsTable, List<DbSkinLesionRecord>>
  _skinLesionRecordsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.skinLesionRecords,
        aliasName: $_aliasNameGenerator(
          db.skinSpots.id,
          db.skinLesionRecords.spotId,
        ),
      );

  $$SkinLesionRecordsTableProcessedTableManager get skinLesionRecordsRefs {
    final manager = $$SkinLesionRecordsTableTableManager(
      $_db,
      $_db.skinLesionRecords,
    ).filter((f) => f.spotId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _skinLesionRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SkinSpotsTableFilterComposer
    extends Composer<_$AppDatabase, $SkinSpotsTable> {
  $$SkinSpotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyPart => $composableBuilder(
    column: $table.bodyPart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subPart => $composableBuilder(
    column: $table.subPart,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> skinSpotPhotosRefs(
    Expression<bool> Function($$SkinSpotPhotosTableFilterComposer f) f,
  ) {
    final $$SkinSpotPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skinSpotPhotos,
      getReferencedColumn: (t) => t.spotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkinSpotPhotosTableFilterComposer(
            $db: $db,
            $table: $db.skinSpotPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> skinLesionRecordsRefs(
    Expression<bool> Function($$SkinLesionRecordsTableFilterComposer f) f,
  ) {
    final $$SkinLesionRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skinLesionRecords,
      getReferencedColumn: (t) => t.spotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkinLesionRecordsTableFilterComposer(
            $db: $db,
            $table: $db.skinLesionRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkinSpotsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkinSpotsTable> {
  $$SkinSpotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyPart => $composableBuilder(
    column: $table.bodyPart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subPart => $composableBuilder(
    column: $table.subPart,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkinSpotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkinSpotsTable> {
  $$SkinSpotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyPart =>
      $composableBuilder(column: $table.bodyPart, builder: (column) => column);

  GeneratedColumn<String> get subPart =>
      $composableBuilder(column: $table.subPart, builder: (column) => column);

  Expression<T> skinSpotPhotosRefs<T extends Object>(
    Expression<T> Function($$SkinSpotPhotosTableAnnotationComposer a) f,
  ) {
    final $$SkinSpotPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skinSpotPhotos,
      getReferencedColumn: (t) => t.spotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkinSpotPhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.skinSpotPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> skinLesionRecordsRefs<T extends Object>(
    Expression<T> Function($$SkinLesionRecordsTableAnnotationComposer a) f,
  ) {
    final $$SkinLesionRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.skinLesionRecords,
          getReferencedColumn: (t) => t.spotId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SkinLesionRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.skinLesionRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SkinSpotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkinSpotsTable,
          DbSkinSpot,
          $$SkinSpotsTableFilterComposer,
          $$SkinSpotsTableOrderingComposer,
          $$SkinSpotsTableAnnotationComposer,
          $$SkinSpotsTableCreateCompanionBuilder,
          $$SkinSpotsTableUpdateCompanionBuilder,
          (DbSkinSpot, $$SkinSpotsTableReferences),
          DbSkinSpot,
          PrefetchHooks Function({
            bool skinSpotPhotosRefs,
            bool skinLesionRecordsRefs,
          })
        > {
  $$SkinSpotsTableTableManager(_$AppDatabase db, $SkinSpotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkinSpotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkinSpotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkinSpotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdDate = const Value.absent(),
                Value<DateTime> lastModified = const Value.absent(),
                Value<String> bodyPart = const Value.absent(),
                Value<String?> subPart = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkinSpotsCompanion(
                id: id,
                title: title,
                notes: notes,
                createdDate: createdDate,
                lastModified: lastModified,
                bodyPart: bodyPart,
                subPart: subPart,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> notes = const Value.absent(),
                required DateTime createdDate,
                required DateTime lastModified,
                required String bodyPart,
                Value<String?> subPart = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkinSpotsCompanion.insert(
                id: id,
                title: title,
                notes: notes,
                createdDate: createdDate,
                lastModified: lastModified,
                bodyPart: bodyPart,
                subPart: subPart,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SkinSpotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({skinSpotPhotosRefs = false, skinLesionRecordsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (skinSpotPhotosRefs) db.skinSpotPhotos,
                    if (skinLesionRecordsRefs) db.skinLesionRecords,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (skinSpotPhotosRefs)
                        await $_getPrefetchedData<
                          DbSkinSpot,
                          $SkinSpotsTable,
                          DbSkinSpotPhoto
                        >(
                          currentTable: table,
                          referencedTable: $$SkinSpotsTableReferences
                              ._skinSpotPhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkinSpotsTableReferences(
                                db,
                                table,
                                p0,
                              ).skinSpotPhotosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.spotId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (skinLesionRecordsRefs)
                        await $_getPrefetchedData<
                          DbSkinSpot,
                          $SkinSpotsTable,
                          DbSkinLesionRecord
                        >(
                          currentTable: table,
                          referencedTable: $$SkinSpotsTableReferences
                              ._skinLesionRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkinSpotsTableReferences(
                                db,
                                table,
                                p0,
                              ).skinLesionRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.spotId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SkinSpotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkinSpotsTable,
      DbSkinSpot,
      $$SkinSpotsTableFilterComposer,
      $$SkinSpotsTableOrderingComposer,
      $$SkinSpotsTableAnnotationComposer,
      $$SkinSpotsTableCreateCompanionBuilder,
      $$SkinSpotsTableUpdateCompanionBuilder,
      (DbSkinSpot, $$SkinSpotsTableReferences),
      DbSkinSpot,
      PrefetchHooks Function({
        bool skinSpotPhotosRefs,
        bool skinLesionRecordsRefs,
      })
    >;
typedef $$SkinSpotPhotosTableCreateCompanionBuilder =
    SkinSpotPhotosCompanion Function({
      required String id,
      required String spotId,
      Value<String?> imagePath,
      required DateTime dateTaken,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$SkinSpotPhotosTableUpdateCompanionBuilder =
    SkinSpotPhotosCompanion Function({
      Value<String> id,
      Value<String> spotId,
      Value<String?> imagePath,
      Value<DateTime> dateTaken,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$SkinSpotPhotosTableReferences
    extends
        BaseReferences<_$AppDatabase, $SkinSpotPhotosTable, DbSkinSpotPhoto> {
  $$SkinSpotPhotosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SkinSpotsTable _spotIdTable(_$AppDatabase db) =>
      db.skinSpots.createAlias(
        $_aliasNameGenerator(db.skinSpotPhotos.spotId, db.skinSpots.id),
      );

  $$SkinSpotsTableProcessedTableManager get spotId {
    final $_column = $_itemColumn<String>('spot_id')!;

    final manager = $$SkinSpotsTableTableManager(
      $_db,
      $_db.skinSpots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_spotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SkinSpotPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $SkinSpotPhotosTable> {
  $$SkinSpotPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateTaken => $composableBuilder(
    column: $table.dateTaken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$SkinSpotsTableFilterComposer get spotId {
    final $$SkinSpotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spotId,
      referencedTable: $db.skinSpots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkinSpotsTableFilterComposer(
            $db: $db,
            $table: $db.skinSpots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkinSpotPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $SkinSpotPhotosTable> {
  $$SkinSpotPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateTaken => $composableBuilder(
    column: $table.dateTaken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkinSpotsTableOrderingComposer get spotId {
    final $$SkinSpotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spotId,
      referencedTable: $db.skinSpots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkinSpotsTableOrderingComposer(
            $db: $db,
            $table: $db.skinSpots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkinSpotPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkinSpotPhotosTable> {
  $$SkinSpotPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get dateTaken =>
      $composableBuilder(column: $table.dateTaken, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$SkinSpotsTableAnnotationComposer get spotId {
    final $$SkinSpotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spotId,
      referencedTable: $db.skinSpots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkinSpotsTableAnnotationComposer(
            $db: $db,
            $table: $db.skinSpots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkinSpotPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkinSpotPhotosTable,
          DbSkinSpotPhoto,
          $$SkinSpotPhotosTableFilterComposer,
          $$SkinSpotPhotosTableOrderingComposer,
          $$SkinSpotPhotosTableAnnotationComposer,
          $$SkinSpotPhotosTableCreateCompanionBuilder,
          $$SkinSpotPhotosTableUpdateCompanionBuilder,
          (DbSkinSpotPhoto, $$SkinSpotPhotosTableReferences),
          DbSkinSpotPhoto,
          PrefetchHooks Function({bool spotId})
        > {
  $$SkinSpotPhotosTableTableManager(
    _$AppDatabase db,
    $SkinSpotPhotosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkinSpotPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkinSpotPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkinSpotPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> spotId = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime> dateTaken = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkinSpotPhotosCompanion(
                id: id,
                spotId: spotId,
                imagePath: imagePath,
                dateTaken: dateTaken,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String spotId,
                Value<String?> imagePath = const Value.absent(),
                required DateTime dateTaken,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkinSpotPhotosCompanion.insert(
                id: id,
                spotId: spotId,
                imagePath: imagePath,
                dateTaken: dateTaken,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SkinSpotPhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({spotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (spotId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.spotId,
                                referencedTable: $$SkinSpotPhotosTableReferences
                                    ._spotIdTable(db),
                                referencedColumn:
                                    $$SkinSpotPhotosTableReferences
                                        ._spotIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SkinSpotPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkinSpotPhotosTable,
      DbSkinSpotPhoto,
      $$SkinSpotPhotosTableFilterComposer,
      $$SkinSpotPhotosTableOrderingComposer,
      $$SkinSpotPhotosTableAnnotationComposer,
      $$SkinSpotPhotosTableCreateCompanionBuilder,
      $$SkinSpotPhotosTableUpdateCompanionBuilder,
      (DbSkinSpotPhoto, $$SkinSpotPhotosTableReferences),
      DbSkinSpotPhoto,
      PrefetchHooks Function({bool spotId})
    >;
typedef $$SkinLesionRecordsTableCreateCompanionBuilder =
    SkinLesionRecordsCompanion Function({
      required String id,
      required String spotId,
      required String imagePath,
      required String timestamp,
      Value<String?> latency,
      required String lesionType,
      required String color,
      required String symmetry,
      required String borders,
      required String texture,
      required String summary,
      Value<int> rowid,
    });
typedef $$SkinLesionRecordsTableUpdateCompanionBuilder =
    SkinLesionRecordsCompanion Function({
      Value<String> id,
      Value<String> spotId,
      Value<String> imagePath,
      Value<String> timestamp,
      Value<String?> latency,
      Value<String> lesionType,
      Value<String> color,
      Value<String> symmetry,
      Value<String> borders,
      Value<String> texture,
      Value<String> summary,
      Value<int> rowid,
    });

final class $$SkinLesionRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SkinLesionRecordsTable,
          DbSkinLesionRecord
        > {
  $$SkinLesionRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SkinSpotsTable _spotIdTable(_$AppDatabase db) =>
      db.skinSpots.createAlias(
        $_aliasNameGenerator(db.skinLesionRecords.spotId, db.skinSpots.id),
      );

  $$SkinSpotsTableProcessedTableManager get spotId {
    final $_column = $_itemColumn<String>('spot_id')!;

    final manager = $$SkinSpotsTableTableManager(
      $_db,
      $_db.skinSpots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_spotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SkinLesionRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $SkinLesionRecordsTable> {
  $$SkinLesionRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get latency => $composableBuilder(
    column: $table.latency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lesionType => $composableBuilder(
    column: $table.lesionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symmetry => $composableBuilder(
    column: $table.symmetry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get borders => $composableBuilder(
    column: $table.borders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get texture => $composableBuilder(
    column: $table.texture,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  $$SkinSpotsTableFilterComposer get spotId {
    final $$SkinSpotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spotId,
      referencedTable: $db.skinSpots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkinSpotsTableFilterComposer(
            $db: $db,
            $table: $db.skinSpots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkinLesionRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkinLesionRecordsTable> {
  $$SkinLesionRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get latency => $composableBuilder(
    column: $table.latency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lesionType => $composableBuilder(
    column: $table.lesionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symmetry => $composableBuilder(
    column: $table.symmetry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get borders => $composableBuilder(
    column: $table.borders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get texture => $composableBuilder(
    column: $table.texture,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  $$SkinSpotsTableOrderingComposer get spotId {
    final $$SkinSpotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spotId,
      referencedTable: $db.skinSpots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkinSpotsTableOrderingComposer(
            $db: $db,
            $table: $db.skinSpots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkinLesionRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkinLesionRecordsTable> {
  $$SkinLesionRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get latency =>
      $composableBuilder(column: $table.latency, builder: (column) => column);

  GeneratedColumn<String> get lesionType => $composableBuilder(
    column: $table.lesionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get symmetry =>
      $composableBuilder(column: $table.symmetry, builder: (column) => column);

  GeneratedColumn<String> get borders =>
      $composableBuilder(column: $table.borders, builder: (column) => column);

  GeneratedColumn<String> get texture =>
      $composableBuilder(column: $table.texture, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  $$SkinSpotsTableAnnotationComposer get spotId {
    final $$SkinSpotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spotId,
      referencedTable: $db.skinSpots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkinSpotsTableAnnotationComposer(
            $db: $db,
            $table: $db.skinSpots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkinLesionRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkinLesionRecordsTable,
          DbSkinLesionRecord,
          $$SkinLesionRecordsTableFilterComposer,
          $$SkinLesionRecordsTableOrderingComposer,
          $$SkinLesionRecordsTableAnnotationComposer,
          $$SkinLesionRecordsTableCreateCompanionBuilder,
          $$SkinLesionRecordsTableUpdateCompanionBuilder,
          (DbSkinLesionRecord, $$SkinLesionRecordsTableReferences),
          DbSkinLesionRecord,
          PrefetchHooks Function({bool spotId})
        > {
  $$SkinLesionRecordsTableTableManager(
    _$AppDatabase db,
    $SkinLesionRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkinLesionRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkinLesionRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkinLesionRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> spotId = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<String> timestamp = const Value.absent(),
                Value<String?> latency = const Value.absent(),
                Value<String> lesionType = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<String> symmetry = const Value.absent(),
                Value<String> borders = const Value.absent(),
                Value<String> texture = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkinLesionRecordsCompanion(
                id: id,
                spotId: spotId,
                imagePath: imagePath,
                timestamp: timestamp,
                latency: latency,
                lesionType: lesionType,
                color: color,
                symmetry: symmetry,
                borders: borders,
                texture: texture,
                summary: summary,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String spotId,
                required String imagePath,
                required String timestamp,
                Value<String?> latency = const Value.absent(),
                required String lesionType,
                required String color,
                required String symmetry,
                required String borders,
                required String texture,
                required String summary,
                Value<int> rowid = const Value.absent(),
              }) => SkinLesionRecordsCompanion.insert(
                id: id,
                spotId: spotId,
                imagePath: imagePath,
                timestamp: timestamp,
                latency: latency,
                lesionType: lesionType,
                color: color,
                symmetry: symmetry,
                borders: borders,
                texture: texture,
                summary: summary,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SkinLesionRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({spotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (spotId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.spotId,
                                referencedTable:
                                    $$SkinLesionRecordsTableReferences
                                        ._spotIdTable(db),
                                referencedColumn:
                                    $$SkinLesionRecordsTableReferences
                                        ._spotIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SkinLesionRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkinLesionRecordsTable,
      DbSkinLesionRecord,
      $$SkinLesionRecordsTableFilterComposer,
      $$SkinLesionRecordsTableOrderingComposer,
      $$SkinLesionRecordsTableAnnotationComposer,
      $$SkinLesionRecordsTableCreateCompanionBuilder,
      $$SkinLesionRecordsTableUpdateCompanionBuilder,
      (DbSkinLesionRecord, $$SkinLesionRecordsTableReferences),
      DbSkinLesionRecord,
      PrefetchHooks Function({bool spotId})
    >;
typedef $$BodyPartStatusesTableCreateCompanionBuilder =
    BodyPartStatusesCompanion Function({
      required String id,
      required String bodyPart,
      Value<String?> subPart,
      required String scanStatus,
      Value<int> photoCount,
      Value<DateTime?> lastScanned,
      Value<int> rowid,
    });
typedef $$BodyPartStatusesTableUpdateCompanionBuilder =
    BodyPartStatusesCompanion Function({
      Value<String> id,
      Value<String> bodyPart,
      Value<String?> subPart,
      Value<String> scanStatus,
      Value<int> photoCount,
      Value<DateTime?> lastScanned,
      Value<int> rowid,
    });

class $$BodyPartStatusesTableFilterComposer
    extends Composer<_$AppDatabase, $BodyPartStatusesTable> {
  $$BodyPartStatusesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyPart => $composableBuilder(
    column: $table.bodyPart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subPart => $composableBuilder(
    column: $table.subPart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scanStatus => $composableBuilder(
    column: $table.scanStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get photoCount => $composableBuilder(
    column: $table.photoCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastScanned => $composableBuilder(
    column: $table.lastScanned,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BodyPartStatusesTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyPartStatusesTable> {
  $$BodyPartStatusesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyPart => $composableBuilder(
    column: $table.bodyPart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subPart => $composableBuilder(
    column: $table.subPart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scanStatus => $composableBuilder(
    column: $table.scanStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get photoCount => $composableBuilder(
    column: $table.photoCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastScanned => $composableBuilder(
    column: $table.lastScanned,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyPartStatusesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyPartStatusesTable> {
  $$BodyPartStatusesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bodyPart =>
      $composableBuilder(column: $table.bodyPart, builder: (column) => column);

  GeneratedColumn<String> get subPart =>
      $composableBuilder(column: $table.subPart, builder: (column) => column);

  GeneratedColumn<String> get scanStatus => $composableBuilder(
    column: $table.scanStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get photoCount => $composableBuilder(
    column: $table.photoCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastScanned => $composableBuilder(
    column: $table.lastScanned,
    builder: (column) => column,
  );
}

class $$BodyPartStatusesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyPartStatusesTable,
          DbBodyPartStatus,
          $$BodyPartStatusesTableFilterComposer,
          $$BodyPartStatusesTableOrderingComposer,
          $$BodyPartStatusesTableAnnotationComposer,
          $$BodyPartStatusesTableCreateCompanionBuilder,
          $$BodyPartStatusesTableUpdateCompanionBuilder,
          (
            DbBodyPartStatus,
            BaseReferences<
              _$AppDatabase,
              $BodyPartStatusesTable,
              DbBodyPartStatus
            >,
          ),
          DbBodyPartStatus,
          PrefetchHooks Function()
        > {
  $$BodyPartStatusesTableTableManager(
    _$AppDatabase db,
    $BodyPartStatusesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyPartStatusesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyPartStatusesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyPartStatusesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bodyPart = const Value.absent(),
                Value<String?> subPart = const Value.absent(),
                Value<String> scanStatus = const Value.absent(),
                Value<int> photoCount = const Value.absent(),
                Value<DateTime?> lastScanned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyPartStatusesCompanion(
                id: id,
                bodyPart: bodyPart,
                subPart: subPart,
                scanStatus: scanStatus,
                photoCount: photoCount,
                lastScanned: lastScanned,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String bodyPart,
                Value<String?> subPart = const Value.absent(),
                required String scanStatus,
                Value<int> photoCount = const Value.absent(),
                Value<DateTime?> lastScanned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyPartStatusesCompanion.insert(
                id: id,
                bodyPart: bodyPart,
                subPart: subPart,
                scanStatus: scanStatus,
                photoCount: photoCount,
                lastScanned: lastScanned,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BodyPartStatusesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyPartStatusesTable,
      DbBodyPartStatus,
      $$BodyPartStatusesTableFilterComposer,
      $$BodyPartStatusesTableOrderingComposer,
      $$BodyPartStatusesTableAnnotationComposer,
      $$BodyPartStatusesTableCreateCompanionBuilder,
      $$BodyPartStatusesTableUpdateCompanionBuilder,
      (
        DbBodyPartStatus,
        BaseReferences<_$AppDatabase, $BodyPartStatusesTable, DbBodyPartStatus>,
      ),
      DbBodyPartStatus,
      PrefetchHooks Function()
    >;
typedef $$SkinReportsTableCreateCompanionBuilder =
    SkinReportsCompanion Function({
      required String id,
      required String reportId,
      required DateTime createdDate,
      required String pdfPath,
      Value<String?> filterBodyPart,
      Value<DateTime?> dateRangeStart,
      Value<DateTime?> dateRangeEnd,
      Value<int> totalPhotos,
      Value<int> totalScans,
      Value<int> rowid,
    });
typedef $$SkinReportsTableUpdateCompanionBuilder =
    SkinReportsCompanion Function({
      Value<String> id,
      Value<String> reportId,
      Value<DateTime> createdDate,
      Value<String> pdfPath,
      Value<String?> filterBodyPart,
      Value<DateTime?> dateRangeStart,
      Value<DateTime?> dateRangeEnd,
      Value<int> totalPhotos,
      Value<int> totalScans,
      Value<int> rowid,
    });

class $$SkinReportsTableFilterComposer
    extends Composer<_$AppDatabase, $SkinReportsTable> {
  $$SkinReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportId => $composableBuilder(
    column: $table.reportId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filterBodyPart => $composableBuilder(
    column: $table.filterBodyPart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateRangeStart => $composableBuilder(
    column: $table.dateRangeStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateRangeEnd => $composableBuilder(
    column: $table.dateRangeEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPhotos => $composableBuilder(
    column: $table.totalPhotos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalScans => $composableBuilder(
    column: $table.totalScans,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkinReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkinReportsTable> {
  $$SkinReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportId => $composableBuilder(
    column: $table.reportId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filterBodyPart => $composableBuilder(
    column: $table.filterBodyPart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateRangeStart => $composableBuilder(
    column: $table.dateRangeStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateRangeEnd => $composableBuilder(
    column: $table.dateRangeEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPhotos => $composableBuilder(
    column: $table.totalPhotos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalScans => $composableBuilder(
    column: $table.totalScans,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkinReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkinReportsTable> {
  $$SkinReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reportId =>
      $composableBuilder(column: $table.reportId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pdfPath =>
      $composableBuilder(column: $table.pdfPath, builder: (column) => column);

  GeneratedColumn<String> get filterBodyPart => $composableBuilder(
    column: $table.filterBodyPart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateRangeStart => $composableBuilder(
    column: $table.dateRangeStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateRangeEnd => $composableBuilder(
    column: $table.dateRangeEnd,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPhotos => $composableBuilder(
    column: $table.totalPhotos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalScans => $composableBuilder(
    column: $table.totalScans,
    builder: (column) => column,
  );
}

class $$SkinReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkinReportsTable,
          DbSkinReport,
          $$SkinReportsTableFilterComposer,
          $$SkinReportsTableOrderingComposer,
          $$SkinReportsTableAnnotationComposer,
          $$SkinReportsTableCreateCompanionBuilder,
          $$SkinReportsTableUpdateCompanionBuilder,
          (
            DbSkinReport,
            BaseReferences<_$AppDatabase, $SkinReportsTable, DbSkinReport>,
          ),
          DbSkinReport,
          PrefetchHooks Function()
        > {
  $$SkinReportsTableTableManager(_$AppDatabase db, $SkinReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkinReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkinReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkinReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reportId = const Value.absent(),
                Value<DateTime> createdDate = const Value.absent(),
                Value<String> pdfPath = const Value.absent(),
                Value<String?> filterBodyPart = const Value.absent(),
                Value<DateTime?> dateRangeStart = const Value.absent(),
                Value<DateTime?> dateRangeEnd = const Value.absent(),
                Value<int> totalPhotos = const Value.absent(),
                Value<int> totalScans = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkinReportsCompanion(
                id: id,
                reportId: reportId,
                createdDate: createdDate,
                pdfPath: pdfPath,
                filterBodyPart: filterBodyPart,
                dateRangeStart: dateRangeStart,
                dateRangeEnd: dateRangeEnd,
                totalPhotos: totalPhotos,
                totalScans: totalScans,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reportId,
                required DateTime createdDate,
                required String pdfPath,
                Value<String?> filterBodyPart = const Value.absent(),
                Value<DateTime?> dateRangeStart = const Value.absent(),
                Value<DateTime?> dateRangeEnd = const Value.absent(),
                Value<int> totalPhotos = const Value.absent(),
                Value<int> totalScans = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkinReportsCompanion.insert(
                id: id,
                reportId: reportId,
                createdDate: createdDate,
                pdfPath: pdfPath,
                filterBodyPart: filterBodyPart,
                dateRangeStart: dateRangeStart,
                dateRangeEnd: dateRangeEnd,
                totalPhotos: totalPhotos,
                totalScans: totalScans,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkinReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkinReportsTable,
      DbSkinReport,
      $$SkinReportsTableFilterComposer,
      $$SkinReportsTableOrderingComposer,
      $$SkinReportsTableAnnotationComposer,
      $$SkinReportsTableCreateCompanionBuilder,
      $$SkinReportsTableUpdateCompanionBuilder,
      (
        DbSkinReport,
        BaseReferences<_$AppDatabase, $SkinReportsTable, DbSkinReport>,
      ),
      DbSkinReport,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SkinSpotsTableTableManager get skinSpots =>
      $$SkinSpotsTableTableManager(_db, _db.skinSpots);
  $$SkinSpotPhotosTableTableManager get skinSpotPhotos =>
      $$SkinSpotPhotosTableTableManager(_db, _db.skinSpotPhotos);
  $$SkinLesionRecordsTableTableManager get skinLesionRecords =>
      $$SkinLesionRecordsTableTableManager(_db, _db.skinLesionRecords);
  $$BodyPartStatusesTableTableManager get bodyPartStatuses =>
      $$BodyPartStatusesTableTableManager(_db, _db.bodyPartStatuses);
  $$SkinReportsTableTableManager get skinReports =>
      $$SkinReportsTableTableManager(_db, _db.skinReports);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'a188f9c78347d4338ccc17de69e874dfff3d898d';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
