import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/database/app_database.dart';
import '../data/models/body_part.dart';
import '../data/models/skin_analysis.dart';
import '../data/models/skin_lesion_record.dart';
import '../data/models/skin_spot.dart';
import '../shared/extensions/date_extensions.dart';
import 'file_manager_service.dart';

part 'skin_spot_service.g.dart';

@Riverpod(keepAlive: true)
class SkinSpotService extends _$SkinSpotService {
  @override
  Map<String, List<SkinSpot>> build() {
    _loadFromDatabase();
    return {};
  }

  AppDatabase get _db => ref.read(appDatabaseProvider);
  FileManagerService get _fileManager => ref.read(fileManagerServiceProvider);

  Future<void> _loadFromDatabase() async {
    final dbSpots = await _db.skinSpotDao.getAllSpots();
    final Map<String, List<SkinSpot>> result = {};

    for (final dbSpot in dbSpots) {
      final dbPhotos = await _db.skinSpotDao.getPhotosForSpot(dbSpot.id);
      final dbRecord = await _db.skinSpotDao.getRecordForSpot(dbSpot.id);

      final bodyPart = BodyPart.values.byName(dbSpot.bodyPart);
      final subPart = dbSpot.subPart != null
          ? BodySubPart.values.byName(dbSpot.subPart!)
          : null;

      final photos = dbPhotos
          .map(
            (p) => SkinSpotPhoto(
              id: p.id,
              imagePath: p.imagePath,
              dateTaken: p.dateTaken,
              notes: p.notes,
            ),
          )
          .toList();

      SkinLesionRecord? analysisRecord;
      if (dbRecord != null) {
        analysisRecord = SkinLesionRecord(
          id: dbRecord.id,
          imagePath: dbRecord.imagePath,
          timestamp: dbRecord.timestamp,
          latency: dbRecord.latency,
          analysis: SkinAnalysis(
            lesionType: dbRecord.lesionType,
            color: dbRecord.color,
            symmetry: dbRecord.symmetry,
            borders: dbRecord.borders,
            texture: dbRecord.texture,
            summary: dbRecord.summary,
          ),
        );
      }

      final spot = SkinSpot(
        id: dbSpot.id,
        title: dbSpot.title,
        notes: dbSpot.notes,
        photos: photos,
        createdDate: dbSpot.createdDate,
        lastModified: dbSpot.lastModified,
        bodyPart: bodyPart,
        subPart: subPart,
        analysisRecord: analysisRecord,
      );

      final key = makeBodyKey(bodyPart: bodyPart, subPart: subPart);
      result.putIfAbsent(key, () => []).add(spot);
    }

    state = result;
  }

  Future<void> addSkinSpot({
    required SkinSpot spot,
    required BodyPart bodyPart,
    BodySubPart? subPart,
    Uint8List? imageBytes,
  }) async {
    await _db.skinSpotDao.insertSpot(
      SkinSpotsCompanion.insert(
        id: spot.id,
        title: spot.title,
        notes: Value(spot.notes),
        createdDate: spot.createdDate,
        lastModified: spot.lastModified,
        bodyPart: bodyPart.name,
        subPart: Value(subPart?.name),
      ),
    );

    for (final photo in spot.photos) {
      String? savedPath = photo.imagePath;
      if (imageBytes != null && savedPath == null) {
        savedPath = await _fileManager.savePhoto(
          spotId: spot.id,
          photoId: photo.id,
          bytes: imageBytes,
        );
      }
      await _db.skinSpotDao.insertPhoto(
        SkinSpotPhotosCompanion.insert(
          id: photo.id,
          spotId: spot.id,
          imagePath: Value(savedPath),
          dateTaken: photo.dateTaken,
          notes: Value(photo.notes),
        ),
      );
    }

    if (spot.analysisRecord != null) {
      final record = spot.analysisRecord!;
      await _db.skinSpotDao.insertRecord(
        SkinLesionRecordsCompanion.insert(
          id: record.id,
          spotId: spot.id,
          imagePath: record.imagePath,
          timestamp: record.timestamp,
          latency: Value(record.latency),
          lesionType: record.analysis.lesionType,
          color: record.analysis.color,
          symmetry: record.analysis.symmetry,
          borders: record.analysis.borders,
          texture: record.analysis.texture,
          summary: record.analysis.summary,
        ),
      );
    }

    await _updateBodyPartStatus(bodyPart: bodyPart, subPart: subPart);

    final key = makeBodyKey(bodyPart: bodyPart, subPart: subPart);
    final updated = Map<String, List<SkinSpot>>.from(state);
    updated.putIfAbsent(key, () => []).add(spot);
    state = updated;
  }

  Future<void> updateSkinSpot(SkinSpot spot) async {
    await _db.skinSpotDao.updateSpot(
      SkinSpotsCompanion(
        id: Value(spot.id),
        title: Value(spot.title),
        notes: Value(spot.notes),
        lastModified: Value(spot.lastModified),
        bodyPart: Value(spot.bodyPart.name),
        subPart: Value(spot.subPart?.name),
      ),
    );

    final key = makeBodyKey(bodyPart: spot.bodyPart, subPart: spot.subPart);
    final updated = Map<String, List<SkinSpot>>.from(state);
    final list = List<SkinSpot>.from(updated[key] ?? []);
    final index = list.indexWhere((s) => s.id == spot.id);
    if (index >= 0) {
      list[index] = spot;
      updated[key] = list;
    }
    state = updated;
  }

  Future<void> deleteSkinSpot(SkinSpot spot) async {
    await _db.skinSpotDao.deleteSpot(spot.id);
    await _fileManager.deleteSpotFolder(spot.id);

    final key = makeBodyKey(bodyPart: spot.bodyPart, subPart: spot.subPart);
    final updated = Map<String, List<SkinSpot>>.from(state);
    final list = List<SkinSpot>.from(updated[key] ?? []);
    list.removeWhere((s) => s.id == spot.id);
    if (list.isEmpty) {
      updated.remove(key);
    } else {
      updated[key] = list;
    }
    state = updated;

    await _updateBodyPartStatus(bodyPart: spot.bodyPart, subPart: spot.subPart);
  }

  Future<void> addPhotoToSpot({
    required String spotId,
    required SkinSpotPhoto photo,
    required BodyPart bodyPart,
    BodySubPart? subPart,
    Uint8List? imageBytes,
  }) async {
    String? savedPath = photo.imagePath;
    if (imageBytes != null) {
      savedPath = await _fileManager.savePhoto(
        spotId: spotId,
        photoId: photo.id,
        bytes: imageBytes,
      );
    }

    final photoWithPath = photo.copyWith(imagePath: savedPath);

    await _db.skinSpotDao.insertPhoto(
      SkinSpotPhotosCompanion.insert(
        id: photoWithPath.id,
        spotId: spotId,
        imagePath: Value(photoWithPath.imagePath),
        dateTaken: photoWithPath.dateTaken,
        notes: Value(photoWithPath.notes),
      ),
    );

    final key = makeBodyKey(bodyPart: bodyPart, subPart: subPart);
    final updated = Map<String, List<SkinSpot>>.from(state);
    final list = List<SkinSpot>.from(updated[key] ?? []);
    final index = list.indexWhere((s) => s.id == spotId);
    if (index >= 0) {
      final spot = list[index];
      list[index] = spot.copyWith(
        photos: [...spot.photos, photoWithPath],
        lastModified: DateTime.now(),
      );
      updated[key] = list;
    }
    state = updated;

    await _updateBodyPartStatus(bodyPart: bodyPart, subPart: subPart);
  }

  Future<void> _updateBodyPartStatus({
    required BodyPart bodyPart,
    BodySubPart? subPart,
  }) async {
    final key = makeBodyKey(bodyPart: bodyPart, subPart: subPart);
    final spots = state[key] ?? [];
    final photoCount = spots.fold<int>(0, (sum, s) => sum + s.photos.length);
    final lastScanned = spots.isNotEmpty
        ? spots
              .map((s) => s.lastModified)
              .reduce((a, b) => a.isAfter(b) ? a : b)
        : null;

    await _db.bodyPartStatusDao.upsertStatus(
      BodyPartStatusesCompanion.insert(
        id: key,
        bodyPart: bodyPart.name,
        subPart: Value(subPart?.name),
        scanStatus: photoCount > 0 ? 'scanned' : 'notScanned',
        photoCount: Value(photoCount),
        lastScanned: Value(lastScanned),
      ),
    );
  }

  List<SkinSpot> spotsForKey(String key) => state[key] ?? [];

  List<SkinSpot> spotsForBodyPart(BodyPart bodyPart) {
    final result = <SkinSpot>[];
    for (final subPart in bodyPart.subParts) {
      final key = makeBodyKey(bodyPart: bodyPart, subPart: subPart);
      result.addAll(state[key] ?? []);
    }
    final topKey = makeBodyKey(bodyPart: bodyPart);
    result.addAll(state[topKey] ?? []);
    return result;
  }

  List<SkinSpot> get allSpots => state.values.expand((list) => list).toList();

  int get totalPhotoCount =>
      allSpots.fold<int>(0, (sum, s) => sum + s.photos.length);

  int get scannedTopLevelBodyPartsCount =>
      BodyPart.values.where((bp) => spotsForBodyPart(bp).isNotEmpty).length;

  double get completionPercentage {
    final total = BodyPart.values.length;
    if (total == 0) return 0.0;
    return scannedTopLevelBodyPartsCount / total;
  }

  int get totalAnalysisCount =>
      allSpots.where((s) => s.analysisRecord != null).length;

  int get needsUpdateCount => BodyPart.values.where((bp) {
    final spots = spotsForBodyPart(bp);
    if (spots.isEmpty) return false;
    final lastModified = spots
        .map((s) => s.lastModified)
        .reduce((a, b) => a.isAfter(b) ? a : b);
    return lastModified.isOlderThan30Days;
  }).length;
}
