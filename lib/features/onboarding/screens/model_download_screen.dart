import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../services/ai_model/ai_model_service.dart';
import '../../../services/ai_model/model_state.dart';
import '../../../services/onboarding_service.dart';
import '../../../shared/widgets/app_button.dart';

class ModelDownloadScreen extends ConsumerStatefulWidget {
  const ModelDownloadScreen({super.key});

  @override
  ConsumerState<ModelDownloadScreen> createState() =>
      _ModelDownloadScreenState();
}

class _ModelDownloadScreenState extends ConsumerState<ModelDownloadScreen> {
  bool _downloading = false;

  Future<void> _startDownload() async {
    setState(() => _downloading = true);
    await ref
        .read(aiModelServiceProvider.notifier)
        .downloadModel(
          url:
              'https://huggingface.co/${AppConstants.hfModelId}/resolve/main/${AppConstants.modelFilename}',
          onProgress: (_) {},
        );
    setState(() => _downloading = false);
  }

  @override
  Widget build(BuildContext context) {
    final modelState = ref.watch(aiModelServiceProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final downloadingState = modelState is Downloading ? modelState : null;
    final isDownloading = downloadingState != null;
    final isFailed = modelState is Failed;
    final isIdle = modelState is Idle;

    final progress = downloadingState?.progress ?? 0.0;

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
              Icons.auto_awesome_outlined,
              size: 52,
              color: Color(0xFF1B6B7B),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Download AI Model',
            textAlign: TextAlign.center,
            style: textTheme.displayMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'The on-device AI model (~2.5 GB) analyses your skin photos privately — no data ever leaves your device.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          if (isDownloading) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: colorScheme.surfaceContainerHighest,
                color: const Color(0xFF1B6B7B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: textTheme.bodyMedium,
            ),
          ],
          if (isFailed)
            Text(
              'Download failed. Please try again.',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
              textAlign: TextAlign.center,
            ),
          const Spacer(flex: 3),
          if (isIdle || isFailed)
            AppButton(
              label: isFailed ? 'Retry Download' : 'Download Now',
              onPressed: _downloading ? null : _startDownload,
            )
          else if (isDownloading)
            const AppButton(label: 'Downloading…', onPressed: null),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () =>
                ref.read(onboardingServiceProvider.notifier).nextStep(),
            child: Text(
              'Skip — download later in Settings',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
