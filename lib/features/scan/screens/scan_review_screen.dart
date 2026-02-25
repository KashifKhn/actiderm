import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/body_part.dart';
import '../../../data/models/skin_analysis.dart';
import '../../../data/models/skin_lesion_record.dart';
import '../../../data/models/skin_spot.dart';
import '../../../services/ai_model/ai_model_service.dart';
import '../../../services/ai_model/model_state.dart';
import '../../../services/skin_spot_service.dart';
import '../../../shared/utils/haptic_manager.dart';
import '../../../shared/widgets/app_button.dart';

class _PartialAnalysis {
  String? lesionType;
  String? color;
  String? symmetry;
  String? borders;
  String? texture;
  String? summary;

  bool get isComplete =>
      lesionType != null &&
      color != null &&
      symmetry != null &&
      borders != null &&
      texture != null &&
      summary != null;
}

_PartialAnalysis _parsePartial(String buffer) {
  final result = _PartialAnalysis();

  String? extract(String key) {
    final match = RegExp('"$key"\\s*:\\s*"([^"]+)"').firstMatch(buffer);
    return match?.group(1);
  }

  result.lesionType = extract('lesion_type');
  result.color = extract('color');
  result.symmetry = extract('symmetry');
  result.borders = extract('borders');
  result.texture = extract('texture');
  result.summary = extract('summary');
  return result;
}

class ScanReviewScreen extends ConsumerStatefulWidget {
  const ScanReviewScreen({
    super.key,
    required this.bodyPart,
    this.subPart,
    this.spotId,
    this.imageBytes,
  });

  final BodyPart bodyPart;
  final BodySubPart? subPart;
  final String? spotId;
  final Uint8List? imageBytes;

  @override
  ConsumerState<ScanReviewScreen> createState() => _ScanReviewScreenState();
}

class _ScanReviewScreenState extends ConsumerState<ScanReviewScreen> {
  String? _title;
  String? _notes;
  bool _saving = false;
  bool _analysing = false;
  bool _analysisDone = false;
  bool _analysisError = false;
  String _tokenBuffer = '';
  _PartialAnalysis _partial = _PartialAnalysis();
  SkinAnalysis? _finalAnalysis;
  StreamSubscription<String>? _streamSub;

  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _titleController.text =
        widget.subPart?.displayName ?? widget.bodyPart.displayName;
    _title = _titleController.text;
    if (widget.imageBytes != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startAnalysis());
    }
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _startAnalysis() async {
    final aiService = ref.read(aiModelServiceProvider.notifier);
    if (ref.read(aiModelServiceProvider) is! Ready) {
      setState(() => _analysing = true);
      await aiService.loadModel();
      if (!mounted) return;
      if (ref.read(aiModelServiceProvider) is! Ready) {
        setState(() {
          _analysing = false;
          _analysisError = true;
        });
        return;
      }
    }
    setState(() {
      _analysing = true;
      _analysisDone = false;
      _analysisError = false;
      _tokenBuffer = '';
      _partial = _PartialAnalysis();
      _finalAnalysis = null;
    });

    _streamSub = aiService
        .analyzeStreamingTokens(widget.imageBytes!)
        .listen(
          (token) {
            if (!mounted) return;
            setState(() {
              _tokenBuffer += token;
              _partial = _parsePartial(_tokenBuffer);
            });
          },
          onDone: () {
            if (!mounted) return;
            final analysis = _tryFullParse(_tokenBuffer);
            setState(() {
              _finalAnalysis = analysis;
              _analysing = false;
              _analysisDone = true;
              _analysisError = analysis == null;
            });
            if (analysis != null) HapticManager.success();
          },
          onError: (_) {
            if (!mounted) return;
            setState(() {
              _analysing = false;
              _analysisError = true;
            });
            HapticManager.error();
          },
        );
  }

  SkinAnalysis? _tryFullParse(String raw) {
    final cleaned = raw
        .replaceAll(RegExp(r'```json\s*'), '')
        .replaceAll(RegExp(r'```\s*'), '')
        .trim();
    final decoded = _extractFields(cleaned);
    if (decoded != null) {
      try {
        return SkinAnalysis.fromJson(decoded);
      } catch (_) {}
    }
    return null;
  }

  Map<String, dynamic>? _extractFields(String raw) {
    try {
      final result = <String, dynamic>{};

      String? extract(String jsonKey) {
        final m = RegExp('"$jsonKey"\\s*:\\s*"([^"]+)"').firstMatch(raw);
        return m?.group(1);
      }

      final lesionType = extract('lesion_type');
      final color = extract('color');
      final symmetry = extract('symmetry');
      final borders = extract('borders');
      final texture = extract('texture');
      final summary = extract('summary');

      if (lesionType != null) result['lesion_type'] = lesionType;
      if (color != null) result['color'] = color;
      if (symmetry != null) result['symmetry'] = symmetry;
      if (borders != null) result['borders'] = borders;
      if (texture != null) result['texture'] = texture;
      if (summary != null) result['summary'] = summary;

      if (result.length == 6) return result;
    } catch (_) {}
    return null;
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final now = DateTime.now();
      final spotId = widget.spotId ?? _uuid.v4();
      final photoId = _uuid.v4();

      SkinLesionRecord? analysisRecord;
      if (_finalAnalysis != null) {
        analysisRecord = SkinLesionRecord(
          id: _uuid.v4(),
          imagePath: '',
          timestamp: now.toIso8601String(),
          analysis: _finalAnalysis!,
        );
      }

      final photo = SkinSpotPhoto(id: photoId, dateTaken: now, notes: _notes);
      final spot = SkinSpot(
        id: spotId,
        title: _title ?? widget.bodyPart.displayName,
        notes: _notes,
        photos: [photo],
        createdDate: now,
        lastModified: now,
        bodyPart: widget.bodyPart,
        subPart: widget.subPart,
        analysisRecord: analysisRecord,
      );

      await ref
          .read(skinSpotServiceProvider.notifier)
          .addSkinSpot(
            spot: spot,
            bodyPart: widget.bodyPart,
            subPart: widget.subPart,
            imageBytes: widget.imageBytes,
          );

      await HapticManager.success();
      if (mounted) context.go('/scans');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _discard() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard Scan?'),
        content: const Text(
          'This scan will not be saved. Any AI analysis will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Discard',
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      _streamSub?.cancel();
      if (mounted) context.go('/add-scan');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Scan'),
        leading: BackButton(
          onPressed: () {
            _streamSub?.cancel();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.imageBytes != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  widget.imageBytes!,
                  width: double.infinity,
                  height: 260,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(Icons.image_outlined, size: 48),
                ),
              ),
            const SizedBox(height: 12),
            _ScanMetaTagsRow(
              bodyPart: widget.bodyPart,
              subPart: widget.subPart,
              date: DateTime.now(),
            ),
            const SizedBox(height: 20),
            Text('Scan Details', style: textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              onChanged: (v) => _title = v,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              onChanged: (v) => _notes = v,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            if (widget.imageBytes != null) ...[
              Text('AI Analysis', style: textTheme.titleMedium),
              const SizedBox(height: 12),
              if (_analysisError)
                _AnalysisErrorCard(onRetry: _startAnalysis)
              else
                _StreamingAnalysisCard(
                  partial: _partial,
                  isStreaming: _analysing,
                  isDone: _analysisDone,
                ),
              const SizedBox(height: 24),
            ],
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving || _analysing
                        ? null
                        : () {
                            _streamSub?.cancel();
                            Navigator.of(context).pop();
                          },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Retake'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving ? null : _discard,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      foregroundColor: colorScheme.error,
                      side: BorderSide(color: colorScheme.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Discard'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: AppButton(
                    label: 'Save',
                    onPressed: (_saving || (_analysing && !_analysisDone))
                        ? null
                        : _save,
                    isLoading: _saving,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ScanMetaTagsRow extends StatelessWidget {
  const _ScanMetaTagsRow({
    required this.bodyPart,
    this.subPart,
    required this.date,
  });

  final BodyPart bodyPart;
  final BodySubPart? subPart;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final areaLabel = subPart?.displayName ?? bodyPart.displayName;
    final dateLabel = DateFormat('MMM d, yyyy').format(date);

    return Wrap(
      spacing: 8,
      children: [
        _MetaChip(label: areaLabel, colorScheme: colorScheme),
        _MetaChip(label: dateLabel, colorScheme: colorScheme),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label, required this.colorScheme});

  final String label;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}

class _StreamingAnalysisCard extends StatelessWidget {
  const _StreamingAnalysisCard({
    required this.partial,
    required this.isStreaming,
    required this.isDone,
  });

  final _PartialAnalysis partial;
  final bool isStreaming;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isStreaming && !isDone)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Analysing…',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            _AnalysisFieldRow(label: 'Type', value: partial.lesionType),
            _AnalysisFieldRow(label: 'Color', value: partial.color),
            _AnalysisFieldRow(label: 'Symmetry', value: partial.symmetry),
            _AnalysisFieldRow(label: 'Borders', value: partial.borders),
            _AnalysisFieldRow(label: 'Texture', value: partial.texture),
            const SizedBox(height: 4),
            Text(
              'Summary',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            partial.summary != null
                ? Text(
                    partial.summary!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : const _ValuePlaceholder(wide: true),
          ],
        ),
      ),
    );
  }
}

class _AnalysisFieldRow extends StatelessWidget {
  const _AnalysisFieldRow({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
            child: value != null
                ? Text(
                    value!,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const _ValuePlaceholder(wide: false),
          ),
        ],
      ),
    );
  }
}

class _ValuePlaceholder extends StatefulWidget {
  const _ValuePlaceholder({required this.wide});

  final bool wide;

  @override
  State<_ValuePlaceholder> createState() => _ValuePlaceholderState();
}

class _ValuePlaceholderState extends State<_ValuePlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) => Container(
        height: 14,
        width: widget.wide ? double.infinity : 120,
        decoration: BoxDecoration(
          color: colorScheme.onSurface.withValues(alpha: _anim.value * 0.2),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}

class _AnalysisErrorCard extends StatelessWidget {
  const _AnalysisErrorCard({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: colorScheme.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'AI analysis failed. The scan will be saved without analysis.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onErrorContainer,
                ),
              ),
            ),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: TextStyle(color: colorScheme.onErrorContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
