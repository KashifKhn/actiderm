import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/biometric_service.dart';
import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class BiometricLockScreen extends ConsumerStatefulWidget {
  const BiometricLockScreen({super.key});

  @override
  ConsumerState<BiometricLockScreen> createState() =>
      _BiometricLockScreenState();
}

class _BiometricLockScreenState extends ConsumerState<BiometricLockScreen> {
  bool _available = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _checkAvailability();
  }

  Future<void> _checkAvailability() async {
    final available = await ref
        .read(biometricServiceProvider.notifier)
        .hasBiometrics();
    setState(() => _available = available);
  }

  Future<void> _enableBiometric() async {
    setState(() => _loading = true);
    await ref
        .read(biometricServiceProvider.notifier)
        .setBiometricEnabled(enabled: true);
    setState(() => _loading = false);
    ref.read(onboardingServiceProvider.notifier).nextStep();
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
              Icons.fingerprint,
              size: 52,
              color: Color(0xFF1B6B7B),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Secure your data',
            textAlign: TextAlign.center,
            style: textTheme.displayMedium,
          ),
          const SizedBox(height: 16),
          Text(
            _available
                ? 'Protect your skin health records with Face ID or Touch ID.'
                : 'Biometric authentication is not available on this device.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const Spacer(flex: 3),
          if (_available)
            AppButton(
              label: 'Enable Biometric Lock',
              onPressed: _loading ? null : _enableBiometric,
              isLoading: _loading,
            ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () =>
                ref.read(onboardingServiceProvider.notifier).nextStep(),
            child: Text(
              'Skip',
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
