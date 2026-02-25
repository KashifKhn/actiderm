import 'package:flutter/material.dart';

class BodyCoverageWidget extends StatelessWidget {
  const BodyCoverageWidget({
    super.key,
    required this.completionPercentage,
    required this.scannedCount,
    required this.totalCount,
  });

  final double completionPercentage;
  final int scannedCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final pct = (completionPercentage * 100).toInt();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Body Coverage', style: textTheme.titleMedium),
                Text(
                  '$pct%',
                  style: textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF1B6B7B),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: completionPercentage,
                minHeight: 10,
                backgroundColor: colorScheme.surfaceContainerHighest,
                color: const Color(0xFF1B6B7B),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$scannedCount of $totalCount body areas scanned',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
