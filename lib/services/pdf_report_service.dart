import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/database/app_database.dart';
import '../data/models/body_part.dart';
import '../data/models/skin_report.dart';
import '../data/models/skin_spot.dart';
import 'file_manager_service.dart';
import 'skin_spot_service.dart';

part 'pdf_report_service.g.dart';

@Riverpod(keepAlive: true)
class PdfReportService extends _$PdfReportService {
  @override
  List<SkinReport> build() {
    _loadReports();
    return [];
  }

  AppDatabase get _db => ref.read(appDatabaseProvider);
  FileManagerService get _fileManager => ref.read(fileManagerServiceProvider);

  Future<void> _loadReports() async {
    final dbReports = await _db.skinReportDao.getAllReports();
    state = dbReports.map(_mapReport).toList();
  }

  SkinReport _mapReport(DbSkinReport db) {
    return SkinReport(
      id: db.id,
      reportId: db.reportId,
      createdDate: db.createdDate,
      pdfPath: db.pdfPath,
      filterBodyPart: db.filterBodyPart != null
          ? BodyPart.values.byName(db.filterBodyPart!)
          : null,
      dateRangeStart: db.dateRangeStart,
      dateRangeEnd: db.dateRangeEnd,
      totalPhotos: db.totalPhotos,
      totalScans: db.totalScans,
    );
  }

  Future<SkinReport?> generateReport({
    BodyPart? filterBodyPart,
    DateTime? dateRangeStart,
    DateTime? dateRangeEnd,
  }) async {
    final allSpots = ref.read(skinSpotServiceProvider.notifier).allSpots;

    final filteredSpots = allSpots.where((spot) {
      if (filterBodyPart != null && spot.bodyPart != filterBodyPart) {
        return false;
      }
      if (dateRangeStart != null && spot.createdDate.isBefore(dateRangeStart)) {
        return false;
      }
      if (dateRangeEnd != null && spot.createdDate.isAfter(dateRangeEnd)) {
        return false;
      }
      return true;
    }).toList();

    if (filteredSpots.isEmpty) return null;

    final now = DateTime.now();
    final dateStr = DateFormat('yyyyMMdd').format(now);
    final seq = (state.length + 1).toString().padLeft(4, '0');
    final reportId = 'ACD-$dateStr-$seq';
    final id = '${now.millisecondsSinceEpoch}';

    final pdfBytes = await _buildPdf(
      reportId: reportId,
      spots: filteredSpots,
      filterBodyPart: filterBodyPart,
      dateRangeStart: dateRangeStart,
      dateRangeEnd: dateRangeEnd,
    );

    final pdfPath = await _fileManager.savePdf(
      reportId: reportId,
      bytes: pdfBytes,
    );

    final totalPhotos = filteredSpots.fold<int>(
      0,
      (sum, s) => sum + s.photos.length,
    );

    await _db.skinReportDao.insertReport(
      SkinReportsCompanion.insert(
        id: id,
        reportId: reportId,
        createdDate: now,
        pdfPath: pdfPath,
        filterBodyPart: Value(filterBodyPart?.name),
        dateRangeStart: Value(dateRangeStart),
        dateRangeEnd: Value(dateRangeEnd),
        totalPhotos: Value(totalPhotos),
        totalScans: Value(filteredSpots.length),
      ),
    );

    final report = SkinReport(
      id: id,
      reportId: reportId,
      createdDate: now,
      pdfPath: pdfPath,
      filterBodyPart: filterBodyPart,
      dateRangeStart: dateRangeStart,
      dateRangeEnd: dateRangeEnd,
      totalPhotos: totalPhotos,
      totalScans: filteredSpots.length,
    );

    state = [report, ...state];
    return report;
  }

  Future<void> deleteReport(SkinReport report) async {
    await _db.skinReportDao.deleteReport(report.id);
    await _fileManager.deletePdf(report.pdfPath);
    state = state.where((r) => r.id != report.id).toList();
  }

  Future<Uint8List> _buildPdf({
    required String reportId,
    required List<SkinSpot> spots,
    BodyPart? filterBodyPart,
    DateTime? dateRangeStart,
    DateTime? dateRangeEnd,
  }) async {
    final doc = pw.Document();
    final dateFormat = DateFormat('MMM d, yyyy');
    final now = DateTime.now();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(24),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#1B6B7B'),
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(12),
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'ActiDerm',
                      style: pw.TextStyle(
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Skin Tracking Report',
                      style: const pw.TextStyle(
                        fontSize: 16,
                        color: PdfColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),
              _pdfInfoRow('Report ID', reportId),
              _pdfInfoRow('Generated', dateFormat.format(now)),
              if (filterBodyPart != null)
                _pdfInfoRow('Body Part', filterBodyPart.displayName),
              if (dateRangeStart != null)
                _pdfInfoRow(
                  'Date Range',
                  '${dateFormat.format(dateRangeStart)} – '
                      '${dateRangeEnd != null ? dateFormat.format(dateRangeEnd) : 'Present'}',
                ),
              pw.SizedBox(height: 16),
              _pdfInfoRow('Total Scans', spots.length.toString()),
              _pdfInfoRow(
                'Total Photos',
                spots.fold<int>(0, (s, e) => s + e.photos.length).toString(),
              ),
            ],
          );
        },
      ),
    );

    final grouped = <BodyPart, List<SkinSpot>>{};
    for (final spot in spots) {
      grouped.putIfAbsent(spot.bodyPart, () => []).add(spot);
    }

    for (final entry in grouped.entries) {
      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return [
              pw.Text(
                entry.key.displayName,
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              pw.SizedBox(height: 8),
              ...entry.value.map((spot) => _buildSpotSection(spot, dateFormat)),
            ];
          },
        ),
      );
    }

    return doc.save();
  }

  pw.Widget _buildSpotSection(SkinSpot spot, DateFormat dateFormat) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 16),
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            spot.title,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          if (spot.subPart != null)
            pw.Text(
              spot.subPart!.displayName,
              style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey600),
            ),
          pw.SizedBox(height: 6),
          _pdfInfoRow('Photos', spot.photos.length.toString()),
          _pdfInfoRow('Created', dateFormat.format(spot.createdDate)),
          if (spot.notes != null && spot.notes!.isNotEmpty)
            _pdfInfoRow('Notes', spot.notes!),
          if (spot.analysisRecord != null) ...[
            pw.SizedBox(height: 6),
            pw.Text(
              'AI Analysis',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
            _pdfInfoRow('Type', spot.analysisRecord!.analysis.lesionType),
            _pdfInfoRow('Summary', spot.analysisRecord!.analysis.summary),
          ],
        ],
      ),
    );
  }

  pw.Widget _pdfInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 100,
            child: pw.Text(
              '$label:',
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.grey700,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(value, style: const pw.TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
