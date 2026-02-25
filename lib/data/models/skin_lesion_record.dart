import 'package:freezed_annotation/freezed_annotation.dart';

import 'skin_analysis.dart';

part 'skin_lesion_record.freezed.dart';
part 'skin_lesion_record.g.dart';

@freezed
abstract class SkinLesionRecord with _$SkinLesionRecord {
  const factory SkinLesionRecord({
    required String id,
    @JsonKey(name: 'image_path') required String imagePath,
    required String timestamp,
    required SkinAnalysis analysis,
    String? latency,
  }) = _SkinLesionRecord;

  factory SkinLesionRecord.fromJson(Map<String, dynamic> json) =>
      _$SkinLesionRecordFromJson(json);
}

extension SkinLesionRecordX on SkinLesionRecord {
  DateTime? get date {
    final formatter = RegExp(
      r'^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$',
    );
    final match = formatter.firstMatch(timestamp);
    if (match == null) return null;
    return DateTime(
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
      int.parse(match.group(4)!),
      int.parse(match.group(5)!),
      int.parse(match.group(6)!),
    );
  }
}
