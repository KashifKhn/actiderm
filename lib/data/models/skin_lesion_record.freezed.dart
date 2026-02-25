// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skin_lesion_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SkinLesionRecord {

 String get id;@JsonKey(name: 'image_path') String get imagePath; String get timestamp; SkinAnalysis get analysis; String? get latency;
/// Create a copy of SkinLesionRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkinLesionRecordCopyWith<SkinLesionRecord> get copyWith => _$SkinLesionRecordCopyWithImpl<SkinLesionRecord>(this as SkinLesionRecord, _$identity);

  /// Serializes this SkinLesionRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkinLesionRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.analysis, analysis) || other.analysis == analysis)&&(identical(other.latency, latency) || other.latency == latency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imagePath,timestamp,analysis,latency);

@override
String toString() {
  return 'SkinLesionRecord(id: $id, imagePath: $imagePath, timestamp: $timestamp, analysis: $analysis, latency: $latency)';
}


}

/// @nodoc
abstract mixin class $SkinLesionRecordCopyWith<$Res>  {
  factory $SkinLesionRecordCopyWith(SkinLesionRecord value, $Res Function(SkinLesionRecord) _then) = _$SkinLesionRecordCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'image_path') String imagePath, String timestamp, SkinAnalysis analysis, String? latency
});


$SkinAnalysisCopyWith<$Res> get analysis;

}
/// @nodoc
class _$SkinLesionRecordCopyWithImpl<$Res>
    implements $SkinLesionRecordCopyWith<$Res> {
  _$SkinLesionRecordCopyWithImpl(this._self, this._then);

  final SkinLesionRecord _self;
  final $Res Function(SkinLesionRecord) _then;

/// Create a copy of SkinLesionRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imagePath = null,Object? timestamp = null,Object? analysis = null,Object? latency = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,analysis: null == analysis ? _self.analysis : analysis // ignore: cast_nullable_to_non_nullable
as SkinAnalysis,latency: freezed == latency ? _self.latency : latency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SkinLesionRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkinAnalysisCopyWith<$Res> get analysis {
  
  return $SkinAnalysisCopyWith<$Res>(_self.analysis, (value) {
    return _then(_self.copyWith(analysis: value));
  });
}
}


/// Adds pattern-matching-related methods to [SkinLesionRecord].
extension SkinLesionRecordPatterns on SkinLesionRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkinLesionRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkinLesionRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkinLesionRecord value)  $default,){
final _that = this;
switch (_that) {
case _SkinLesionRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkinLesionRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SkinLesionRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'image_path')  String imagePath,  String timestamp,  SkinAnalysis analysis,  String? latency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkinLesionRecord() when $default != null:
return $default(_that.id,_that.imagePath,_that.timestamp,_that.analysis,_that.latency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'image_path')  String imagePath,  String timestamp,  SkinAnalysis analysis,  String? latency)  $default,) {final _that = this;
switch (_that) {
case _SkinLesionRecord():
return $default(_that.id,_that.imagePath,_that.timestamp,_that.analysis,_that.latency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'image_path')  String imagePath,  String timestamp,  SkinAnalysis analysis,  String? latency)?  $default,) {final _that = this;
switch (_that) {
case _SkinLesionRecord() when $default != null:
return $default(_that.id,_that.imagePath,_that.timestamp,_that.analysis,_that.latency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkinLesionRecord implements SkinLesionRecord {
  const _SkinLesionRecord({required this.id, @JsonKey(name: 'image_path') required this.imagePath, required this.timestamp, required this.analysis, this.latency});
  factory _SkinLesionRecord.fromJson(Map<String, dynamic> json) => _$SkinLesionRecordFromJson(json);

@override final  String id;
@override@JsonKey(name: 'image_path') final  String imagePath;
@override final  String timestamp;
@override final  SkinAnalysis analysis;
@override final  String? latency;

/// Create a copy of SkinLesionRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkinLesionRecordCopyWith<_SkinLesionRecord> get copyWith => __$SkinLesionRecordCopyWithImpl<_SkinLesionRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkinLesionRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkinLesionRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.analysis, analysis) || other.analysis == analysis)&&(identical(other.latency, latency) || other.latency == latency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imagePath,timestamp,analysis,latency);

@override
String toString() {
  return 'SkinLesionRecord(id: $id, imagePath: $imagePath, timestamp: $timestamp, analysis: $analysis, latency: $latency)';
}


}

/// @nodoc
abstract mixin class _$SkinLesionRecordCopyWith<$Res> implements $SkinLesionRecordCopyWith<$Res> {
  factory _$SkinLesionRecordCopyWith(_SkinLesionRecord value, $Res Function(_SkinLesionRecord) _then) = __$SkinLesionRecordCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'image_path') String imagePath, String timestamp, SkinAnalysis analysis, String? latency
});


@override $SkinAnalysisCopyWith<$Res> get analysis;

}
/// @nodoc
class __$SkinLesionRecordCopyWithImpl<$Res>
    implements _$SkinLesionRecordCopyWith<$Res> {
  __$SkinLesionRecordCopyWithImpl(this._self, this._then);

  final _SkinLesionRecord _self;
  final $Res Function(_SkinLesionRecord) _then;

/// Create a copy of SkinLesionRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imagePath = null,Object? timestamp = null,Object? analysis = null,Object? latency = freezed,}) {
  return _then(_SkinLesionRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,analysis: null == analysis ? _self.analysis : analysis // ignore: cast_nullable_to_non_nullable
as SkinAnalysis,latency: freezed == latency ? _self.latency : latency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SkinLesionRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkinAnalysisCopyWith<$Res> get analysis {
  
  return $SkinAnalysisCopyWith<$Res>(_self.analysis, (value) {
    return _then(_self.copyWith(analysis: value));
  });
}
}

// dart format on
