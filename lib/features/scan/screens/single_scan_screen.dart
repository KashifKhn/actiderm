import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/body_part.dart';

class SingleScanScreen extends StatelessWidget {
  const SingleScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Area'),
        leading: const BackButton(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Choose a body area to scan',
                style: textTheme.bodyLarge,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList.separated(
              itemCount: BodyPart.values.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final bodyPart = BodyPart.values[index];
                return _BodyPartCard(bodyPart: bodyPart);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyPartCard extends StatelessWidget {
  const _BodyPartCard({required this.bodyPart});

  final BodyPart bodyPart;

  void _onTap(BuildContext context) {
    if (bodyPart.subParts.isEmpty) {
      context.go('/add-scan/capture', extra: {'bodyPart': bodyPart.name});
    } else {
      context.go('/add-scan/sub-parts', extra: {'bodyPart': bodyPart.name});
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        onTap: () => _onTap(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B6B7B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF1B6B7B),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bodyPart.displayName, style: textTheme.titleMedium),
                    if (bodyPart.subParts.isNotEmpty)
                      Text(
                        bodyPart.subParts
                            .take(3)
                            .map((s) => s.displayName)
                            .join(', '),
                        style: textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
