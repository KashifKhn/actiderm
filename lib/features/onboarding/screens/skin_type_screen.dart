import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class SkinTypeScreen extends ConsumerWidget {
  const SkinTypeScreen({super.key});

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
          Text('Your skin type', style: textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'Fitzpatrick scale helps tailor your risk assessment.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: SkinType.values.map((type) {
                final selected = state.selectedSkinType == type;
                return _SkinTypeOption(
                  type: type,
                  selected: selected,
                  onTap: () => notifier.selectSkinType(type),
                );
              }).toList(),
            ),
          ),
          AppButton(
            label: 'Continue',
            onPressed: state.selectedSkinType != null
                ? () => notifier.nextStep()
                : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SkinTypeOption extends StatelessWidget {
  const _SkinTypeOption({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final SkinType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(type.skinToneHex),
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(type.displayName, style: textTheme.titleMedium),
                  Text(type.description, style: textTheme.bodyMedium),
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
