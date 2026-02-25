import '../../../data/models/body_part.dart';

class WalkthroughStep {
  const WalkthroughStep({
    required this.id,
    required this.bodyPart,
    required this.subPart,
    this.orientation,
    required this.instruction,
    this.tips,
    required this.isRequired,
  });

  final String id;
  final BodyPart bodyPart;
  final BodySubPart subPart;
  final BodyOrientation? orientation;
  final String instruction;
  final String? tips;
  final bool isRequired;

  String get fullName {
    final orientationLabel = switch (orientation) {
      BodyOrientation.front => ' (Front)',
      BodyOrientation.back => ' (Back)',
      null => '',
    };
    return '${bodyPart.displayName} - ${subPart.displayName}$orientationLabel';
  }
}

List<WalkthroughStep> generateFullBodyWalkthrough() {
  var id = 0;
  String nextId() => '${id++}';

  return [
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.head,
      subPart: BodySubPart.face,
      orientation: BodyOrientation.front,
      instruction: 'Capture your face',
      tips: 'Look straight ahead with good lighting',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.head,
      subPart: BodySubPart.neck,
      orientation: BodyOrientation.front,
      instruction: 'Capture front of your neck',
      tips: 'Tilt your head back slightly',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.head,
      subPart: BodySubPart.scalp,
      orientation: BodyOrientation.back,
      instruction: 'Capture your scalp',
      tips: 'Part your hair to get a clear view, use a mirror or ask for help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.head,
      subPart: BodySubPart.neck,
      orientation: BodyOrientation.back,
      instruction: 'Capture back of your neck',
      tips: 'Use a mirror or ask someone to help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.head,
      subPart: BodySubPart.leftEar,
      orientation: null,
      instruction: 'Capture your left ear',
      tips: 'Turn your head to show your left ear clearly',
      isRequired: false,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.head,
      subPart: BodySubPart.rightEar,
      orientation: null,
      instruction: 'Capture your right ear',
      tips: 'Turn your head to show your right ear clearly',
      isRequired: false,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftArm,
      subPart: BodySubPart.leftShoulder,
      orientation: BodyOrientation.front,
      instruction: 'Capture front of your left shoulder',
      tips: null,
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftArm,
      subPart: BodySubPart.leftShoulder,
      orientation: BodyOrientation.back,
      instruction: 'Capture back of your left shoulder',
      tips: 'Use a mirror or ask someone to help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftArm,
      subPart: BodySubPart.leftUpperArm,
      orientation: null,
      instruction: 'Capture your left upper arm',
      tips: 'Rotate to capture all sides',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftArm,
      subPart: BodySubPart.leftForearm,
      orientation: null,
      instruction: 'Capture your left forearm',
      tips: 'Rotate to capture all sides',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftArm,
      subPart: BodySubPart.leftHandBack,
      orientation: null,
      instruction: 'Capture your left hand',
      tips: 'Capture both palm and back',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightArm,
      subPart: BodySubPart.rightShoulder,
      orientation: BodyOrientation.front,
      instruction: 'Capture front of your right shoulder',
      tips: null,
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightArm,
      subPart: BodySubPart.rightShoulder,
      orientation: BodyOrientation.back,
      instruction: 'Capture back of your right shoulder',
      tips: 'Use a mirror or ask someone to help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightArm,
      subPart: BodySubPart.rightUpperArm,
      orientation: null,
      instruction: 'Capture your right upper arm',
      tips: 'Rotate to capture all sides',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightArm,
      subPart: BodySubPart.rightForearm,
      orientation: null,
      instruction: 'Capture your right forearm',
      tips: 'Rotate to capture all sides',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightArm,
      subPart: BodySubPart.rightHandBack,
      orientation: null,
      instruction: 'Capture your right hand',
      tips: 'Capture both palm and back',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.torso,
      subPart: BodySubPart.chest,
      orientation: BodyOrientation.front,
      instruction: 'Capture your chest',
      tips: 'Stand straight with arms at sides',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.torso,
      subPart: BodySubPart.abdomen,
      orientation: BodyOrientation.front,
      instruction: 'Capture your abdomen',
      tips: 'Stand straight with good lighting',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.torso,
      subPart: BodySubPart.groin,
      orientation: BodyOrientation.front,
      instruction: 'Capture your groin area',
      tips: 'Ensure privacy and good lighting',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.torso,
      subPart: BodySubPart.upperBack,
      orientation: BodyOrientation.back,
      instruction: 'Capture your upper back',
      tips: 'Use a mirror or ask someone to help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.torso,
      subPart: BodySubPart.lowerBack,
      orientation: BodyOrientation.back,
      instruction: 'Capture your lower back',
      tips: 'Use a mirror or ask someone to help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.torso,
      subPart: BodySubPart.buttocks,
      orientation: BodyOrientation.back,
      instruction: 'Capture your buttocks',
      tips: 'Use a mirror for privacy and accuracy',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftLeg,
      subPart: BodySubPart.leftThigh,
      orientation: BodyOrientation.front,
      instruction: 'Capture front of your left thigh',
      tips: 'Stand straight for clear view',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftLeg,
      subPart: BodySubPart.leftShin,
      orientation: BodyOrientation.front,
      instruction: 'Capture front of your left shin',
      tips: null,
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftLeg,
      subPart: BodySubPart.leftFootTop,
      orientation: BodyOrientation.front,
      instruction: 'Capture top of your left foot',
      tips: 'Ensure toes are visible',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftLeg,
      subPart: BodySubPart.leftThigh,
      orientation: BodyOrientation.back,
      instruction: 'Capture back of your left thigh',
      tips: 'Use a mirror or ask someone to help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftLeg,
      subPart: BodySubPart.leftCalf,
      orientation: BodyOrientation.back,
      instruction: 'Capture back of your left calf',
      tips: 'Use a mirror or ask someone to help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftLeg,
      subPart: BodySubPart.leftFootHeel,
      orientation: BodyOrientation.back,
      instruction: 'Capture your left heel',
      tips: 'Stand on tiptoes or elevate foot',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.leftLeg,
      subPart: BodySubPart.leftFootSole,
      orientation: BodyOrientation.back,
      instruction: 'Capture sole of your left foot',
      tips: 'Sit and lift foot for clear view',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightLeg,
      subPart: BodySubPart.rightThigh,
      orientation: BodyOrientation.front,
      instruction: 'Capture front of your right thigh',
      tips: 'Stand straight for clear view',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightLeg,
      subPart: BodySubPart.rightShin,
      orientation: BodyOrientation.front,
      instruction: 'Capture front of your right shin',
      tips: null,
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightLeg,
      subPart: BodySubPart.rightFootTop,
      orientation: BodyOrientation.front,
      instruction: 'Capture top of your right foot',
      tips: 'Ensure toes are visible',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightLeg,
      subPart: BodySubPart.rightThigh,
      orientation: BodyOrientation.back,
      instruction: 'Capture back of your right thigh',
      tips: 'Use a mirror or ask someone to help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightLeg,
      subPart: BodySubPart.rightCalf,
      orientation: BodyOrientation.back,
      instruction: 'Capture back of your right calf',
      tips: 'Use a mirror or ask someone to help',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightLeg,
      subPart: BodySubPart.rightFootHeel,
      orientation: BodyOrientation.back,
      instruction: 'Capture your right heel',
      tips: 'Stand on tiptoes or elevate foot',
      isRequired: true,
    ),
    WalkthroughStep(
      id: nextId(),
      bodyPart: BodyPart.rightLeg,
      subPart: BodySubPart.rightFootSole,
      orientation: BodyOrientation.back,
      instruction: 'Capture sole of your right foot',
      tips: 'Sit and lift foot for clear view',
      isRequired: true,
    ),
  ];
}

extension WalkthroughStepListX on List<WalkthroughStep> {
  List<WalkthroughStep> get requiredSteps =>
      where((s) => s.isRequired).toList();

  List<WalkthroughStep> get optionalSteps =>
      where((s) => !s.isRequired).toList();

  int get requiredCount => requiredSteps.length;
  int get totalCount => length;
}
