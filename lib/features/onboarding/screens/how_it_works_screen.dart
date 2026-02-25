import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class HowItWorksScreen extends ConsumerWidget {
  const HowItWorksScreen({super.key});

  static const List<_Step> _steps = [
    _Step(
      number: '1',
      title: 'Choose a body area',
      description: 'Select from the interactive body map or list',
    ),
    _Step(
      number: '2',
      title: 'Photograph your skin',
      description: 'Take a close-up photo or import from your library',
    ),
    _Step(
      number: '3',
      title: 'AI analyses the lesion',
      description: 'On-device model checks type, colour, symmetry and borders',
    ),
    _Step(
      number: '4',
      title: 'Track changes over time',
      description: 'Add more photos to the same spot to monitor progression',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text('How it works', style: textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'Four simple steps to track your skin health.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: _steps.length,
              itemBuilder: (context, index) => _StepItem(
                step: _steps[index],
                isLast: index == _steps.length - 1,
              ),
            ),
          ),
          AppButton(
            label: 'Continue',
            onPressed: () =>
                ref.read(onboardingServiceProvider.notifier).nextStep(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _Step {
  const _Step({
    required this.number,
    required this.title,
    required this.description,
  });

  final String number;
  final String title;
  final String description;
}

class _StepItem extends StatelessWidget {
  const _StepItem({required this.step, required this.isLast});

  final _Step step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF1B6B7B),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    step.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: colorScheme.outlineVariant),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(step.title, style: textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(step.description, style: textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
