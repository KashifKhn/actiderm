// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skin_analysis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SkinAnalysis {

@JsonKey(name: 'lesion_type') String get lesionType; String get color; String get symmetry; String get borders; String get texture; String get summary;
/// Create a copy of SkinAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkinAnalysisCopyWith<SkinAnalysis> get copyWith => _$SkinAnalysisCopyWithImpl<SkinAnalysis>(this as SkinAnalysis, _$identity);

  /// Serializes this SkinAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkinAnalysis&&(identical(other.lesionType, lesionType) || other.lesionType == lesionType)&&(identical(other.color, color) || other.color == color)&&(identical(other.symmetry, symmetry) || other.symmetry == symmetry)&&(identical(other.borders, borders) || other.borders == borders)&&(identical(other.texture, texture) || other.texture == texture)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lesionType,color,symmetry,borders,texture,summary);

@override
String toString() {
  return 'SkinAnalysis(lesionType: $lesionType, color: $color, symmetry: $symmetry, borders: $borders, texture: $texture, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $SkinAnalysisCopyWith<$Res>  {
  factory $SkinAnalysisCopyWith(SkinAnalysis value, $Res Function(SkinAnalysis) _then) = _$SkinAnalysisCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'lesion_type') String lesionType, String color, String symmetry, String borders, String texture, String summary
});




}
/// @nodoc
class _$SkinAnalysisCopyWithImpl<$Res>
    implements $SkinAnalysisCopyWith<$Res> {
  _$SkinAnalysisCopyWithImpl(this._self, this._then);

  final SkinAnalysis _self;
  final $Res Function(SkinAnalysis) _then;

/// Create a copy of SkinAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lesionType = null,Object? color = null,Object? symmetry = null,Object? borders = null,Object? texture = null,Object? summary = null,}) {
  return _then(_self.copyWith(
lesionType: null == lesionType ? _self.lesionType : lesionType // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,symmetry: null == symmetry ? _self.symmetry : symmetry // ignore: cast_nullable_to_non_nullable
as String,borders: null == borders ? _self.borders : borders // ignore: cast_nullable_to_non_nullable
as String,texture: null == texture ? _self.texture : texture // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SkinAnalysis].
extension SkinAnalysisPatterns on SkinAnalysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkinAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkinAnalysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkinAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _SkinAnalysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkinAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _SkinAnalysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'lesion_type')  String lesionType,  String color,  String symmetry,  String borders,  String texture,  String summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkinAnalysis() when $default != null:
return $default(_that.lesionType,_that.color,_that.symmetry,_that.borders,_that.texture,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'lesion_type')  String lesionType,  String color,  String symmetry,  String borders,  String texture,  String summary)  $default,) {final _that = this;
switch (_that) {
case _SkinAnalysis():
return $default(_that.lesionType,_that.color,_that.symmetry,_that.borders,_that.texture,_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'lesion_type')  String lesionType,  String color,  String symmetry,  String borders,  String texture,  String summary)?  $default,) {final _that = this;
switch (_that) {
case _SkinAnalysis() when $default != null:
return $default(_that.lesionType,_that.color,_that.symmetry,_that.borders,_that.texture,_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkinAnalysis implements SkinAnalysis {
  const _SkinAnalysis({@JsonKey(name: 'lesion_type') required this.lesionType, required this.color, required this.symmetry, required this.borders, required this.texture, required this.summary});
  factory _SkinAnalysis.fromJson(Map<String, dynamic> json) => _$SkinAnalysisFromJson(json);

@override@JsonKey(name: 'lesion_type') final  String lesionType;
@override final  String color;
@override final  String symmetry;
@override final  String borders;
@override final  String texture;
@override final  String summary;

/// Create a copy of SkinAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkinAnalysisCopyWith<_SkinAnalysis> get copyWith => __$SkinAnalysisCopyWithImpl<_SkinAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkinAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkinAnalysis&&(identical(other.lesionType, lesionType) || other.lesionType == lesionType)&&(identical(other.color, color) || other.color == color)&&(identical(other.symmetry, symmetry) || other.symmetry == symmetry)&&(identical(other.borders, borders) || other.borders == borders)&&(identical(other.texture, texture) || other.texture == texture)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lesionType,color,symmetry,borders,texture,summary);

@override
String toString() {
  return 'SkinAnalysis(lesionType: $lesionType, color: $color, symmetry: $symmetry, borders: $borders, texture: $texture, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$SkinAnalysisCopyWith<$Res> implements $SkinAnalysisCopyWith<$Res> {
  factory _$SkinAnalysisCopyWith(_SkinAnalysis value, $Res Function(_SkinAnalysis) _then) = __$SkinAnalysisCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'lesion_type') String lesionType, String color, String symmetry, String borders, String texture, String summary
});




}
/// @nodoc
class __$SkinAnalysisCopyWithImpl<$Res>
    implements _$SkinAnalysisCopyWith<$Res> {
  __$SkinAnalysisCopyWithImpl(this._self, this._then);

  final _SkinAnalysis _self;
  final $Res Function(_SkinAnalysis) _then;

/// Create a copy of SkinAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lesionType = null,Object? color = null,Object? symmetry = null,Object? borders = null,Object? texture = null,Object? summary = null,}) {
  return _then(_SkinAnalysis(
lesionType: null == lesionType ? _self.lesionType : lesionType // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,symmetry: null == symmetry ? _self.symmetry : symmetry // ignore: cast_nullable_to_non_nullable
as String,borders: null == borders ? _self.borders : borders // ignore: cast_nullable_to_non_nullable
as String,texture: null == texture ? _self.texture : texture // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
