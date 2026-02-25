import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class ReminderFrequencyScreen extends ConsumerWidget {
  const ReminderFrequencyScreen({super.key});

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
          Text('Reminder frequency', style: textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'How often would you like to be reminded to check your skin?',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: ReminderFrequency.values.map((freq) {
                final selected = state.selectedReminder == freq;
                return _FreqOption(
                  frequency: freq,
                  selected: selected,
                  onTap: () => notifier.selectReminder(freq),
                );
              }).toList(),
            ),
          ),
          AppButton(label: 'Continue', onPressed: () => notifier.nextStep()),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _FreqOption extends StatelessWidget {
  const _FreqOption({
    required this.frequency,
    required this.selected,
    required this.onTap,
  });

  final ReminderFrequency frequency;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
            Expanded(
              child: Text(
                frequency.displayName,
                style: Theme.of(context).textTheme.titleMedium,
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
