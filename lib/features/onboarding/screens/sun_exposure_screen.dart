import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class SunExposureScreen extends ConsumerWidget {
  const SunExposureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingServiceProvider);
    final notifier = ref.read(onboardingServiceProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text('Sun exposure', style: textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'How much time do you typically spend outdoors?',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: SunExposure.values.map((exposure) {
                final selected = state.selectedSunExposure == exposure;
                return _ExposureOption(
                  exposure: exposure,
                  selected: selected,
                  onTap: () => notifier.selectSunExposure(exposure),
                );
              }).toList(),
            ),
          ),
          AppButton(
            label: 'Continue',
            onPressed: state.selectedSunExposure != null
                ? () => notifier.nextStep()
                : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ExposureOption extends StatelessWidget {
  const _ExposureOption({
    required this.exposure,
    required this.selected,
    required this.onTap,
  });

  final SunExposure exposure;
  final bool selected;
  final VoidCallback onTap;

  IconData get _icon => switch (exposure) {
    SunExposure.minimal => Icons.home_outlined,
    SunExposure.moderate => Icons.wb_cloudy_outlined,
    SunExposure.frequent => Icons.wb_sunny_outlined,
    SunExposure.extensive => Icons.sunny,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF1B6B7B).withValues(alpha: 0.1)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? const Color(0xFF1B6B7B) : colorScheme.outline,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _icon,
              color: selected
                  ? const Color(0xFF1B6B7B)
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exposure.displayName, style: textTheme.titleMedium),
                  Text(exposure.description, style: textTheme.bodyMedium),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: Color(0xFF1B6B7B)),
          ],
        ),
      ),
    );
  }
}
