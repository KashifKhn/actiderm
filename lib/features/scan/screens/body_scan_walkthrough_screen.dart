import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/skin_spot.dart';
import '../../../services/skin_spot_service.dart';
import '../../../shared/utils/haptic_manager.dart';
import '../models/walkthrough_step.dart';

class BodyScanWalkthroughScreen extends ConsumerStatefulWidget {
  const BodyScanWalkthroughScreen({super.key});

  @override
  ConsumerState<BodyScanWalkthroughScreen> createState() =>
      _BodyScanWalkthroughScreenState();
}

class _BodyScanWalkthroughScreenState
    extends ConsumerState<BodyScanWalkthroughScreen> {
  final List<WalkthroughStep> _steps = generateFullBodyWalkthrough();
  final Map<String, Uint8List> _capturedImages = {};
  int _currentIndex = 0;
  bool _picking = false;

  WalkthroughStep get _currentStep => _steps[_currentIndex];

  double get _progress => (_currentIndex + 1) / _steps.length;

  bool get _currentCaptured => _capturedImages.containsKey(_currentStep.id);

  bool get _isLastStep => _currentIndex == _steps.length - 1;

  Future<void> _pickImage() async {
    if (_picking) return;
    setState(() => _picking = true);
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        maxWidth: 2048,
        maxHeight: 2048,
      );
      if (file == null || !mounted) return;
      final bytes = await file.readAsBytes();
      await HapticManager.lightImpact();
      setState(() => _capturedImages[_currentStep.id] = bytes);
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  void _goBack() {
    if (_currentIndex > 0) {
      HapticManager.selectionClick();
      setState(() => _currentIndex--);
    }
  }

  void _goNext() {
    if (_isLastStep) {
      _finishWalkthrough();
    } else {
      HapticManager.selectionClick();
      setState(() => _currentIndex++);
    }
  }

  void _skip() {
    if (!_isLastStep) {
      HapticManager.selectionClick();
      setState(() => _currentIndex++);
    }
  }

  Future<void> _finishWalkthrough() async {
    await HapticManager.mediumImpact();
    final service = ref.read(skinSpotServiceProvider.notifier);
    const uuid = Uuid();

    for (final entry in _capturedImages.entries) {
      final step = _steps.firstWhere((s) => s.id == entry.key);
      final spotId = uuid.v4();
      final photoId = uuid.v4();
      final now = DateTime.now();

      final spot = SkinSpot(
        id: spotId,
        title: 'Walkthrough - ${step.fullName}',
        photos: [SkinSpotPhoto(id: photoId, dateTaken: now)],
        createdDate: now,
        lastModified: now,
        bodyPart: step.bodyPart,
        subPart: step.subPart,
      );

      await service.addSkinSpot(
        spot: spot,
        bodyPart: step.bodyPart,
        subPart: step.subPart,
        imageBytes: entry.value,
      );
    }

    if (mounted) context.go('/overview');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => context.go('/add-scan'),
          child: Text(
            'Cancel',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ),
        leadingWidth: 80,
        title: Text(
          'Step ${_currentIndex + 1} of ${_steps.length}',
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        centerTitle: true,
        actions: [
          if (!_isLastStep)
            TextButton(
              onPressed: _skip,
              child: Text(
                'Skip',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          _ProgressBar(progress: _progress),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    _currentStep.fullName,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _CaptureArea(
                    capturedBytes: _capturedImages[_currentStep.id],
                    picking: _picking,
                    onTap: _pickImage,
                  ),
                  const SizedBox(height: 20),
                  _InstructionCard(
                    instruction: _currentStep.instruction,
                    tips: _currentStep.tips,
                    isRequired: _currentStep.isRequired,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          _NavigationBar(
            showBack: _currentIndex > 0,
            isLastStep: _isLastStep,
            canProceed: _currentCaptured,
            onBack: _goBack,
            onNext: _goNext,
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 6,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest,
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1B6B7B)),
        ),
      ),
    );
  }
}

class _CaptureArea extends StatelessWidget {
  const _CaptureArea({
    required this.capturedBytes,
    required this.picking,
    required this.onTap,
  });

  final Uint8List? capturedBytes;
  final bool picking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: picking ? null : onTap,
      child: Container(
        height: 340,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: capturedBytes != null
              ? Border.all(color: const Color(0xFF1B6B7B), width: 3)
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: capturedBytes != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(capturedBytes!, fit: BoxFit.cover),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B6B7B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Retake',
                              style: textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : picking
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 64,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tap to capture',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({
    required this.instruction,
    required this.tips,
    required this.isRequired,
  });

  final String instruction;
  final String? tips;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                instruction,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (!isRequired)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Optional',
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
        if (tips != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1B6B7B).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  size: 18,
                  color: Color(0xFF1B6B7B),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    tips!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({
    required this.showBack,
    required this.isLastStep,
    required this.canProceed,
    required this.onBack,
    required this.onNext,
  });

  final bool showBack;
  final bool isLastStep;
  final bool canProceed;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showBack)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.chevron_left),
                label: const Text('Back'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ),
          if (showBack) const SizedBox(width: 12),
          Expanded(
            flex: showBack ? 2 : 1,
            child: FilledButton.icon(
              onPressed: canProceed ? onNext : null,
              icon: Icon(isLastStep ? Icons.check : Icons.chevron_right),
              label: Text(isLastStep ? 'Finish' : 'Next'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: const Color(0xFF1B6B7B),
                disabledBackgroundColor: colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
