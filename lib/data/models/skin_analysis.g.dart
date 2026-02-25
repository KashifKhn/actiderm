// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skin_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SkinAnalysis _$SkinAnalysisFromJson(Map<String, dynamic> json) =>
    _SkinAnalysis(
      lesionType: json['lesion_type'] as String,
      color: json['color'] as String,
      symmetry: json['symmetry'] as String,
      borders: json['borders'] as String,
      texture: json['texture'] as String,
      summary: json['summary'] as String,
    );

Map<String, dynamic> _$SkinAnalysisToJson(_SkinAnalysis instance) =>
    <String, dynamic>{
      'lesion_type': instance.lesionType,
      'color': instance.color,
      'symmetry': instance.symmetry,
      'borders': instance.borders,
      'texture': instance.texture,
      'summary': instance.summary,
    };
