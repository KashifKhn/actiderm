import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/skin_lesion_record.dart';
import '../../../data/models/skin_spot.dart';
import '../../../services/skin_spot_service.dart';
import '../../../shared/extensions/date_extensions.dart';
import '../../../shared/widgets/app_button.dart';
import 'edit_scan_sheet.dart';
import 'report_options_sheet.dart';

class ScanDetailScreen extends ConsumerWidget {
  const ScanDetailScreen({super.key, required this.spotId});

  final String spotId;

  SkinSpot? _findSpot(Map<String, List<SkinSpot>> spots) {
    for (final list in spots.values) {
      for (final spot in list) {
        if (spot.id == spotId) return spot;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spots = ref.watch(skinSpotServiceProvider);
    final spot = _findSpot(spots);

    if (spot == null) {
      return Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: const Center(child: Text('Scan not found')),
      );
    }

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(spot.title),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _showEditSheet(context, ref, spot),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, ref, spot),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (spot.photos.isNotEmpty)
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: spot.photos.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, i) =>
                            _PhotoTile(photo: spot.photos[i]),
                      ),
                    ),
                  const SizedBox(height: 12),
                  _MetaTagsRow(spot: spot),
                  const SizedBox(height: 8),
                  _InfoRow(
                    label: 'Body Area',
                    value:
                        spot.subPart?.displayName ?? spot.bodyPart.displayName,
                  ),
                  _InfoRow(label: 'Created', value: spot.createdDate.shortDate),
                  _InfoRow(
                    label: 'Last Modified',
                    value: spot.lastModified.shortDate,
                  ),
                  if (spot.notes != null && spot.notes!.isNotEmpty)
                    _InfoRow(label: 'Notes', value: spot.notes!),
                  if (spot.analysisRecord != null) ...[
                    const SizedBox(height: 20),
                    Text('AI Analysis', style: textTheme.titleMedium),
                    const SizedBox(height: 12),
                    _AnalysisCard(record: spot.analysisRecord!),
                  ],
                  const SizedBox(height: 24),
                  AppButton(
                    label: 'Export PDF Report',
                    onPressed: () => _showReportSheet(context, ref, spot),
                    outlined: true,
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

  void _showEditSheet(BuildContext context, WidgetRef ref, SkinSpot spot) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => EditScanSheet(spot: spot),
    );
  }

  void _showReportSheet(BuildContext context, WidgetRef ref, SkinSpot spot) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ReportOptionsSheet(initialBodyPart: spot.bodyPart),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    SkinSpot spot,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Scan'),
        content: Text('Delete "${spot.title}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(skinSpotServiceProvider.notifier).deleteSkinSpot(spot);
      if (context.mounted) context.go('/scans');
    }
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.photo});

  final SkinSpotPhoto photo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (photo.imagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(photo.imagePath!),
          width: 160,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 160,
            height: 200,
            color: colorScheme.surfaceContainerHighest,
            child: const Icon(Icons.broken_image_outlined, size: 40),
          ),
        ),
      );
    }
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.image_outlined, size: 40),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value, style: textTheme.bodyLarge)),
        ],
      ),
    );
  }
}

class _AnalysisCard extends StatelessWidget {
  const _AnalysisCard({required this.record});

  final SkinLesionRecord record;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AnalysisRow(label: 'Type', value: record.analysis.lesionType),
            _AnalysisRow(label: 'Color', value: record.analysis.color),
            _AnalysisRow(label: 'Symmetry', value: record.analysis.symmetry),
            _AnalysisRow(label: 'Borders', value: record.analysis.borders),
            _AnalysisRow(label: 'Texture', value: record.analysis.texture),
            const SizedBox(height: 8),
            Text(
              'Summary',
              style: textTheme.titleMedium?.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(record.analysis.summary, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _AnalysisRow extends StatelessWidget {
  const _AnalysisRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaTagsRow extends StatelessWidget {
  const _MetaTagsRow({required this.spot});

  final SkinSpot spot;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final areaLabel = spot.subPart?.displayName ?? spot.bodyPart.displayName;
    final dateLabel = spot.createdDate.shortDate;
    final timeLabel = spot.createdDate.shortTime;

    final chipStyle = textTheme.labelSmall?.copyWith(
      color: const Color(0xFF1B6B7B),
      fontWeight: FontWeight.w600,
    );

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1B6B7B).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.person_outline,
                size: 13,
                color: Color(0xFF1B6B7B),
              ),
              const SizedBox(width: 4),
              Text(areaLabel, style: chipStyle),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 13,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                dateLabel,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.access_time_outlined,
                size: 13,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                timeLabel,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
