import 'package:drift/drift.dart';

import '../app_database.dart';

part 'skin_spot_dao.g.dart';

@DriftAccessor(tables: [SkinSpots, SkinSpotPhotos, SkinLesionRecords])
class SkinSpotDao extends DatabaseAccessor<AppDatabase>
    with _$SkinSpotDaoMixin {
  SkinSpotDao(super.db);

  Future<List<DbSkinSpot>> getAllSpots() => select(skinSpots).get();

  Future<List<DbSkinSpotPhoto>> getPhotosForSpot(String spotId) =>
      (select(skinSpotPhotos)..where((t) => t.spotId.equals(spotId))).get();

  Future<DbSkinLesionRecord?> getRecordForSpot(String spotId) =>
      (select(skinLesionRecords)
            ..where((t) => t.spotId.equals(spotId))
            ..limit(1))
          .getSingleOrNull();

  Future<void> insertSpot(SkinSpotsCompanion spot) =>
      into(skinSpots).insert(spot);

  Future<void> insertPhoto(SkinSpotPhotosCompanion photo) =>
      into(skinSpotPhotos).insert(photo);

  Future<void> insertRecord(SkinLesionRecordsCompanion record) =>
      into(skinLesionRecords).insert(record);

  Future<void> updateSpot(SkinSpotsCompanion spot) =>
      (update(skinSpots)..where((t) => t.id.equals(spot.id.value))).write(spot);

  Future<void> deleteSpot(String spotId) =>
      (delete(skinSpots)..where((t) => t.id.equals(spotId))).go();
}
