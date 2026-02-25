import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/body_part.dart';
import '../../data/models/skin_spot.dart';
import '../../services/skin_spot_service.dart';
import '../../shared/extensions/date_extensions.dart';

class SavedScansPage extends ConsumerStatefulWidget {
  const SavedScansPage({super.key});

  @override
  ConsumerState<SavedScansPage> createState() => _SavedScansPageState();
}

class _SavedScansPageState extends ConsumerState<SavedScansPage> {
  ScanFilter _filter = ScanFilter.allBody;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final allSpots = ref.watch(skinSpotServiceProvider.notifier).allSpots;
    final textTheme = Theme.of(context).textTheme;

    final filterParts = _filter.bodyParts;
    final filtered = allSpots.where((s) {
      if (filterParts != null && !filterParts.contains(s.bodyPart)) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return s.title.toLowerCase().contains(q) ||
            (s.notes?.toLowerCase().contains(q) ?? false);
      }
      return true;
    }).toList()..sort((a, b) => b.lastModified.compareTo(a.lastModified));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text('Saved Scans', style: textTheme.titleLarge),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(108),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  children: [
                    SearchBar(
                      hintText: 'Search scans…',
                      leading: const Icon(Icons.search, size: 20),
                      onChanged: (v) => setState(() => _searchQuery = v),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _FilterChips(
                      selected: _filter,
                      onSelected: (f) => setState(() => _filter = f),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (filtered.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('No scans found')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => _ScanCard(
                  spot: filtered[index],
                  onDelete: () => _confirmDelete(context, filtered[index]),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, SkinSpot spot) async {
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
    }
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.selected, required this.onSelected});

  final ScanFilter selected;
  final void Function(ScanFilter) onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ScanFilter.values
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(f.displayName),
                  selected: selected == f,
                  onSelected: (_) => onSelected(f),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ScanCard extends StatelessWidget {
  const _ScanCard({required this.spot, required this.onDelete});

  final SkinSpot spot;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.go('/scans/${spot.id}'),
        onLongPress: onDelete,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    spot.photos.isNotEmpty &&
                        spot.photos.first.imagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(spot.photos.first.imagePath!),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_outlined),
                        ),
                      )
                    : const Icon(Icons.image_outlined),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(spot.title, style: textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      spot.subPart?.displayName ?? spot.bodyPart.displayName,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${spot.photos.length} photo'
                          '${spot.photos.length == 1 ? '' : 's'}',
                          style: textTheme.bodyMedium?.copyWith(fontSize: 12),
                        ),
                        if (spot.analysisRecord != null) ...[
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.auto_awesome,
                            size: 13,
                            color: Color(0xFF1B6B7B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Analysed',
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              color: const Color(0xFF1B6B7B),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                spot.lastModified.relativeTime,
                style: textTheme.bodyMedium?.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
