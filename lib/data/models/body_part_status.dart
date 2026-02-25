import 'package:freezed_annotation/freezed_annotation.dart';

import 'body_part.dart';

part 'body_part_status.freezed.dart';

@freezed
abstract class BodyPartStatus with _$BodyPartStatus {
  const factory BodyPartStatus({
    required BodyPart bodyPart,
    BodySubPart? subPart,
    @Default(ScanStatus.notScanned) ScanStatus scanStatus,
    @Default(0) int photoCount,
    DateTime? lastScanned,
  }) = _BodyPartStatus;
}
