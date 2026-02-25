import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/body_part.dart';
import '../../../data/models/skin_spot.dart';
import '../../../services/skin_spot_service.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/sheet_title.dart';

class EditScanSheet extends ConsumerStatefulWidget {
  const EditScanSheet({super.key, required this.spot});

  final SkinSpot spot;

  @override
  ConsumerState<EditScanSheet> createState() => _EditScanSheetState();
}

class _EditScanSheetState extends ConsumerState<EditScanSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _notesController;
  late BodyPart _selectedBodyPart;
  BodySubPart? _selectedSubPart;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.spot.title);
    _notesController = TextEditingController(text: widget.spot.notes ?? '');
    _selectedBodyPart = widget.spot.bodyPart;
    _selectedSubPart = widget.spot.subPart;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    setState(() => _saving = true);
    try {
      final updated = widget.spot.copyWith(
        title: title,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        bodyPart: _selectedBodyPart,
        subPart: _selectedSubPart,
        lastModified: DateTime.now(),
      );
      await ref.read(skinSpotServiceProvider.notifier).updateSkinSpot(updated);
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final subParts = _selectedBodyPart.subParts;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetTitle(title: 'Edit Scan'),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _titleController,
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _notesController,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Notes (optional)',
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<BodyPart>(
                      value: _selectedBodyPart,
                      decoration: const InputDecoration(labelText: 'Body Area'),
                      items: BodyPart.values
                          .map(
                            (bp) => DropdownMenuItem(
                              value: bp,
                              child: Text(bp.displayName),
                            ),
                          )
                          .toList(),
                      onChanged: (bp) {
                        if (bp == null) return;
                        setState(() {
                          _selectedBodyPart = bp;
                          _selectedSubPart = null;
                        });
                      },
                    ),
                    if (subParts.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      DropdownButtonFormField<BodySubPart?>(
                        value: _selectedSubPart,
                        decoration: const InputDecoration(
                          labelText: 'Sub-Area (optional)',
                        ),
                        items: [
                          DropdownMenuItem<BodySubPart?>(
                            value: null,
                            child: Text(
                              'Whole ${_selectedBodyPart.displayName}',
                            ),
                          ),
                          ...subParts.map(
                            (sp) => DropdownMenuItem<BodySubPart?>(
                              value: sp,
                              child: Text(sp.displayName),
                            ),
                          ),
                        ],
                        onChanged: (sp) =>
                            setState(() => _selectedSubPart = sp),
                      ),
                    ],
                    if (widget.spot.analysisRecord != null) ...[
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'AI Analysis (read-only)',
                            style: textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _AnalysisRow(
                              label: 'Type',
                              value: widget
                                  .spot
                                  .analysisRecord!
                                  .analysis
                                  .lesionType,
                              textTheme: textTheme,
                              colorScheme: colorScheme,
                            ),
                            _AnalysisRow(
                              label: 'Color',
                              value: widget.spot.analysisRecord!.analysis.color,
                              textTheme: textTheme,
                              colorScheme: colorScheme,
                            ),
                            _AnalysisRow(
                              label: 'Symmetry',
                              value:
                                  widget.spot.analysisRecord!.analysis.symmetry,
                              textTheme: textTheme,
                              colorScheme: colorScheme,
                            ),
                            _AnalysisRow(
                              label: 'Summary',
                              value:
                                  widget.spot.analysisRecord!.analysis.summary,
                              textTheme: textTheme,
                              colorScheme: colorScheme,
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    AppButton(
                      label: 'Save Changes',
                      onPressed: _saving ? null : _save,
                      isLoading: _saving,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalysisRow extends StatelessWidget {
  const _AnalysisRow({
    required this.label,
    required this.value,
    required this.textTheme,
    required this.colorScheme,
  });

  final String label;
  final String value;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value, style: textTheme.bodySmall)),
        ],
      ),
    );
  }
}
