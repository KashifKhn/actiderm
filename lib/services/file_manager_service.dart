import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file_manager_service.g.dart';

class FileManagerService {
  late final Directory _baseDir;

  Future<void> initialize() async {
    final docs = await getApplicationDocumentsDirectory();
    _baseDir = Directory(p.join(docs.path, 'ActiDermData', 'Images'));
    if (!_baseDir.existsSync()) {
      await _baseDir.create(recursive: true);
    }
  }

  Future<String> savePhoto({
    required String spotId,
    required String photoId,
    required Uint8List bytes,
  }) async {
    final spotDir = Directory(p.join(_baseDir.path, spotId));
    if (!spotDir.existsSync()) {
      await spotDir.create(recursive: true);
    }
    final file = File(p.join(spotDir.path, '$photoId.jpg'));
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<Uint8List?> loadPhoto(String path) async {
    final file = File(path);
    if (!file.existsSync()) return null;
    return file.readAsBytes();
  }

  Future<void> deletePhoto(String path) async {
    final file = File(path);
    if (file.existsSync()) await file.delete();
  }

  Future<void> deleteSpotFolder(String spotId) async {
    final spotDir = Directory(p.join(_baseDir.path, spotId));
    if (spotDir.existsSync()) await spotDir.delete(recursive: true);
  }

  Future<String> savePdf({
    required String reportId,
    required Uint8List bytes,
  }) async {
    final docs = await getApplicationDocumentsDirectory();
    final reportsDir = Directory(p.join(docs.path, 'ActiDermData', 'Reports'));
    if (!reportsDir.existsSync()) {
      await reportsDir.create(recursive: true);
    }
    final file = File(p.join(reportsDir.path, '$reportId.pdf'));
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<void> deletePdf(String path) async {
    final file = File(path);
    if (file.existsSync()) await file.delete();
  }
}

@Riverpod(keepAlive: true)
FileManagerService fileManagerService(Ref ref) {
  throw UnimplementedError('Override in main.dart');
}
