import 'package:drift/drift.dart';

import '../app_database.dart';

part 'body_part_status_dao.g.dart';

@DriftAccessor(tables: [BodyPartStatuses])
class BodyPartStatusDao extends DatabaseAccessor<AppDatabase>
    with _$BodyPartStatusDaoMixin {
  BodyPartStatusDao(super.db);

  Future<List<DbBodyPartStatus>> getAllStatuses() =>
      select(bodyPartStatuses).get();

  Future<void> upsertStatus(BodyPartStatusesCompanion status) =>
      into(bodyPartStatuses).insertOnConflictUpdate(status);

  Future<void> deleteStatus(String id) =>
      (delete(bodyPartStatuses)..where((t) => t.id.equals(id))).go();
}
