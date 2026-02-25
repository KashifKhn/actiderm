import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/walkthrough_step.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final steps = generateFullBodyWalkthrough();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text('Add Scan', style: textTheme.titleLarge),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text('Choose scan type', style: textTheme.titleSmall),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _ScanTypeCard(
                    icon: Icons.person_outline,
                    title: 'Single Area Scan',
                    description: 'Photograph and analyse a specific body area',
                    onTap: () => context.go('/add-scan/single'),
                  );
                }
                if (index == 1) {
                  return _ScanTypeCard(
                    icon: Icons.accessibility_new,
                    title: 'Full Body Walkthrough',
                    description:
                        '${steps.requiredCount} required · ${steps.totalCount} total steps',
                    onTap: () => context.go('/add-scan/walkthrough'),
                  );
                }
                return _ScanTypeCard(
                  icon: Icons.sunny,
                  title: 'Sunscreen Check',
                  description: 'Analyse your sunscreen for SPF and ingredients',
                  onTap: () => context.go('/add-scan/sunscreen'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanTypeCard extends StatelessWidget {
  const _ScanTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B6B7B).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: const Color(0xFF1B6B7B), size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      description,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
