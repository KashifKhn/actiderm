import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../services/onboarding_service.dart';
import 'screens/age_selection_screen.dart';
import 'screens/benefits_screen.dart';
import 'screens/biometric_lock_screen.dart';
import 'screens/camera_permission_screen.dart';
import 'screens/completion_screen.dart';
import 'screens/how_it_works_screen.dart';
import 'screens/model_download_screen.dart';
import 'screens/reminder_frequency_screen.dart';
import 'screens/skin_type_screen.dart';
import 'screens/sun_exposure_screen.dart';
import 'screens/welcome_screen.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingServiceProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (state.currentStep > 0 && state.currentStep < 10)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: LinearProgressIndicator(
                  value: state.currentStep / 10,
                  borderRadius: BorderRadius.circular(4),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  color: const Color(0xFF1B6B7B),
                ),
              ),
            Expanded(child: _screenForStep(state.currentStep, ref, context)),
          ],
        ),
      ),
    );
  }

  Widget _screenForStep(int step, WidgetRef ref, BuildContext context) =>
      switch (step) {
        0 => const WelcomeScreen(),
        1 => const AgeSelectionScreen(),
        2 => const SkinTypeScreen(),
        3 => const SunExposureScreen(),
        4 => const BenefitsScreen(),
        5 => const HowItWorksScreen(),
        6 => const ReminderFrequencyScreen(),
        7 => const CameraPermissionScreen(),
        8 => const ModelDownloadScreen(),
        9 => const BiometricLockScreen(),
        10 => CompletionScreen(
          onDone: () async {
            await ref
                .read(onboardingServiceProvider.notifier)
                .saveOnboardingCompletion();
            if (context.mounted) context.go('/overview');
          },
        ),
        _ => const SizedBox.shrink(),
      };
}
