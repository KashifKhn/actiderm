import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class AgeSelectionScreen extends ConsumerWidget {
  const AgeSelectionScreen({super.key});

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
          Text('How old are you?', style: textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'This helps us personalise your skin health plan.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: AgeRange.values.map((age) {
                final selected = state.selectedAge == age;
                return _AgeOption(
                  age: age,
                  selected: selected,
                  onTap: () => notifier.selectAge(age),
                );
              }).toList(),
            ),
          ),
          AppButton(
            label: 'Continue',
            onPressed: state.selectedAge != null
                ? () => notifier.nextStep()
                : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _AgeOption extends StatelessWidget {
  const _AgeOption({
    required this.age,
    required this.selected,
    required this.onTap,
  });

  final AgeRange age;
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
                age.displayName,
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
