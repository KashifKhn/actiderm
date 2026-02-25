// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skin_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SkinReport {

 String get id; String get reportId; DateTime get createdDate; String get pdfPath; BodyPart? get filterBodyPart; DateTime? get dateRangeStart; DateTime? get dateRangeEnd; int get totalPhotos; int get totalScans;
/// Create a copy of SkinReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkinReportCopyWith<SkinReport> get copyWith => _$SkinReportCopyWithImpl<SkinReport>(this as SkinReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkinReport&&(identical(other.id, id) || other.id == id)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath)&&(identical(other.filterBodyPart, filterBodyPart) || other.filterBodyPart == filterBodyPart)&&(identical(other.dateRangeStart, dateRangeStart) || other.dateRangeStart == dateRangeStart)&&(identical(other.dateRangeEnd, dateRangeEnd) || other.dateRangeEnd == dateRangeEnd)&&(identical(other.totalPhotos, totalPhotos) || other.totalPhotos == totalPhotos)&&(identical(other.totalScans, totalScans) || other.totalScans == totalScans));
}


@override
int get hashCode => Object.hash(runtimeType,id,reportId,createdDate,pdfPath,filterBodyPart,dateRangeStart,dateRangeEnd,totalPhotos,totalScans);

@override
String toString() {
  return 'SkinReport(id: $id, reportId: $reportId, createdDate: $createdDate, pdfPath: $pdfPath, filterBodyPart: $filterBodyPart, dateRangeStart: $dateRangeStart, dateRangeEnd: $dateRangeEnd, totalPhotos: $totalPhotos, totalScans: $totalScans)';
}


}

/// @nodoc
abstract mixin class $SkinReportCopyWith<$Res>  {
  factory $SkinReportCopyWith(SkinReport value, $Res Function(SkinReport) _then) = _$SkinReportCopyWithImpl;
@useResult
$Res call({
 String id, String reportId, DateTime createdDate, String pdfPath, BodyPart? filterBodyPart, DateTime? dateRangeStart, DateTime? dateRangeEnd, int totalPhotos, int totalScans
});




}
/// @nodoc
class _$SkinReportCopyWithImpl<$Res>
    implements $SkinReportCopyWith<$Res> {
  _$SkinReportCopyWithImpl(this._self, this._then);

  final SkinReport _self;
  final $Res Function(SkinReport) _then;

/// Create a copy of SkinReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reportId = null,Object? createdDate = null,Object? pdfPath = null,Object? filterBodyPart = freezed,Object? dateRangeStart = freezed,Object? dateRangeEnd = freezed,Object? totalPhotos = null,Object? totalScans = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,pdfPath: null == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String,filterBodyPart: freezed == filterBodyPart ? _self.filterBodyPart : filterBodyPart // ignore: cast_nullable_to_non_nullable
as BodyPart?,dateRangeStart: freezed == dateRangeStart ? _self.dateRangeStart : dateRangeStart // ignore: cast_nullable_to_non_nullable
as DateTime?,dateRangeEnd: freezed == dateRangeEnd ? _self.dateRangeEnd : dateRangeEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,totalPhotos: null == totalPhotos ? _self.totalPhotos : totalPhotos // ignore: cast_nullable_to_non_nullable
as int,totalScans: null == totalScans ? _self.totalScans : totalScans // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SkinReport].
extension SkinReportPatterns on SkinReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkinReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkinReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkinReport value)  $default,){
final _that = this;
switch (_that) {
case _SkinReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkinReport value)?  $default,){
final _that = this;
switch (_that) {
case _SkinReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reportId,  DateTime createdDate,  String pdfPath,  BodyPart? filterBodyPart,  DateTime? dateRangeStart,  DateTime? dateRangeEnd,  int totalPhotos,  int totalScans)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkinReport() when $default != null:
return $default(_that.id,_that.reportId,_that.createdDate,_that.pdfPath,_that.filterBodyPart,_that.dateRangeStart,_that.dateRangeEnd,_that.totalPhotos,_that.totalScans);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reportId,  DateTime createdDate,  String pdfPath,  BodyPart? filterBodyPart,  DateTime? dateRangeStart,  DateTime? dateRangeEnd,  int totalPhotos,  int totalScans)  $default,) {final _that = this;
switch (_that) {
case _SkinReport():
return $default(_that.id,_that.reportId,_that.createdDate,_that.pdfPath,_that.filterBodyPart,_that.dateRangeStart,_that.dateRangeEnd,_that.totalPhotos,_that.totalScans);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reportId,  DateTime createdDate,  String pdfPath,  BodyPart? filterBodyPart,  DateTime? dateRangeStart,  DateTime? dateRangeEnd,  int totalPhotos,  int totalScans)?  $default,) {final _that = this;
switch (_that) {
case _SkinReport() when $default != null:
return $default(_that.id,_that.reportId,_that.createdDate,_that.pdfPath,_that.filterBodyPart,_that.dateRangeStart,_that.dateRangeEnd,_that.totalPhotos,_that.totalScans);case _:
  return null;

}
}

}

/// @nodoc


class _SkinReport implements SkinReport {
  const _SkinReport({required this.id, required this.reportId, required this.createdDate, required this.pdfPath, this.filterBodyPart, this.dateRangeStart, this.dateRangeEnd, this.totalPhotos = 0, this.totalScans = 0});
  

@override final  String id;
@override final  String reportId;
@override final  DateTime createdDate;
@override final  String pdfPath;
@override final  BodyPart? filterBodyPart;
@override final  DateTime? dateRangeStart;
@override final  DateTime? dateRangeEnd;
@override@JsonKey() final  int totalPhotos;
@override@JsonKey() final  int totalScans;

/// Create a copy of SkinReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkinReportCopyWith<_SkinReport> get copyWith => __$SkinReportCopyWithImpl<_SkinReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkinReport&&(identical(other.id, id) || other.id == id)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath)&&(identical(other.filterBodyPart, filterBodyPart) || other.filterBodyPart == filterBodyPart)&&(identical(other.dateRangeStart, dateRangeStart) || other.dateRangeStart == dateRangeStart)&&(identical(other.dateRangeEnd, dateRangeEnd) || other.dateRangeEnd == dateRangeEnd)&&(identical(other.totalPhotos, totalPhotos) || other.totalPhotos == totalPhotos)&&(identical(other.totalScans, totalScans) || other.totalScans == totalScans));
}


@override
int get hashCode => Object.hash(runtimeType,id,reportId,createdDate,pdfPath,filterBodyPart,dateRangeStart,dateRangeEnd,totalPhotos,totalScans);

@override
String toString() {
  return 'SkinReport(id: $id, reportId: $reportId, createdDate: $createdDate, pdfPath: $pdfPath, filterBodyPart: $filterBodyPart, dateRangeStart: $dateRangeStart, dateRangeEnd: $dateRangeEnd, totalPhotos: $totalPhotos, totalScans: $totalScans)';
}


}

/// @nodoc
abstract mixin class _$SkinReportCopyWith<$Res> implements $SkinReportCopyWith<$Res> {
  factory _$SkinReportCopyWith(_SkinReport value, $Res Function(_SkinReport) _then) = __$SkinReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String reportId, DateTime createdDate, String pdfPath, BodyPart? filterBodyPart, DateTime? dateRangeStart, DateTime? dateRangeEnd, int totalPhotos, int totalScans
});




}
/// @nodoc
class __$SkinReportCopyWithImpl<$Res>
    implements _$SkinReportCopyWith<$Res> {
  __$SkinReportCopyWithImpl(this._self, this._then);

  final _SkinReport _self;
  final $Res Function(_SkinReport) _then;

/// Create a copy of SkinReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reportId = null,Object? createdDate = null,Object? pdfPath = null,Object? filterBodyPart = freezed,Object? dateRangeStart = freezed,Object? dateRangeEnd = freezed,Object? totalPhotos = null,Object? totalScans = null,}) {
  return _then(_SkinReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,pdfPath: null == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String,filterBodyPart: freezed == filterBodyPart ? _self.filterBodyPart : filterBodyPart // ignore: cast_nullable_to_non_nullable
as BodyPart?,dateRangeStart: freezed == dateRangeStart ? _self.dateRangeStart : dateRangeStart // ignore: cast_nullable_to_non_nullable
as DateTime?,dateRangeEnd: freezed == dateRangeEnd ? _self.dateRangeEnd : dateRangeEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,totalPhotos: null == totalPhotos ? _self.totalPhotos : totalPhotos // ignore: cast_nullable_to_non_nullable
as int,totalScans: null == totalScans ? _self.totalScans : totalScans // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
