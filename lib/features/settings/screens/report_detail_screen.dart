import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/skin_report.dart';
import '../../../services/pdf_report_service.dart';
import '../../../shared/extensions/date_extensions.dart';
import '../../../shared/widgets/app_button.dart';

class ReportDetailScreen extends ConsumerStatefulWidget {
  const ReportDetailScreen({super.key, required this.reportId});

  final String reportId;

  @override
  ConsumerState<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends ConsumerState<ReportDetailScreen> {
  PdfControllerPinch? _pdfController;
  bool _pdfLoaded = false;

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  void _initPdfController(String pdfPath) {
    if (_pdfLoaded) return;
    final file = File(pdfPath);
    if (!file.existsSync()) return;
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openFile(pdfPath),
    );
    _pdfLoaded = true;
  }

  Future<void> _shareReport(String pdfPath) async {
    final file = File(pdfPath);
    if (!file.existsSync()) return;
    await Share.shareXFiles([
      XFile(pdfPath, mimeType: 'application/pdf'),
    ], subject: 'ActiDerm Skin Report');
  }

  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(pdfReportServiceProvider);
    final report = reports
        .where((r) => r.reportId == widget.reportId)
        .firstOrNull;

    if (report == null) {
      return Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: const Center(child: Text('Report not found')),
      );
    }

    _initPdfController(report.pdfPath);

    final fileExists = File(report.pdfPath).existsSync();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(report.reportId),
        leading: const BackButton(),
        actions: [
          if (fileExists)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              tooltip: 'Share',
              onPressed: () => _shareReport(report.pdfPath),
            ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, report),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ReportHeader(report: report),
                  const SizedBox(height: 24),
                  Text('Details', style: textTheme.titleMedium),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'Report ID', value: report.reportId),
                  _InfoRow(
                    label: 'Generated',
                    value: report.createdDate.shortDate,
                  ),
                  if (report.filterBodyPart != null)
                    _InfoRow(
                      label: 'Body Area',
                      value: report.filterBodyPart!.displayName,
                    ),
                  if (report.dateRangeStart != null)
                    _InfoRow(
                      label: 'Date Range',
                      value:
                          '${report.dateRangeStart!.shortDate}'
                          ' – '
                          '${report.dateRangeEnd?.shortDate ?? 'Present'}',
                    ),
                  _InfoRow(
                    label: 'Total Scans',
                    value: report.totalScans.toString(),
                  ),
                  _InfoRow(
                    label: 'Total Photos',
                    value: report.totalPhotos.toString(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          if (_pdfController != null && fileExists)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PDF Preview', style: textTheme.titleMedium),
                    const SizedBox(height: 12),
                    _PdfViewer(controller: _pdfController!),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          if (!fileExists)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _PdfNotFoundCard(),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: AppButton(
                label: 'Delete Report',
                onPressed: () => _confirmDelete(context, report),
                isDestructive: true,
                outlined: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, SkinReport report) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Report'),
        content: Text('Delete "${report.reportId}"? This cannot be undone.'),
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
      await ref.read(pdfReportServiceProvider.notifier).deleteReport(report);
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}

class _PdfViewer extends StatelessWidget {
  const _PdfViewer({required this.controller});

  final PdfControllerPinch controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 520,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: PdfViewPinch(
          controller: controller,
          scrollDirection: Axis.vertical,
          builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
            options: const DefaultBuilderOptions(),
            documentLoaderBuilder: (_) =>
                const Center(child: CircularProgressIndicator()),
            pageLoaderBuilder: (_) =>
                const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class _PdfNotFoundCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colorScheme.onErrorContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'PDF file not found on this device.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportHeader extends StatelessWidget {
  const _ReportHeader({required this.report});

  final SkinReport report;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B6B7B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.picture_as_pdf_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.reportId,
                  style: textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  '${report.totalScans} scan'
                  '${report.totalScans == 1 ? '' : 's'}'
                  ' · ${report.totalPhotos} photo'
                  '${report.totalPhotos == 1 ? '' : 's'}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value, style: textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
