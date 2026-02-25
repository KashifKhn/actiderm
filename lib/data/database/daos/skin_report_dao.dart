import 'package:drift/drift.dart';

import '../app_database.dart';

part 'skin_report_dao.g.dart';

@DriftAccessor(tables: [SkinReports])
class SkinReportDao extends DatabaseAccessor<AppDatabase>
    with _$SkinReportDaoMixin {
  SkinReportDao(super.db);

  Future<List<DbSkinReport>> getAllReports() => (select(
    skinReports,
  )..orderBy([(t) => OrderingTerm.desc(t.createdDate)])).get();

  Future<void> insertReport(SkinReportsCompanion report) =>
      into(skinReports).insert(report);

  Future<void> deleteReport(String id) =>
      (delete(skinReports)..where((t) => t.id.equals(id))).go();
}
