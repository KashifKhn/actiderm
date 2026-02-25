import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class BenefitsScreen extends ConsumerWidget {
  const BenefitsScreen({super.key});

  static const List<_Benefit> _benefits = [
    _Benefit(
      icon: Icons.camera_enhance_outlined,
      title: 'Photo Tracking',
      description: 'Document changes over time with timestamped photos',
    ),
    _Benefit(
      icon: Icons.auto_awesome_outlined,
      title: 'AI Analysis',
      description: 'On-device AI analyses lesion characteristics privately',
    ),
    _Benefit(
      icon: Icons.insert_chart_outlined,
      title: 'Body Coverage',
      description: 'Interactive body map shows your scan completeness',
    ),
    _Benefit(
      icon: Icons.picture_as_pdf_outlined,
      title: 'PDF Reports',
      description: 'Generate professional reports to share with your doctor',
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
          Text('What ActiDerm does', style: textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'Everything you need to stay on top of your skin health.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.separated(
              itemCount: _benefits.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) =>
                  _BenefitCard(benefit: _benefits[index]),
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

class _Benefit {
  const _Benefit({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({required this.benefit});

  final _Benefit benefit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF1B6B7B).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(benefit.icon, color: const Color(0xFF1B6B7B), size: 26),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(benefit.title, style: textTheme.titleMedium),
              const SizedBox(height: 2),
              Text(benefit.description, style: textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
