import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class CameraPermissionScreen extends ConsumerStatefulWidget {
  const CameraPermissionScreen({super.key});

  @override
  ConsumerState<CameraPermissionScreen> createState() =>
      _CameraPermissionScreenState();
}

class _CameraPermissionScreenState
    extends ConsumerState<CameraPermissionScreen> {
  bool _granted = false;
  bool _loading = false;

  Future<void> _requestPermission() async {
    setState(() => _loading = true);
    final status = await Permission.camera.request();
    setState(() {
      _granted = status.isGranted;
      _loading = false;
    });
    if (status.isGranted) {
      ref.read(onboardingServiceProvider.notifier).nextStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: const Color(0xFF1B6B7B).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 52,
              color: Color(0xFF1B6B7B),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Camera Access',
            textAlign: TextAlign.center,
            style: textTheme.displayMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'ActiDerm needs camera access to photograph your skin spots. Photos are stored privately on your device.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const Spacer(flex: 3),
          if (_granted)
            AppButton(
              label: 'Continue',
              onPressed: () =>
                  ref.read(onboardingServiceProvider.notifier).nextStep(),
            )
          else
            AppButton(
              label: 'Allow Camera Access',
              onPressed: _requestPermission,
              isLoading: _loading,
            ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () =>
                ref.read(onboardingServiceProvider.notifier).nextStep(),
            child: Text(
              'Skip for now',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
