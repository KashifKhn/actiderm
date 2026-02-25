// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skin_spot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SkinSpot {

 String get id; String get title; String? get notes; List<SkinSpotPhoto> get photos; DateTime get createdDate; DateTime get lastModified; BodyPart get bodyPart; BodySubPart? get subPart; SkinLesionRecord? get analysisRecord;
/// Create a copy of SkinSpot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkinSpotCopyWith<SkinSpot> get copyWith => _$SkinSpotCopyWithImpl<SkinSpot>(this as SkinSpot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkinSpot&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.bodyPart, bodyPart) || other.bodyPart == bodyPart)&&(identical(other.subPart, subPart) || other.subPart == subPart)&&(identical(other.analysisRecord, analysisRecord) || other.analysisRecord == analysisRecord));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,notes,const DeepCollectionEquality().hash(photos),createdDate,lastModified,bodyPart,subPart,analysisRecord);

@override
String toString() {
  return 'SkinSpot(id: $id, title: $title, notes: $notes, photos: $photos, createdDate: $createdDate, lastModified: $lastModified, bodyPart: $bodyPart, subPart: $subPart, analysisRecord: $analysisRecord)';
}


}

/// @nodoc
abstract mixin class $SkinSpotCopyWith<$Res>  {
  factory $SkinSpotCopyWith(SkinSpot value, $Res Function(SkinSpot) _then) = _$SkinSpotCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? notes, List<SkinSpotPhoto> photos, DateTime createdDate, DateTime lastModified, BodyPart bodyPart, BodySubPart? subPart, SkinLesionRecord? analysisRecord
});


$SkinLesionRecordCopyWith<$Res>? get analysisRecord;

}
/// @nodoc
class _$SkinSpotCopyWithImpl<$Res>
    implements $SkinSpotCopyWith<$Res> {
  _$SkinSpotCopyWithImpl(this._self, this._then);

  final SkinSpot _self;
  final $Res Function(SkinSpot) _then;

/// Create a copy of SkinSpot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? notes = freezed,Object? photos = null,Object? createdDate = null,Object? lastModified = null,Object? bodyPart = null,Object? subPart = freezed,Object? analysisRecord = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<SkinSpotPhoto>,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastModified: null == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as DateTime,bodyPart: null == bodyPart ? _self.bodyPart : bodyPart // ignore: cast_nullable_to_non_nullable
as BodyPart,subPart: freezed == subPart ? _self.subPart : subPart // ignore: cast_nullable_to_non_nullable
as BodySubPart?,analysisRecord: freezed == analysisRecord ? _self.analysisRecord : analysisRecord // ignore: cast_nullable_to_non_nullable
as SkinLesionRecord?,
  ));
}
/// Create a copy of SkinSpot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkinLesionRecordCopyWith<$Res>? get analysisRecord {
    if (_self.analysisRecord == null) {
    return null;
  }

  return $SkinLesionRecordCopyWith<$Res>(_self.analysisRecord!, (value) {
    return _then(_self.copyWith(analysisRecord: value));
  });
}
}


/// Adds pattern-matching-related methods to [SkinSpot].
extension SkinSpotPatterns on SkinSpot {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkinSpot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkinSpot() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkinSpot value)  $default,){
final _that = this;
switch (_that) {
case _SkinSpot():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkinSpot value)?  $default,){
final _that = this;
switch (_that) {
case _SkinSpot() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? notes,  List<SkinSpotPhoto> photos,  DateTime createdDate,  DateTime lastModified,  BodyPart bodyPart,  BodySubPart? subPart,  SkinLesionRecord? analysisRecord)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkinSpot() when $default != null:
return $default(_that.id,_that.title,_that.notes,_that.photos,_that.createdDate,_that.lastModified,_that.bodyPart,_that.subPart,_that.analysisRecord);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? notes,  List<SkinSpotPhoto> photos,  DateTime createdDate,  DateTime lastModified,  BodyPart bodyPart,  BodySubPart? subPart,  SkinLesionRecord? analysisRecord)  $default,) {final _that = this;
switch (_that) {
case _SkinSpot():
return $default(_that.id,_that.title,_that.notes,_that.photos,_that.createdDate,_that.lastModified,_that.bodyPart,_that.subPart,_that.analysisRecord);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? notes,  List<SkinSpotPhoto> photos,  DateTime createdDate,  DateTime lastModified,  BodyPart bodyPart,  BodySubPart? subPart,  SkinLesionRecord? analysisRecord)?  $default,) {final _that = this;
switch (_that) {
case _SkinSpot() when $default != null:
return $default(_that.id,_that.title,_that.notes,_that.photos,_that.createdDate,_that.lastModified,_that.bodyPart,_that.subPart,_that.analysisRecord);case _:
  return null;

}
}

}

/// @nodoc


class _SkinSpot implements SkinSpot {
  const _SkinSpot({required this.id, required this.title, this.notes, required final  List<SkinSpotPhoto> photos, required this.createdDate, required this.lastModified, required this.bodyPart, this.subPart, this.analysisRecord}): _photos = photos;
  

@override final  String id;
@override final  String title;
@override final  String? notes;
 final  List<SkinSpotPhoto> _photos;
@override List<SkinSpotPhoto> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  DateTime createdDate;
@override final  DateTime lastModified;
@override final  BodyPart bodyPart;
@override final  BodySubPart? subPart;
@override final  SkinLesionRecord? analysisRecord;

/// Create a copy of SkinSpot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkinSpotCopyWith<_SkinSpot> get copyWith => __$SkinSpotCopyWithImpl<_SkinSpot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkinSpot&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.bodyPart, bodyPart) || other.bodyPart == bodyPart)&&(identical(other.subPart, subPart) || other.subPart == subPart)&&(identical(other.analysisRecord, analysisRecord) || other.analysisRecord == analysisRecord));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,notes,const DeepCollectionEquality().hash(_photos),createdDate,lastModified,bodyPart,subPart,analysisRecord);

@override
String toString() {
  return 'SkinSpot(id: $id, title: $title, notes: $notes, photos: $photos, createdDate: $createdDate, lastModified: $lastModified, bodyPart: $bodyPart, subPart: $subPart, analysisRecord: $analysisRecord)';
}


}

/// @nodoc
abstract mixin class _$SkinSpotCopyWith<$Res> implements $SkinSpotCopyWith<$Res> {
  factory _$SkinSpotCopyWith(_SkinSpot value, $Res Function(_SkinSpot) _then) = __$SkinSpotCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? notes, List<SkinSpotPhoto> photos, DateTime createdDate, DateTime lastModified, BodyPart bodyPart, BodySubPart? subPart, SkinLesionRecord? analysisRecord
});


@override $SkinLesionRecordCopyWith<$Res>? get analysisRecord;

}
/// @nodoc
class __$SkinSpotCopyWithImpl<$Res>
    implements _$SkinSpotCopyWith<$Res> {
  __$SkinSpotCopyWithImpl(this._self, this._then);

  final _SkinSpot _self;
  final $Res Function(_SkinSpot) _then;

/// Create a copy of SkinSpot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? notes = freezed,Object? photos = null,Object? createdDate = null,Object? lastModified = null,Object? bodyPart = null,Object? subPart = freezed,Object? analysisRecord = freezed,}) {
  return _then(_SkinSpot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<SkinSpotPhoto>,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastModified: null == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as DateTime,bodyPart: null == bodyPart ? _self.bodyPart : bodyPart // ignore: cast_nullable_to_non_nullable
as BodyPart,subPart: freezed == subPart ? _self.subPart : subPart // ignore: cast_nullable_to_non_nullable
as BodySubPart?,analysisRecord: freezed == analysisRecord ? _self.analysisRecord : analysisRecord // ignore: cast_nullable_to_non_nullable
as SkinLesionRecord?,
  ));
}

/// Create a copy of SkinSpot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkinLesionRecordCopyWith<$Res>? get analysisRecord {
    if (_self.analysisRecord == null) {
    return null;
  }

  return $SkinLesionRecordCopyWith<$Res>(_self.analysisRecord!, (value) {
    return _then(_self.copyWith(analysisRecord: value));
  });
}
}

/// @nodoc
mixin _$SkinSpotPhoto {

 String get id; String? get imagePath; Uint8List? get imageData; DateTime get dateTaken; String? get notes;
/// Create a copy of SkinSpotPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkinSpotPhotoCopyWith<SkinSpotPhoto> get copyWith => _$SkinSpotPhotoCopyWithImpl<SkinSpotPhoto>(this as SkinSpotPhoto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkinSpotPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.imageData, imageData)&&(identical(other.dateTaken, dateTaken) || other.dateTaken == dateTaken)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,imagePath,const DeepCollectionEquality().hash(imageData),dateTaken,notes);

@override
String toString() {
  return 'SkinSpotPhoto(id: $id, imagePath: $imagePath, imageData: $imageData, dateTaken: $dateTaken, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $SkinSpotPhotoCopyWith<$Res>  {
  factory $SkinSpotPhotoCopyWith(SkinSpotPhoto value, $Res Function(SkinSpotPhoto) _then) = _$SkinSpotPhotoCopyWithImpl;
@useResult
$Res call({
 String id, String? imagePath, Uint8List? imageData, DateTime dateTaken, String? notes
});




}
/// @nodoc
class _$SkinSpotPhotoCopyWithImpl<$Res>
    implements $SkinSpotPhotoCopyWith<$Res> {
  _$SkinSpotPhotoCopyWithImpl(this._self, this._then);

  final SkinSpotPhoto _self;
  final $Res Function(SkinSpotPhoto) _then;

/// Create a copy of SkinSpotPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imagePath = freezed,Object? imageData = freezed,Object? dateTaken = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,imageData: freezed == imageData ? _self.imageData : imageData // ignore: cast_nullable_to_non_nullable
as Uint8List?,dateTaken: null == dateTaken ? _self.dateTaken : dateTaken // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SkinSpotPhoto].
extension SkinSpotPhotoPatterns on SkinSpotPhoto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkinSpotPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkinSpotPhoto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkinSpotPhoto value)  $default,){
final _that = this;
switch (_that) {
case _SkinSpotPhoto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkinSpotPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _SkinSpotPhoto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? imagePath,  Uint8List? imageData,  DateTime dateTaken,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkinSpotPhoto() when $default != null:
return $default(_that.id,_that.imagePath,_that.imageData,_that.dateTaken,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? imagePath,  Uint8List? imageData,  DateTime dateTaken,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _SkinSpotPhoto():
return $default(_that.id,_that.imagePath,_that.imageData,_that.dateTaken,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? imagePath,  Uint8List? imageData,  DateTime dateTaken,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _SkinSpotPhoto() when $default != null:
return $default(_that.id,_that.imagePath,_that.imageData,_that.dateTaken,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _SkinSpotPhoto implements SkinSpotPhoto {
  const _SkinSpotPhoto({required this.id, this.imagePath, this.imageData = null, required this.dateTaken, this.notes});
  

@override final  String id;
@override final  String? imagePath;
@override@JsonKey() final  Uint8List? imageData;
@override final  DateTime dateTaken;
@override final  String? notes;

/// Create a copy of SkinSpotPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkinSpotPhotoCopyWith<_SkinSpotPhoto> get copyWith => __$SkinSpotPhotoCopyWithImpl<_SkinSpotPhoto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkinSpotPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.imageData, imageData)&&(identical(other.dateTaken, dateTaken) || other.dateTaken == dateTaken)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,imagePath,const DeepCollectionEquality().hash(imageData),dateTaken,notes);

@override
String toString() {
  return 'SkinSpotPhoto(id: $id, imagePath: $imagePath, imageData: $imageData, dateTaken: $dateTaken, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$SkinSpotPhotoCopyWith<$Res> implements $SkinSpotPhotoCopyWith<$Res> {
  factory _$SkinSpotPhotoCopyWith(_SkinSpotPhoto value, $Res Function(_SkinSpotPhoto) _then) = __$SkinSpotPhotoCopyWithImpl;
@override @useResult
$Res call({
 String id, String? imagePath, Uint8List? imageData, DateTime dateTaken, String? notes
});




}
/// @nodoc
class __$SkinSpotPhotoCopyWithImpl<$Res>
    implements _$SkinSpotPhotoCopyWith<$Res> {
  __$SkinSpotPhotoCopyWithImpl(this._self, this._then);

  final _SkinSpotPhoto _self;
  final $Res Function(_SkinSpotPhoto) _then;

/// Create a copy of SkinSpotPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imagePath = freezed,Object? imageData = freezed,Object? dateTaken = null,Object? notes = freezed,}) {
  return _then(_SkinSpotPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,imageData: freezed == imageData ? _self.imageData : imageData // ignore: cast_nullable_to_non_nullable
as Uint8List?,dateTaken: null == dateTaken ? _self.dateTaken : dateTaken // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
