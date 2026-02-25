import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/body_part.dart';

class SubPartSelectionScreen extends StatefulWidget {
  const SubPartSelectionScreen({super.key, required this.bodyPart});

  final BodyPart bodyPart;

  @override
  State<SubPartSelectionScreen> createState() => _SubPartSelectionScreenState();
}

class _SubPartSelectionScreenState extends State<SubPartSelectionScreen> {
  BodyOrientation? _selectedOrientation;

  List<BodySubPart> get _filtered {
    final all = widget.bodyPart.subParts;
    final orientation = _selectedOrientation;
    if (orientation == null) return all;
    return all.where((s) {
      final preferred = s.preferredOrientation;
      return preferred == null || preferred == orientation;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final subParts = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bodyPart.displayName),
        leading: const BackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Select a specific area to scan',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<BodyOrientation?>(
              segments: const [
                ButtonSegment(value: null, label: Text('All')),
                ButtonSegment(
                  value: BodyOrientation.front,
                  label: Text('Front'),
                ),
                ButtonSegment(value: BodyOrientation.back, label: Text('Back')),
              ],
              selected: {_selectedOrientation},
              onSelectionChanged: (Set<BodyOrientation?> selection) {
                setState(() => _selectedOrientation = selection.first);
              },
              showSelectedIcon: false,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: subParts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final subPart = subParts[index];
                final orientation = subPart.preferredOrientation;
                return Card(
                  child: ListTile(
                    title: Text(subPart.displayName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (orientation != null)
                          _OrientationBadge(orientation: orientation),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () => context.go(
                      '/add-scan/capture',
                      extra: {
                        'bodyPart': widget.bodyPart.name,
                        'subPart': subPart.name,
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton(
              onPressed: () => context.go(
                '/add-scan/capture',
                extra: {'bodyPart': widget.bodyPart.name},
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text('Scan Entire ${widget.bodyPart.displayName}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrientationBadge extends StatelessWidget {
  const _OrientationBadge({required this.orientation});

  final BodyOrientation orientation;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final label = orientation == BodyOrientation.front ? 'Front' : 'Back';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}
