import 'package:freezed_annotation/freezed_annotation.dart';

part 'skin_analysis.freezed.dart';
part 'skin_analysis.g.dart';

@freezed
abstract class SkinAnalysis with _$SkinAnalysis {
  const factory SkinAnalysis({
    @JsonKey(name: 'lesion_type') required String lesionType,
    required String color,
    required String symmetry,
    required String borders,
    required String texture,
    required String summary,
  }) = _SkinAnalysis;

  factory SkinAnalysis.fromJson(Map<String, dynamic> json) =>
      _$SkinAnalysisFromJson(json);
}
