import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/body_part.dart';
import '../../../data/models/skin_spot.dart';
import '../../../services/skin_spot_service.dart';
import '../../../shared/extensions/date_extensions.dart';
import '../../../shared/widgets/sheet_title.dart';

class BodyMapView extends ConsumerStatefulWidget {
  const BodyMapView({super.key, required this.spots});

  final Map<String, List<SkinSpot>> spots;

  @override
  ConsumerState<BodyMapView> createState() => _BodyMapViewState();
}

class _BodyMapViewState extends ConsumerState<BodyMapView> {
  BodyOrientation _orientation = BodyOrientation.front;

  Color _heatColor(int count, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (count == 0) {
      return isDark ? const Color(0xFF4A5060) : const Color(0xFFC2C7D0);
    }
    if (count <= 2) return const Color(0xFFFFB300);
    if (count <= 5) return const Color(0xFFFB8C00);
    if (count <= 9) return const Color(0xFFF4511E);
    return const Color(0xFFC62828);
  }

  void _onRegionTapped(BodyPart bodyPart, BodySubPart subPart) {
    showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BodyPartDetailSheet(bodyPart: bodyPart, subPart: subPart),
    ).then((result) {
      if (result == true && mounted) {
        context.go(
          '/add-scan/capture',
          extra: {'bodyPart': bodyPart.name, 'subPart': subPart.name},
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SegmentedButton<BodyOrientation>(
              segments: const [
                ButtonSegment(
                  value: BodyOrientation.front,
                  label: Text('Front'),
                ),
                ButtonSegment(value: BodyOrientation.back, label: Text('Back')),
              ],
              selected: {_orientation},
              onSelectionChanged: (s) => setState(() => _orientation = s.first),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _SvgBodyMap(
                key: ValueKey(_orientation),
                orientation: _orientation,
                spots: widget.spots,
                heatColor: _heatColor,
                onRegionTapped: _onRegionTapped,
              ),
            ),
            const SizedBox(height: 16),
            _HeatmapLegend(heatColor: _heatColor),
          ],
        ),
      ),
    );
  }
}

class _SvgBodyMap extends StatelessWidget {
  const _SvgBodyMap({
    super.key,
    required this.orientation,
    required this.spots,
    required this.heatColor,
    required this.onRegionTapped,
  });

  final BodyOrientation orientation;
  final Map<String, List<SkinSpot>> spots;
  final Color Function(int, BuildContext) heatColor;
  final void Function(BodyPart, BodySubPart) onRegionTapped;

  int _countForSubPart(BodyPart bodyPart, BodySubPart subPart) {
    final key = makeBodyKey(bodyPart: bodyPart, subPart: subPart);
    return (spots[key] ?? []).length;
  }

  @override
  Widget build(BuildContext context) {
    final asset = orientation == BodyOrientation.front
        ? 'assets/svgs/body_front.svg'
        : 'assets/svgs/body_back.svg';

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const viewBoxSize = 1000.0;
        final scale = width / viewBoxSize;
        final height = viewBoxSize * scale;

        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              SvgPicture.asset(asset, width: width, height: height),
              ..._buildRegionOverlays(context, scale),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildRegionOverlays(BuildContext context, double scale) {
    final overlays = <Widget>[];

    for (final part in BodyPart.values) {
      for (final subPart in part.subParts) {
        if (subPart.svgId(orientation) == null) continue;
        final rect = _approximateRect(subPart, orientation);
        if (rect == null) continue;

        final count = _countForSubPart(part, subPart);
        final color = heatColor(count, context);

        overlays.add(
          Positioned(
            left: rect.left * scale,
            top: rect.top * scale,
            width: rect.width * scale,
            height: rect.height * scale,
            child: GestureDetector(
              onTap: () => onRegionTapped(part, subPart),
              child: Container(
                decoration: BoxDecoration(
                  color: color.withValues(alpha: count > 0 ? 0.6 : 0.25),
                  borderRadius: BorderRadius.circular(4 * scale),
                ),
              ),
            ),
          ),
        );
      }
    }

    return overlays;
  }

  static Rect? _approximateRect(
    BodySubPart subPart,
    BodyOrientation orientation,
  ) {
    if (orientation == BodyOrientation.front) {
      return switch (subPart) {
        BodySubPart.face => const Rect.fromLTWH(462, 22, 78, 100),
        BodySubPart.neck => const Rect.fromLTWH(470, 126, 62, 44),
        BodySubPart.leftEar => const Rect.fromLTWH(536, 64, 18, 48),
        BodySubPart.rightEar => const Rect.fromLTWH(447, 64, 18, 48),
        BodySubPart.chest => const Rect.fromLTWH(416, 178, 168, 152),
        BodySubPart.abdomen => const Rect.fromLTWH(430, 330, 140, 98),
        BodySubPart.groin => const Rect.fromLTWH(420, 428, 160, 80),
        BodySubPart.leftShoulder => const Rect.fromLTWH(573, 178, 56, 62),
        BodySubPart.rightShoulder => const Rect.fromLTWH(372, 178, 56, 62),
        BodySubPart.leftUnderarm => const Rect.fromLTWH(580, 228, 20, 54),
        BodySubPart.rightUnderarm => const Rect.fromLTWH(400, 228, 20, 54),
        BodySubPart.leftUpperArm => const Rect.fromLTWH(594, 232, 32, 54),
        BodySubPart.leftForearm => const Rect.fromLTWH(616, 316, 46, 52),
        BodySubPart.leftHandBack => const Rect.fromLTWH(700, 430, 50, 70),
        BodySubPart.rightUpperArm => const Rect.fromLTWH(374, 232, 32, 54),
        BodySubPart.rightForearm => const Rect.fromLTWH(338, 316, 46, 52),
        BodySubPart.rightHandBack => const Rect.fromLTWH(252, 430, 50, 70),
        BodySubPart.leftThigh => const Rect.fromLTWH(503, 508, 94, 162),
        BodySubPart.leftShin => const Rect.fromLTWH(545, 680, 54, 220),
        BodySubPart.leftFootTop => const Rect.fromLTWH(555, 895, 60, 50),
        BodySubPart.rightThigh => const Rect.fromLTWH(402, 508, 94, 162),
        BodySubPart.rightShin => const Rect.fromLTWH(400, 680, 54, 220),
        BodySubPart.rightFootTop => const Rect.fromLTWH(385, 895, 60, 50),
        _ => null,
      };
    } else {
      return switch (subPart) {
        BodySubPart.scalp => const Rect.fromLTWH(460, 22, 82, 30),
        BodySubPart.neck => const Rect.fromLTWH(464, 120, 74, 46),
        BodySubPart.leftEar => const Rect.fromLTWH(450, 64, 18, 48),
        BodySubPart.rightEar => const Rect.fromLTWH(534, 64, 18, 48),
        BodySubPart.upperBack => const Rect.fromLTWH(406, 172, 190, 178),
        BodySubPart.lowerBack => const Rect.fromLTWH(430, 340, 142, 68),
        BodySubPart.buttocks => const Rect.fromLTWH(408, 408, 186, 112),
        BodySubPart.leftShoulder => const Rect.fromLTWH(372, 178, 58, 62),
        BodySubPart.rightShoulder => const Rect.fromLTWH(572, 178, 58, 62),
        BodySubPart.leftUpperArm => const Rect.fromLTWH(352, 232, 44, 84),
        BodySubPart.leftForearm => const Rect.fromLTWH(340, 316, 54, 62),
        BodySubPart.leftHandBack => const Rect.fromLTWH(288, 434, 56, 66),
        BodySubPart.rightUpperArm => const Rect.fromLTWH(604, 232, 44, 84),
        BodySubPart.rightForearm => const Rect.fromLTWH(606, 316, 54, 62),
        BodySubPart.rightHandBack => const Rect.fromLTWH(656, 434, 56, 66),
        BodySubPart.leftThigh => const Rect.fromLTWH(404, 512, 100, 166),
        BodySubPart.leftCalf => const Rect.fromLTWH(388, 680, 68, 218),
        BodySubPart.leftFootSole => const Rect.fromLTWH(358, 934, 68, 42),
        BodySubPart.leftFootHeel => const Rect.fromLTWH(365, 884, 64, 50),
        BodySubPart.rightThigh => const Rect.fromLTWH(498, 512, 100, 166),
        BodySubPart.rightCalf => const Rect.fromLTWH(544, 680, 68, 218),
        BodySubPart.rightFootSole => const Rect.fromLTWH(576, 934, 68, 42),
        BodySubPart.rightFootHeel => const Rect.fromLTWH(570, 884, 64, 50),
        _ => null,
      };
    }
  }
}

class _HeatmapLegend extends StatelessWidget {
  const _HeatmapLegend({required this.heatColor});

  final Color Function(int, BuildContext) heatColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(color: heatColor(0, context), label: '0'),
        const SizedBox(width: 8),
        _LegendItem(color: heatColor(1, context), label: '1–2'),
        const SizedBox(width: 8),
        _LegendItem(color: heatColor(3, context), label: '3–5'),
        const SizedBox(width: 8),
        _LegendItem(color: heatColor(6, context), label: '6–9'),
        const SizedBox(width: 8),
        _LegendItem(color: heatColor(10, context), label: '10+'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}

class BodyPartDetailSheet extends ConsumerWidget {
  const BodyPartDetailSheet({
    super.key,
    required this.bodyPart,
    required this.subPart,
  });

  final BodyPart bodyPart;
  final BodySubPart subPart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(skinSpotServiceProvider.notifier);
    final key = makeBodyKey(bodyPart: bodyPart, subPart: subPart);
    final spots = service.spotsForKey(key);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final lastModified = spots.isEmpty
        ? null
        : spots
              .map((s) => s.lastModified)
              .reduce((a, b) => a.isAfter(b) ? a : b);

    final (statusLabel, statusColor) = spots.isEmpty
        ? ('Not Scanned', colorScheme.onSurfaceVariant)
        : (lastModified!.isOlderThan30Days
              ? ('Needs Update', const Color(0xFFFB8C00))
              : ('Scanned', const Color(0xFF2E7D32)));

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (_, scrollController) {
        return Column(
          children: [
            SheetTitle(
              title: '${bodyPart.displayName} — ${subPart.displayName}',
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusLabel,
                      style: textTheme.labelSmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (lastModified != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      'Last scanned ${lastModified.relativeTime}',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).pop(true),
                    icon: const Icon(Icons.add, size: 16),
                    label: Text(
                      spots.isEmpty ? 'Add First Scan' : 'Add Another Scan',
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      textStyle: textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: spots.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_outlined,
                            size: 48,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No scans for this area',
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      itemCount: spots.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, index) {
                        final spot = spots[index];
                        final firstPhoto = spot.photos.isNotEmpty
                            ? spot.photos.first
                            : null;
                        final thumbPath = firstPhoto?.imagePath;

                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: thumbPath != null
                                  ? Image.file(
                                      File(thumbPath),
                                      width: 44,
                                      height: 44,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          _ThumbPlaceholder(
                                            colorScheme: colorScheme,
                                          ),
                                    )
                                  : _ThumbPlaceholder(colorScheme: colorScheme),
                            ),
                            title: Text(
                              spot.title,
                              style: textTheme.titleSmall,
                            ),
                            subtitle: Text(
                              '${spot.photos.length} photo'
                              '${spot.photos.length == 1 ? '' : 's'}',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (spot.photos.length > 1)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.secondaryContainer,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${spot.photos.length}',
                                      style: textTheme.labelSmall?.copyWith(
                                        color: colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                  ),
                                if (spot.analysisRecord != null) ...[
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.auto_awesome,
                                    size: 16,
                                    color: colorScheme.primary,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _ThumbPlaceholder extends StatelessWidget {
  const _ThumbPlaceholder({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      color: colorScheme.primaryContainer,
      child: Icon(Icons.image_outlined, color: colorScheme.onPrimaryContainer),
    );
  }
}
