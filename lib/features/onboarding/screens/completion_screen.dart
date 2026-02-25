import 'package:flutter/material.dart';

import '../../../shared/widgets/app_button.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: const Color(0xFF1B6B7B).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              size: 52,
              color: Color(0xFF1B6B7B),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "You're all set!",
            textAlign: TextAlign.center,
            style: textTheme.displayLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Start by scanning a body area to track your skin health over time.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const Spacer(flex: 3),
          AppButton(label: 'Start Using ActiDerm', onPressed: onDone),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
