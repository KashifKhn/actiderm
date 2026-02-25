import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/skin_analysis.dart';
import 'model_state.dart';

part 'ai_model_service.g.dart';

@Riverpod(keepAlive: true)
class AiModelService extends _$AiModelService {
  InferenceModel? _model;
  Timer? _unloadTimer;

  static const int _autoUnloadSeconds = 120;
  static const String _prompt = 'skin extract';

  @override
  ModelState build() => const Idle();

  Future<void> downloadModel({
    required String url,
    required void Function(double progress) onProgress,
  }) async {
    state = const Downloading(0.0);
    try {
      await FlutterGemma.installModel(
        modelType: ModelType.gemmaIt,
      ).fromNetwork(url).withProgress((int progress) {
        final fraction = progress / 100.0;
        state = Downloading(fraction);
        onProgress(fraction);
      }).install();
      state = const Idle();
    } catch (e) {
      state = Failed(_sanitize(e));
    }
  }

  Future<void> loadModel() async {
    if (state is Ready || state is Loading) return;
    state = const Loading();
    try {
      _model = await FlutterGemma.getActiveModel(
        maxTokens: 2048,
        preferredBackend: PreferredBackend.gpu,
      );
      state = const Ready();
    } catch (e) {
      state = Failed(_sanitize(e));
    }
  }

  Future<SkinAnalysis?> analyzeSkinImageStructured(Uint8List imageBytes) async {
    final model = _model;
    if (model == null || state is! Ready) return null;

    _cancelUnloadTimer();
    state = const Generating();

    try {
      final session = await model.createSession(
        temperature: 0.1,
        topK: 1,
        randomSeed: 42,
        enableVisionModality: true,
      );
      try {
        await session.addQueryChunk(
          Message.withImage(
            text: _prompt,
            imageBytes: imageBytes,
            isUser: true,
          ),
        );
        final response = await session.getResponse();
        state = const Ready();
        _scheduleUnload();
        return _parseAnalysis(response);
      } finally {
        await session.close();
      }
    } catch (e) {
      state = Failed(_sanitize(e));
      return null;
    }
  }

  Stream<String> analyzeStreamingTokens(Uint8List imageBytes) async* {
    final model = _model;
    if (model == null) return;

    _cancelUnloadTimer();
    state = const Generating();

    try {
      final session = await model.createSession(
        temperature: 0.1,
        topK: 1,
        randomSeed: 42,
        enableVisionModality: true,
      );
      try {
        await session.addQueryChunk(
          Message.withImage(
            text: _prompt,
            imageBytes: imageBytes,
            isUser: true,
          ),
        );
        final response = await session.getResponse();
        const chunkSize = 6;
        for (int i = 0; i < response.length; i += chunkSize) {
          final end = (i + chunkSize).clamp(0, response.length);
          yield response.substring(i, end);
          await Future<void>.delayed(const Duration(milliseconds: 18));
        }
        state = const Ready();
        _scheduleUnload();
      } finally {
        await session.close();
      }
    } catch (e) {
      state = Failed(_sanitize(e));
    }
  }

  Future<bool> isModelInstalled() async {
    try {
      final model = await FlutterGemma.getActiveModel(maxTokens: 256);
      await model.close();
      return true;
    } catch (_) {
      return false;
    }
  }

  void _scheduleUnload() {
    _unloadTimer = Timer(
      const Duration(seconds: _autoUnloadSeconds),
      () async => _unload(),
    );
  }

  void _cancelUnloadTimer() {
    _unloadTimer?.cancel();
    _unloadTimer = null;
  }

  Future<void> _unload() async {
    await _model?.close();
    _model = null;
    state = const Idle();
  }

  SkinAnalysis? _parseAnalysis(String raw) {
    final cleaned = raw
        .replaceAll(RegExp(r'```json\s*'), '')
        .replaceAll(RegExp(r'```\s*'), '')
        .trim();
    try {
      final Map<String, dynamic> json =
          jsonDecode(cleaned) as Map<String, dynamic>;
      return SkinAnalysis.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  bool get isReady => state is Ready;

  String _sanitize(Object e) => e
      .toString()
      .split('\n')
      .first
      .replaceFirst(RegExp(r'^.*?:\s*'), '')
      .trim();
}
