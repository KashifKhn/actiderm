import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/ai_model/ai_model_service.dart';
import '../../../services/ai_model/model_state.dart';

class SunscreenScanScreen extends ConsumerStatefulWidget {
  const SunscreenScanScreen({super.key});

  @override
  ConsumerState<SunscreenScanScreen> createState() =>
      _SunscreenScanScreenState();
}

class _SunscreenScanScreenState extends ConsumerState<SunscreenScanScreen> {
  Uint8List? _imageBytes;
  bool _picking = false;
  bool _analysing = false;
  bool _done = false;
  String _buffer = '';
  StreamSubscription<String>? _sub;
  String? _errorMessage;

  String? _spf;
  String? _ingredients;
  String? _summary;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_picking) return;
    setState(() => _picking = true);
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
        maxHeight: 1600,
      );
      if (file == null || !mounted) return;
      final bytes = await file.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _buffer = '';
        _spf = null;
        _ingredients = null;
        _summary = null;
        _errorMessage = null;
        _done = false;
      });
      await _analyse(bytes);
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Future<void> _analyse(Uint8List bytes) async {
    final service = ref.read(aiModelServiceProvider.notifier);
    if (!service.isReady) {
      await service.loadModel();
    }
    if (!mounted) return;
    setState(() {
      _analysing = true;
      _errorMessage = null;
    });

    _sub = service
        .analyzeStreamingTokensForSunscreen(bytes)
        .listen(
          (chunk) {
            if (!mounted) return;
            setState(() => _buffer += chunk);
            _tryParsePartial(_buffer);
          },
          onDone: () {
            if (!mounted) return;
            setState(() {
              _analysing = false;
              _done = true;
            });
          },
          onError: (Object e) {
            if (!mounted) return;
            setState(() {
              _analysing = false;
              _errorMessage = e.toString();
            });
          },
        );
  }

  void _tryParsePartial(String buf) {
    final spfMatch = RegExp(
      r'"spf"\s*:\s*"([^"]+)"',
      caseSensitive: false,
    ).firstMatch(buf);
    if (spfMatch != null) {
      _spf = spfMatch.group(1);
    }

    final ingMatch = RegExp(
      r'"ingredients"\s*:\s*"([^"]+)"',
      caseSensitive: false,
    ).firstMatch(buf);
    if (ingMatch != null) {
      _ingredients = ingMatch.group(1);
    }

    final sumMatch = RegExp(
      r'"summary"\s*:\s*"([^"]+)"',
      caseSensitive: false,
    ).firstMatch(buf);
    if (sumMatch != null) {
      _summary = sumMatch.group(1);
    }
  }

  void _retake() {
    _sub?.cancel();
    setState(() {
      _imageBytes = null;
      _buffer = '';
      _spf = null;
      _ingredients = null;
      _summary = null;
      _errorMessage = null;
      _analysing = false;
      _done = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final modelState = ref.watch(aiModelServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunscreen Check'),
        leading: BackButton(
          onPressed: () {
            _sub?.cancel();
            context.go('/add-scan');
          },
        ),
      ),
      body: _imageBytes == null
          ? _PickerView(
              picking: _picking,
              modelState: modelState,
              onCamera: () => _pickImage(ImageSource.camera),
              onGallery: () => _pickImage(ImageSource.gallery),
            )
          : _AnalysisView(
              imageBytes: _imageBytes!,
              analysing: _analysing,
              done: _done,
              spf: _spf,
              ingredients: _ingredients,
              summary: _summary,
              errorMessage: _errorMessage,
              onRetake: _retake,
              onRetry: () => _analyse(_imageBytes!),
              textTheme: textTheme,
              colorScheme: colorScheme,
            ),
    );
  }
}

class _PickerView extends StatelessWidget {
  const _PickerView({
    required this.picking,
    required this.modelState,
    required this.onCamera,
    required this.onGallery,
  });

  final bool picking;
  final ModelState modelState;
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Photograph your sunscreen', style: textTheme.displaySmall),
          const SizedBox(height: 8),
          Text(
            'Point the camera at the label of your sunscreen product '
            'to analyse the SPF and active ingredients.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 40),
          _OptionTile(
            icon: Icons.camera_alt_outlined,
            title: 'Take Photo',
            description: 'Use the camera to capture the label',
            onTap: picking ? null : onCamera,
          ),
          const SizedBox(height: 16),
          _OptionTile(
            icon: Icons.photo_library_outlined,
            title: 'Choose from Library',
            description: 'Import an existing photo',
            onTap: picking ? null : onGallery,
          ),
          if (picking) ...[
            const SizedBox(height: 32),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;

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
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B6B7B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: const Color(0xFF1B6B7B), size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(description, style: textTheme.bodyMedium),
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

class _AnalysisView extends StatelessWidget {
  const _AnalysisView({
    required this.imageBytes,
    required this.analysing,
    required this.done,
    required this.spf,
    required this.ingredients,
    required this.summary,
    required this.errorMessage,
    required this.onRetake,
    required this.onRetry,
    required this.textTheme,
    required this.colorScheme,
  });

  final Uint8List imageBytes;
  final bool analysing;
  final bool done;
  final String? spf;
  final String? ingredients;
  final String? summary;
  final String? errorMessage;
  final VoidCallback onRetake;
  final VoidCallback onRetry;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.memory(imageBytes, height: 220, fit: BoxFit.cover),
          ),
          const SizedBox(height: 20),
          if (analysing && errorMessage == null)
            _AnalysingCard(
              spf: spf,
              ingredients: ingredients,
              summary: summary,
              textTheme: textTheme,
              colorScheme: colorScheme,
            ),
          if (errorMessage != null)
            _ErrorCard(
              message: errorMessage!,
              onRetry: onRetry,
              textTheme: textTheme,
              colorScheme: colorScheme,
            ),
          if (done && errorMessage == null)
            _ResultCard(
              spf: spf,
              ingredients: ingredients,
              summary: summary,
              textTheme: textTheme,
              colorScheme: colorScheme,
            ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: onRetake,
            icon: const Icon(Icons.refresh),
            label: const Text('Scan Another Product'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalysingCard extends StatelessWidget {
  const _AnalysingCard({
    required this.spf,
    required this.ingredients,
    required this.summary,
    required this.textTheme,
    required this.colorScheme,
  });

  final String? spf;
  final String? ingredients;
  final String? summary;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Text('Analysing…', style: textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 12),
            _FieldRow(
              label: 'SPF',
              value: spf,
              textTheme: textTheme,
              colorScheme: colorScheme,
            ),
            _FieldRow(
              label: 'Active Ingredients',
              value: ingredients,
              textTheme: textTheme,
              colorScheme: colorScheme,
            ),
            _FieldRow(
              label: 'Summary',
              value: summary,
              textTheme: textTheme,
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.spf,
    required this.ingredients,
    required this.summary,
    required this.textTheme,
    required this.colorScheme,
  });

  final String? spf;
  final String? ingredients;
  final String? summary;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.sunny, color: Color(0xFF1B6B7B), size: 18),
                const SizedBox(width: 8),
                Text('Sunscreen Analysis', style: textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 12),
            if (spf != null)
              _FieldRow(
                label: 'SPF',
                value: spf,
                textTheme: textTheme,
                colorScheme: colorScheme,
              ),
            if (ingredients != null)
              _FieldRow(
                label: 'Active Ingredients',
                value: ingredients,
                textTheme: textTheme,
                colorScheme: colorScheme,
              ),
            if (summary != null)
              _FieldRow(
                label: 'Summary',
                value: summary,
                textTheme: textTheme,
                colorScheme: colorScheme,
              ),
            if (spf == null && ingredients == null && summary == null)
              Text(
                'Could not extract sunscreen information from this image.',
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

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({
    required this.message,
    required this.onRetry,
    required this.textTheme,
    required this.colorScheme,
  });

  final String message;
  final VoidCallback onRetry;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline, color: colorScheme.error, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Analysis Failed',
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onErrorContainer,
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.label,
    required this.value,
    required this.textTheme,
    required this.colorScheme,
  });

  final String label;
  final String? value;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: value != null
                ? Text(value!, style: textTheme.bodyMedium)
                : Container(
                    height: 14,
                    width: 80,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
