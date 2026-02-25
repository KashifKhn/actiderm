import 'package:flutter/material.dart';

enum BodyOrientation { front, back }

enum BodyPart {
  head,
  torso,
  leftArm,
  rightArm,
  leftLeg,
  rightLeg;

  String get displayName => switch (this) {
    head => 'Head',
    torso => 'Torso',
    leftArm => 'Left Arm',
    rightArm => 'Right Arm',
    leftLeg => 'Left Leg',
    rightLeg => 'Right Leg',
  };

  List<BodySubPart> get subParts =>
      BodySubPart.values.where((s) => s.parent == this).toList();

  List<String> get previewTags =>
      subParts.take(3).map((s) => s.displayName).toList();
}

enum BodySubPart {
  scalp(BodyPart.head),
  face(BodyPart.head),
  leftEar(BodyPart.head),
  rightEar(BodyPart.head),
  neck(BodyPart.head),

  chest(BodyPart.torso),
  abdomen(BodyPart.torso),
  upperBack(BodyPart.torso),
  lowerBack(BodyPart.torso),
  leftShoulder(BodyPart.torso),
  rightShoulder(BodyPart.torso),
  leftUnderarm(BodyPart.torso),
  rightUnderarm(BodyPart.torso),
  groin(BodyPart.torso),
  buttocks(BodyPart.torso),

  leftUpperArm(BodyPart.leftArm),
  leftElbow(BodyPart.leftArm),
  leftForearm(BodyPart.leftArm),
  leftWrist(BodyPart.leftArm),
  leftHandPalm(BodyPart.leftArm),
  leftHandBack(BodyPart.leftArm),

  rightUpperArm(BodyPart.rightArm),
  rightElbow(BodyPart.rightArm),
  rightForearm(BodyPart.rightArm),
  rightWrist(BodyPart.rightArm),
  rightHandPalm(BodyPart.rightArm),
  rightHandBack(BodyPart.rightArm),

  leftThigh(BodyPart.leftLeg),
  leftKnee(BodyPart.leftLeg),
  leftShin(BodyPart.leftLeg),
  leftCalf(BodyPart.leftLeg),
  leftAnkle(BodyPart.leftLeg),
  leftFootTop(BodyPart.leftLeg),
  leftFootSole(BodyPart.leftLeg),
  leftFootHeel(BodyPart.leftLeg),

  rightThigh(BodyPart.rightLeg),
  rightKnee(BodyPart.rightLeg),
  rightShin(BodyPart.rightLeg),
  rightCalf(BodyPart.rightLeg),
  rightAnkle(BodyPart.rightLeg),
  rightFootTop(BodyPart.rightLeg),
  rightFootSole(BodyPart.rightLeg),
  rightFootHeel(BodyPart.rightLeg);

  const BodySubPart(this.parent);
  final BodyPart parent;

  String get displayName => switch (this) {
    scalp => 'Scalp',
    face => 'Face',
    leftEar => 'Left Ear',
    rightEar => 'Right Ear',
    neck => 'Neck',
    chest => 'Chest',
    abdomen => 'Abdomen',
    upperBack => 'Upper Back',
    lowerBack => 'Lower Back',
    leftShoulder => 'Left Shoulder',
    rightShoulder => 'Right Shoulder',
    leftUnderarm => 'Left Underarm',
    rightUnderarm => 'Right Underarm',
    groin => 'Groin',
    buttocks => 'Buttocks',
    leftUpperArm => 'Upper Arm',
    leftElbow => 'Elbow',
    leftForearm => 'Forearm',
    leftWrist => 'Wrist',
    leftHandPalm => 'Palm',
    leftHandBack => 'Back of Hand',
    rightUpperArm => 'Upper Arm',
    rightElbow => 'Elbow',
    rightForearm => 'Forearm',
    rightWrist => 'Wrist',
    rightHandPalm => 'Palm',
    rightHandBack => 'Back of Hand',
    leftThigh => 'Thigh',
    leftKnee => 'Knee',
    leftShin => 'Shin',
    leftCalf => 'Calf',
    leftAnkle => 'Ankle',
    leftFootTop => 'Top of Foot',
    leftFootSole => 'Sole',
    leftFootHeel => 'Heel',
    rightThigh => 'Thigh',
    rightKnee => 'Knee',
    rightShin => 'Shin',
    rightCalf => 'Calf',
    rightAnkle => 'Ankle',
    rightFootTop => 'Top of Foot',
    rightFootSole => 'Sole',
    rightFootHeel => 'Heel',
  };

  String get storageKey => name;

  BodyOrientation? get preferredOrientation {
    final hasFront = _frontSvgId != null;
    final hasBack = _backSvgId != null;
    if (hasFront && !hasBack) return BodyOrientation.front;
    if (!hasFront && hasBack) return BodyOrientation.back;
    return null;
  }

  String? svgId(BodyOrientation orientation) => switch (orientation) {
    BodyOrientation.front => _frontSvgId,
    BodyOrientation.back => _backSvgId,
  };

  String? get _frontSvgId => switch (this) {
    face => 'face',
    neck => 'neck-front',
    leftEar => 'ear-left-front',
    rightEar => 'ear-right-front',
    chest => 'chest',
    abdomen => 'abdomen',
    groin => 'groin',
    leftShoulder => 'shoulder-left-front',
    rightShoulder => 'shoulder-right-front',
    leftUnderarm => 'underarm-left',
    rightUnderarm => 'underarm-right',
    leftUpperArm => 'arm-left-upper',
    leftForearm => 'arm-left-lower',
    leftHandBack => 'hand-left',
    rightUpperArm => 'arm-right-upper',
    rightForearm => 'arm-right-lower',
    rightHandBack => 'hand-right',
    leftThigh => 'leg-left-front-upper',
    leftShin => 'leg-left-front-lower',
    leftFootTop => 'foot-left-top',
    rightThigh => 'leg-right-front-upper',
    rightShin => 'leg-right-front-lower',
    rightFootTop => 'foot-right-top',
    _ => null,
  };

  String? get _backSvgId => switch (this) {
    scalp => 'scalp',
    neck => 'neck-back',
    leftEar => 'ear-left-back',
    rightEar => 'ear-right-back',
    upperBack => 'back-upper',
    lowerBack => 'back-lower',
    buttocks => 'buttocks',
    leftShoulder => 'shoulder-left-back',
    rightShoulder => 'shoulder-right-back',
    leftUpperArm => 'arm-left-upper',
    leftForearm => 'arm-left-lower',
    leftHandBack => 'hand-left',
    rightUpperArm => 'arm-right-upper',
    rightForearm => 'arm-right-lower',
    rightHandBack => 'hand-right',
    leftCalf => 'leg-left-back-lower',
    leftThigh => 'leg-left-back-upper',
    leftFootSole => 'foot-left-sole',
    leftFootHeel => 'foot-left-heel',
    rightCalf => 'leg-right-back-lower',
    rightThigh => 'leg-right-back-upper',
    rightFootSole => 'foot-right-sole',
    rightFootHeel => 'foot-right-heel',
    _ => null,
  };
}

enum ScanStatus {
  notScanned,
  scanned;

  String get displayName => switch (this) {
    notScanned => 'Not Scanned',
    scanned => 'Scanned',
  };

  Color get color => switch (this) {
    notScanned => const Color(0xFF9E9E9E),
    scanned => const Color(0xFF1B6B7B),
  };
}

enum ScanFilter {
  allBody,
  head,
  torso,
  arms,
  legs,
  leftArm,
  rightArm,
  leftLeg,
  rightLeg;

  String get displayName => switch (this) {
    allBody => 'All',
    head => 'Head',
    torso => 'Torso',
    arms => 'Arms',
    legs => 'Legs',
    leftArm => 'Left Arm',
    rightArm => 'Right Arm',
    leftLeg => 'Left Leg',
    rightLeg => 'Right Leg',
  };

  List<BodyPart>? get bodyParts => switch (this) {
    allBody => null,
    head => [BodyPart.head],
    torso => [BodyPart.torso],
    arms => [BodyPart.leftArm, BodyPart.rightArm],
    legs => [BodyPart.leftLeg, BodyPart.rightLeg],
    leftArm => [BodyPart.leftArm],
    rightArm => [BodyPart.rightArm],
    leftLeg => [BodyPart.leftLeg],
    rightLeg => [BodyPart.rightLeg],
  };

  static ScanFilter fromBodyPart(BodyPart? part) => switch (part) {
    BodyPart.head => head,
    BodyPart.torso => torso,
    BodyPart.leftArm => leftArm,
    BodyPart.rightArm => rightArm,
    BodyPart.leftLeg => leftLeg,
    BodyPart.rightLeg => rightLeg,
    null => allBody,
  };
}

String makeBodyKey({required BodyPart bodyPart, BodySubPart? subPart}) {
  if (subPart != null) {
    return '${bodyPart.name}-${subPart.name}';
  }
  return bodyPart.name;
}
