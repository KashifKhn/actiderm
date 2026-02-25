import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'daos/body_part_status_dao.dart';
import 'daos/skin_report_dao.dart';
import 'daos/skin_spot_dao.dart';

part 'app_database.g.dart';

@DataClassName('DbSkinSpot')
class SkinSpots extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdDate => dateTime()();
  DateTimeColumn get lastModified => dateTime()();
  TextColumn get bodyPart => text()();
  TextColumn get subPart => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DbSkinSpotPhoto')
class SkinSpotPhotos extends Table {
  TextColumn get id => text()();
  TextColumn get spotId =>
      text().references(SkinSpots, #id, onDelete: KeyAction.cascade)();
  TextColumn get imagePath => text().nullable()();
  DateTimeColumn get dateTaken => dateTime()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DbSkinLesionRecord')
class SkinLesionRecords extends Table {
  TextColumn get id => text()();
  TextColumn get spotId =>
      text().references(SkinSpots, #id, onDelete: KeyAction.cascade)();
  TextColumn get imagePath => text()();
  TextColumn get timestamp => text()();
  TextColumn get latency => text().nullable()();
  TextColumn get lesionType => text()();
  TextColumn get color => text()();
  TextColumn get symmetry => text()();
  TextColumn get borders => text()();
  TextColumn get texture => text()();
  TextColumn get summary => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DbBodyPartStatus')
class BodyPartStatuses extends Table {
  TextColumn get id => text()();
  TextColumn get bodyPart => text()();
  TextColumn get subPart => text().nullable()();
  TextColumn get scanStatus => text()();
  IntColumn get photoCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastScanned => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DbSkinReport')
class SkinReports extends Table {
  TextColumn get id => text()();
  TextColumn get reportId => text()();
  DateTimeColumn get createdDate => dateTime()();
  TextColumn get pdfPath => text()();
  TextColumn get filterBodyPart => text().nullable()();
  DateTimeColumn get dateRangeStart => dateTime().nullable()();
  DateTimeColumn get dateRangeEnd => dateTime().nullable()();
  IntColumn get totalPhotos => integer().withDefault(const Constant(0))();
  IntColumn get totalScans => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    SkinSpots,
    SkinSpotPhotos,
    SkinLesionRecords,
    BodyPartStatuses,
    SkinReports,
  ],
  daos: [SkinSpotDao, BodyPartStatusDao, SkinReportDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'actiderm.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  throw UnimplementedError('Override in main.dart');
}
