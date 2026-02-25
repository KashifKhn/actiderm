import 'package:freezed_annotation/freezed_annotation.dart';

import 'body_part.dart';

part 'skin_report.freezed.dart';

@freezed
abstract class SkinReport with _$SkinReport {
  const factory SkinReport({
    required String id,
    required String reportId,
    required DateTime createdDate,
    required String pdfPath,
    BodyPart? filterBodyPart,
    DateTime? dateRangeStart,
    DateTime? dateRangeEnd,
    @Default(0) int totalPhotos,
    @Default(0) int totalScans,
  }) = _SkinReport;
}
