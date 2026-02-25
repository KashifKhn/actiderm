import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Icons.health_and_safety,
              size: 52,
              color: Color(0xFF1B6B7B),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Welcome to\nActiDerm',
            textAlign: TextAlign.center,
            style: textTheme.displayLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Your personal skin health companion.\nTrack, monitor, and analyze your skin with AI-powered insights.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const Spacer(flex: 3),
          AppButton(
            label: 'Get Started',
            onPressed: () =>
                ref.read(onboardingServiceProvider.notifier).nextStep(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
