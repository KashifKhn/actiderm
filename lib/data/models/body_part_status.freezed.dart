// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_part_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BodyPartStatus {

 BodyPart get bodyPart; BodySubPart? get subPart; ScanStatus get scanStatus; int get photoCount; DateTime? get lastScanned;
/// Create a copy of BodyPartStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyPartStatusCopyWith<BodyPartStatus> get copyWith => _$BodyPartStatusCopyWithImpl<BodyPartStatus>(this as BodyPartStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyPartStatus&&(identical(other.bodyPart, bodyPart) || other.bodyPart == bodyPart)&&(identical(other.subPart, subPart) || other.subPart == subPart)&&(identical(other.scanStatus, scanStatus) || other.scanStatus == scanStatus)&&(identical(other.photoCount, photoCount) || other.photoCount == photoCount)&&(identical(other.lastScanned, lastScanned) || other.lastScanned == lastScanned));
}


@override
int get hashCode => Object.hash(runtimeType,bodyPart,subPart,scanStatus,photoCount,lastScanned);

@override
String toString() {
  return 'BodyPartStatus(bodyPart: $bodyPart, subPart: $subPart, scanStatus: $scanStatus, photoCount: $photoCount, lastScanned: $lastScanned)';
}


}

/// @nodoc
abstract mixin class $BodyPartStatusCopyWith<$Res>  {
  factory $BodyPartStatusCopyWith(BodyPartStatus value, $Res Function(BodyPartStatus) _then) = _$BodyPartStatusCopyWithImpl;
@useResult
$Res call({
 BodyPart bodyPart, BodySubPart? subPart, ScanStatus scanStatus, int photoCount, DateTime? lastScanned
});




}
/// @nodoc
class _$BodyPartStatusCopyWithImpl<$Res>
    implements $BodyPartStatusCopyWith<$Res> {
  _$BodyPartStatusCopyWithImpl(this._self, this._then);

  final BodyPartStatus _self;
  final $Res Function(BodyPartStatus) _then;

/// Create a copy of BodyPartStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bodyPart = null,Object? subPart = freezed,Object? scanStatus = null,Object? photoCount = null,Object? lastScanned = freezed,}) {
  return _then(_self.copyWith(
bodyPart: null == bodyPart ? _self.bodyPart : bodyPart // ignore: cast_nullable_to_non_nullable
as BodyPart,subPart: freezed == subPart ? _self.subPart : subPart // ignore: cast_nullable_to_non_nullable
as BodySubPart?,scanStatus: null == scanStatus ? _self.scanStatus : scanStatus // ignore: cast_nullable_to_non_nullable
as ScanStatus,photoCount: null == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int,lastScanned: freezed == lastScanned ? _self.lastScanned : lastScanned // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyPartStatus].
extension BodyPartStatusPatterns on BodyPartStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyPartStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyPartStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyPartStatus value)  $default,){
final _that = this;
switch (_that) {
case _BodyPartStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyPartStatus value)?  $default,){
final _that = this;
switch (_that) {
case _BodyPartStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BodyPart bodyPart,  BodySubPart? subPart,  ScanStatus scanStatus,  int photoCount,  DateTime? lastScanned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyPartStatus() when $default != null:
return $default(_that.bodyPart,_that.subPart,_that.scanStatus,_that.photoCount,_that.lastScanned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BodyPart bodyPart,  BodySubPart? subPart,  ScanStatus scanStatus,  int photoCount,  DateTime? lastScanned)  $default,) {final _that = this;
switch (_that) {
case _BodyPartStatus():
return $default(_that.bodyPart,_that.subPart,_that.scanStatus,_that.photoCount,_that.lastScanned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BodyPart bodyPart,  BodySubPart? subPart,  ScanStatus scanStatus,  int photoCount,  DateTime? lastScanned)?  $default,) {final _that = this;
switch (_that) {
case _BodyPartStatus() when $default != null:
return $default(_that.bodyPart,_that.subPart,_that.scanStatus,_that.photoCount,_that.lastScanned);case _:
  return null;

}
}

}

/// @nodoc


class _BodyPartStatus implements BodyPartStatus {
  const _BodyPartStatus({required this.bodyPart, this.subPart, this.scanStatus = ScanStatus.notScanned, this.photoCount = 0, this.lastScanned});
  

@override final  BodyPart bodyPart;
@override final  BodySubPart? subPart;
@override@JsonKey() final  ScanStatus scanStatus;
@override@JsonKey() final  int photoCount;
@override final  DateTime? lastScanned;

/// Create a copy of BodyPartStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyPartStatusCopyWith<_BodyPartStatus> get copyWith => __$BodyPartStatusCopyWithImpl<_BodyPartStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyPartStatus&&(identical(other.bodyPart, bodyPart) || other.bodyPart == bodyPart)&&(identical(other.subPart, subPart) || other.subPart == subPart)&&(identical(other.scanStatus, scanStatus) || other.scanStatus == scanStatus)&&(identical(other.photoCount, photoCount) || other.photoCount == photoCount)&&(identical(other.lastScanned, lastScanned) || other.lastScanned == lastScanned));
}


@override
int get hashCode => Object.hash(runtimeType,bodyPart,subPart,scanStatus,photoCount,lastScanned);

@override
String toString() {
  return 'BodyPartStatus(bodyPart: $bodyPart, subPart: $subPart, scanStatus: $scanStatus, photoCount: $photoCount, lastScanned: $lastScanned)';
}


}

/// @nodoc
abstract mixin class _$BodyPartStatusCopyWith<$Res> implements $BodyPartStatusCopyWith<$Res> {
  factory _$BodyPartStatusCopyWith(_BodyPartStatus value, $Res Function(_BodyPartStatus) _then) = __$BodyPartStatusCopyWithImpl;
@override @useResult
$Res call({
 BodyPart bodyPart, BodySubPart? subPart, ScanStatus scanStatus, int photoCount, DateTime? lastScanned
});




}
/// @nodoc
class __$BodyPartStatusCopyWithImpl<$Res>
    implements _$BodyPartStatusCopyWith<$Res> {
  __$BodyPartStatusCopyWithImpl(this._self, this._then);

  final _BodyPartStatus _self;
  final $Res Function(_BodyPartStatus) _then;

/// Create a copy of BodyPartStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bodyPart = null,Object? subPart = freezed,Object? scanStatus = null,Object? photoCount = null,Object? lastScanned = freezed,}) {
  return _then(_BodyPartStatus(
bodyPart: null == bodyPart ? _self.bodyPart : bodyPart // ignore: cast_nullable_to_non_nullable
as BodyPart,subPart: freezed == subPart ? _self.subPart : subPart // ignore: cast_nullable_to_non_nullable
as BodySubPart?,scanStatus: null == scanStatus ? _self.scanStatus : scanStatus // ignore: cast_nullable_to_non_nullable
as ScanStatus,photoCount: null == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int,lastScanned: freezed == lastScanned ? _self.lastScanned : lastScanned // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
