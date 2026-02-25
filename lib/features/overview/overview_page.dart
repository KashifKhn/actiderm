import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/body_part.dart';
import '../../services/ai_model/ai_model_service.dart';
import '../../services/ai_model/model_state.dart';
import '../../services/skin_spot_service.dart';
import 'widgets/body_coverage_widget.dart';
import 'widgets/body_map_view.dart';
import 'widgets/stat_card.dart';

class OverviewPage extends ConsumerWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(skinSpotServiceProvider.notifier);
    final spots = ref.watch(skinSpotServiceProvider);
    final modelState = ref.watch(aiModelServiceProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 56, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AppHeader(modelState: modelState),
                  const SizedBox(height: 20),
                  BodyCoverageWidget(
                    completionPercentage: service.completionPercentage,
                    scannedCount: service.scannedTopLevelBodyPartsCount,
                    totalCount: BodyPart.values.length,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          label: 'Photos',
                          value: '${service.totalPhotoCount}',
                          icon: Icons.camera_alt_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          label: 'Scanned',
                          value: '${service.scannedTopLevelBodyPartsCount}',
                          icon: Icons.check_circle_outline,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          label: 'Updates',
                          value: '${service.needsUpdateCount}',
                          icon: Icons.update_outlined,
                          valueColor: service.needsUpdateCount > 0
                              ? Colors.orange
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Body Map', style: textTheme.titleMedium),
                  const SizedBox(height: 12),
                  BodyMapView(spots: spots),
                  const SizedBox(height: 32),
                  if (spots.isNotEmpty) ...[
                    Text('Body Areas', style: textTheme.titleMedium),
                    const SizedBox(height: 12),
                    ...BodyPart.values
                        .where((bp) {
                          return service.spotsForBodyPart(bp).isNotEmpty;
                        })
                        .map(
                          (bp) => _BodyPartRow(
                            bodyPart: bp,
                            spotCount: service.spotsForBodyPart(bp).length,
                          ),
                        ),
                    const SizedBox(height: 32),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'ActiDerm is for tracking purposes only and does not '
                      'provide medical advice or diagnosis. Consult a '
                      'healthcare professional for medical concerns.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppHeader extends StatelessWidget {
  const _AppHeader({required this.modelState});

  final ModelState modelState;

  String get _subtitle => switch (modelState) {
    Idle() => 'Track your skin health',
    Downloading(:final progress) =>
      progress < 0.01
          ? 'Starting download (~2.5 GB)…'
          : 'Downloading AI model… ${(progress * 100).toStringAsFixed(0)}%',
    Loading() => 'Loading AI model…',
    Generating() => 'Analyzing image…',
    Ready() => 'Track your skin health',
    Failed() => 'AI model error — check Settings',
  };

  Color _subtitleColor(ColorScheme colorScheme) => switch (modelState) {
    Idle() => colorScheme.onSurfaceVariant,
    Downloading() => Colors.orange,
    Loading() => Colors.orange,
    Generating() => Colors.orange,
    Ready() => colorScheme.onSurfaceVariant,
    Failed() => colorScheme.error,
  };

  Widget? _trailingIndicator(ModelState state) => switch (state) {
    Downloading(:final progress) => SizedBox(
      width: 48,
      child: LinearProgressIndicator(
        value: progress,
        color: Colors.orange,
        backgroundColor: Colors.orange.withValues(alpha: 0.2),
      ),
    ),
    Loading() => const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange),
    ),
    Generating() => const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange),
    ),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final trailing = _trailingIndicator(modelState);

    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            Icons.health_and_safety_outlined,
            color: colorScheme.onPrimaryContainer,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ActiDerm',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _subtitle,
                style: textTheme.bodySmall?.copyWith(
                  color: _subtitleColor(colorScheme),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 8), trailing],
      ],
    );
  }
}

class _BodyPartRow extends StatelessWidget {
  const _BodyPartRow({required this.bodyPart, required this.spotCount});

  final BodyPart bodyPart;
  final int spotCount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(bodyPart.displayName, style: textTheme.titleMedium),
        subtitle: Text(
          '$spotCount scan${spotCount == 1 ? '' : 's'}',
          style: textTheme.bodyMedium,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1B6B7B).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            bodyPart.subParts.take(2).map((s) => s.displayName).join(', '),
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF1B6B7B),
              fontSize: 11,
            ),
          ),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.person_outline,
            color: colorScheme.onPrimaryContainer,
            size: 20,
          ),
        ),
      ),
    );
  }
}
