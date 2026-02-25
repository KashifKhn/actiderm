import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/skin_report.dart';
import '../../../services/pdf_report_service.dart';
import '../../../shared/extensions/date_extensions.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(pdfReportServiceProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Reports'), leading: const BackButton()),
      body: reports.isEmpty
          ? _EmptyState(textTheme: textTheme, colorScheme: colorScheme)
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: reports.length,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
              itemBuilder: (context, i) => _ReportTile(report: reports[i]),
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.textTheme, required this.colorScheme});

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 64,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text('No Reports Yet', style: textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            'Generate a PDF report from any scan detail.',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ReportTile extends ConsumerWidget {
  const _ReportTile({required this.report});

  final SkinReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.picture_as_pdf_outlined,
          color: colorScheme.onPrimaryContainer,
          size: 22,
        ),
      ),
      title: Text(
        report.reportId,
        style: textTheme.titleMedium?.copyWith(fontSize: 14),
      ),
      subtitle: Text(
        '${report.createdDate.shortDate} · '
        '${report.totalScans} scan${report.totalScans == 1 ? '' : 's'}, '
        '${report.totalPhotos} photo${report.totalPhotos == 1 ? '' : 's'}',
        style: textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.go('/settings/reports/${report.reportId}'),
    );
  }
}
