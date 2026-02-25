// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skin_lesion_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SkinLesionRecord _$SkinLesionRecordFromJson(Map<String, dynamic> json) =>
    _SkinLesionRecord(
      id: json['id'] as String,
      imagePath: json['image_path'] as String,
      timestamp: json['timestamp'] as String,
      analysis: SkinAnalysis.fromJson(json['analysis'] as Map<String, dynamic>),
      latency: json['latency'] as String?,
    );

Map<String, dynamic> _$SkinLesionRecordToJson(_SkinLesionRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_path': instance.imagePath,
      'timestamp': instance.timestamp,
      'analysis': instance.analysis,
      'latency': instance.latency,
    };
