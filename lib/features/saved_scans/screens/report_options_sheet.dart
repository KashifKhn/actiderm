import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/body_part.dart';
import '../../../data/models/skin_report.dart';
import '../../../data/models/skin_spot.dart';
import '../../../services/pdf_report_service.dart';
import '../../../services/skin_spot_service.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/sheet_title.dart';

class ReportOptionsSheet extends ConsumerStatefulWidget {
  const ReportOptionsSheet({super.key, required this.initialBodyPart});

  final BodyPart? initialBodyPart;

  @override
  ConsumerState<ReportOptionsSheet> createState() => _ReportOptionsSheetState();
}

class _ReportOptionsSheetState extends ConsumerState<ReportOptionsSheet> {
  late ScanFilter _selectedFilter;
  bool _useDateRange = false;
  late DateTime _startDate;
  late DateTime _endDate;
  bool _generating = false;
  bool _showConfirmation = false;
  SkinReport? _savedReport;

  @override
  void initState() {
    super.initState();
    _selectedFilter = ScanFilter.fromBodyPart(widget.initialBodyPart);
    _endDate = DateTime.now();
    _startDate = DateTime(_endDate.year, _endDate.month - 3, _endDate.day);
  }

  List<SkinSpot> get _matchingSpots {
    final service = ref.read(skinSpotServiceProvider.notifier);
    var spots = service.allSpots;
    final bodyParts = _selectedFilter.bodyParts;
    if (bodyParts != null) {
      spots = spots.where((s) => bodyParts.contains(s.bodyPart)).toList();
    }
    if (_useDateRange) {
      final lo = _startDate.isBefore(_endDate) ? _startDate : _endDate;
      final hi = _startDate.isAfter(_endDate) ? _startDate : _endDate;
      spots = spots
          .where(
            (s) => !s.createdDate.isBefore(lo) && !s.createdDate.isAfter(hi),
          )
          .toList();
    }
    return spots;
  }

  int get _totalPhotos =>
      _matchingSpots.fold(0, (sum, s) => sum + s.photos.length);

  Future<void> _generate() async {
    setState(() => _generating = true);
    try {
      final lo = _useDateRange
          ? (_startDate.isBefore(_endDate) ? _startDate : _endDate)
          : null;
      final hi = _useDateRange
          ? (_startDate.isAfter(_endDate) ? _startDate : _endDate)
          : null;

      final report = await ref
          .read(pdfReportServiceProvider.notifier)
          .generateReport(
            filterBodyPart: _selectedFilter.bodyParts?.firstOrNull,
            dateRangeStart: lo,
            dateRangeEnd: hi,
          );
      if (mounted) {
        setState(() {
          _generating = false;
          _savedReport = report;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _generating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final matching = _matchingSpots;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: _savedReport != null
            ? _SavedPane(
                report: _savedReport!,
                onDone: () => Navigator.of(context).pop(),
              )
            : _showConfirmation
            ? _ConfirmationPane(
                matchingCount: matching.length,
                totalPhotos: _totalPhotos,
                generating: _generating,
                onConfirm: _generate,
                onCancel: () => setState(() => _showConfirmation = false),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SheetTitle(title: 'Generate Report'),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Body Area', style: textTheme.titleSmall),
                          const SizedBox(height: 8),
                          _FilterChips(
                            selected: _selectedFilter,
                            onChanged: (f) =>
                                setState(() => _selectedFilter = f),
                          ),
                          const SizedBox(height: 20),
                          _DateRangeSection(
                            useDateRange: _useDateRange,
                            startDate: _startDate,
                            endDate: _endDate,
                            onToggle: (v) => setState(() => _useDateRange = v),
                            onStartChanged: (d) =>
                                setState(() => _startDate = d),
                            onEndChanged: (d) => setState(() => _endDate = d),
                          ),
                          const SizedBox(height: 20),
                          _SummaryRow(
                            label: 'Scans included',
                            value: '${matching.length}',
                            valueColor: matching.isEmpty
                                ? colorScheme.error
                                : colorScheme.onSurface,
                          ),
                          const SizedBox(height: 4),
                          _SummaryRow(
                            label: 'Total photos',
                            value: '$_totalPhotos',
                            valueColor: colorScheme.onSurface,
                          ),
                          const SizedBox(height: 20),
                          AppButton(
                            label: 'Save Report to Device',
                            onPressed: matching.isEmpty
                                ? null
                                : () =>
                                      setState(() => _showConfirmation = true),
                          ),
                          const SizedBox(height: 8),
                          AppButton(
                            label: 'Cancel',
                            onPressed: () => Navigator.of(context).pop(),
                            outlined: true,
                          ),
                          const SizedBox(height: 8),
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

class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.selected, required this.onChanged});

  final ScanFilter selected;
  final void Function(ScanFilter) onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ScanFilter.values
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _FilterChip(
                  label: f.displayName,
                  isSelected: selected == f,
                  onTap: () => onChanged(f),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : colorScheme.outline,
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isSelected
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _DateRangeSection extends StatelessWidget {
  const _DateRangeSection({
    required this.useDateRange,
    required this.startDate,
    required this.endDate,
    required this.onToggle,
    required this.onStartChanged,
    required this.onEndChanged,
  });

  final bool useDateRange;
  final DateTime startDate;
  final DateTime endDate;
  final void Function(bool) onToggle;
  final void Function(DateTime) onStartChanged;
  final void Function(DateTime) onEndChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SwitchListTile(
            title: Text('Filter by date range', style: textTheme.bodyMedium),
            value: useDateRange,
            onChanged: onToggle,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          if (useDateRange) ...[
            const Divider(height: 1),
            _DateRow(
              label: 'From',
              date: startDate,
              firstDate: DateTime(2020),
              lastDate: endDate,
              onChanged: onStartChanged,
            ),
            const Divider(height: 1),
            _DateRow(
              label: 'To',
              date: endDate,
              firstDate: startDate,
              lastDate: DateTime.now(),
              onChanged: onEndChanged,
            ),
          ],
        ],
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.label,
    required this.date,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
  });

  final String label;
  final DateTime date;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime) onChanged;

  Future<void> _pick(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final formatted =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';

    return ListTile(
      title: Text(label, style: textTheme.bodyMedium),
      trailing: TextButton(
        onPressed: () => _pick(context),
        child: Text(
          formatted,
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _ConfirmationPane extends StatelessWidget {
  const _ConfirmationPane({
    required this.matchingCount,
    required this.totalPhotos,
    required this.generating,
    required this.onConfirm,
    required this.onCancel,
  });

  final int matchingCount;
  final int totalPhotos;
  final bool generating;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Save Report to Device?',
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'A PDF skin examination report will be generated for '
            '$matchingCount scan${matchingCount == 1 ? '' : 's'} '
            'and $totalPhotos photo${totalPhotos == 1 ? '' : 's'} '
            'and saved to your device. This report is not a medical '
            'diagnosis.',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Save',
            onPressed: generating ? null : onConfirm,
            isLoading: generating,
          ),
          const SizedBox(height: 8),
          AppButton(
            label: 'Cancel',
            onPressed: generating ? null : onCancel,
            outlined: true,
          ),
        ],
      ),
    );
  }
}

class _SavedPane extends StatelessWidget {
  const _SavedPane({required this.report, required this.onDone});

  final SkinReport report;
  final VoidCallback onDone;

  Future<void> _share() async {
    await Share.shareXFiles([
      XFile(report.pdfPath),
    ], subject: 'ActiDerm Report ${report.reportId}');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 48,
            color: Color(0xFF16A34A),
          ),
          const SizedBox(height: 12),
          Text(
            'Report Saved',
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            report.reportId,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AppButton(label: 'Share Report', onPressed: _share),
          const SizedBox(height: 8),
          AppButton(label: 'Done', onPressed: onDone, outlined: true),
        ],
      ),
    );
  }
}
