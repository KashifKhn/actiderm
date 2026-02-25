import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'body_part.dart';
import 'skin_lesion_record.dart';

part 'skin_spot.freezed.dart';

@freezed
abstract class SkinSpot with _$SkinSpot {
  const factory SkinSpot({
    required String id,
    required String title,
    String? notes,
    required List<SkinSpotPhoto> photos,
    required DateTime createdDate,
    required DateTime lastModified,
    required BodyPart bodyPart,
    BodySubPart? subPart,
    SkinLesionRecord? analysisRecord,
  }) = _SkinSpot;
}

@freezed
abstract class SkinSpotPhoto with _$SkinSpotPhoto {
  const factory SkinSpotPhoto({
    required String id,
    String? imagePath,
    @Default(null) Uint8List? imageData,
    required DateTime dateTaken,
    String? notes,
  }) = _SkinSpotPhoto;
}
