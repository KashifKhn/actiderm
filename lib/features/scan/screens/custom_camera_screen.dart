import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/body_part.dart';

class CustomCameraScreen extends StatefulWidget {
  const CustomCameraScreen({super.key, required this.bodyPart, this.subPart});

  final BodyPart bodyPart;
  final BodySubPart? subPart;

  @override
  State<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends State<CustomCameraScreen>
    with WidgetsBindingObserver {
  List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = 0;
  FlashMode _flashMode = FlashMode.off;
  bool _initialising = true;
  bool _capturing = false;
  Uint8List? _capturedBytes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCameras();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initController(_cameras[_cameraIndex]);
    }
  }

  Future<void> _initCameras() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        if (mounted) setState(() => _initialising = false);
        return;
      }
      final backIndex = _cameras.indexWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
      );
      _cameraIndex = backIndex >= 0 ? backIndex : 0;
      await _initController(_cameras[_cameraIndex]);
    } catch (_) {
      if (mounted) setState(() => _initialising = false);
    }
  }

  Future<void> _initController(CameraDescription camera) async {
    final old = _controller;
    if (old != null) {
      await old.dispose();
    }
    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _controller = controller;
    try {
      await controller.initialize();
      await controller.setFlashMode(_flashMode);
      if (mounted) setState(() => _initialising = false);
    } catch (_) {
      if (mounted) setState(() => _initialising = false);
    }
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || _capturing) {
      return;
    }
    setState(() => _capturing = true);
    try {
      final file = await controller.takePicture();
      final bytes = await file.readAsBytes();
      if (mounted) setState(() => _capturedBytes = bytes);
    } catch (_) {
      // capture failed silently — user can retry
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  Future<void> _flipCamera() async {
    if (_cameras.length < 2) return;
    final nextIndex = (_cameraIndex + 1) % _cameras.length;
    setState(() {
      _cameraIndex = nextIndex;
      _initialising = true;
    });
    await _initController(_cameras[nextIndex]);
  }

  Future<void> _cycleFlash() async {
    final next = switch (_flashMode) {
      FlashMode.off => FlashMode.auto,
      FlashMode.auto => FlashMode.always,
      FlashMode.always => FlashMode.off,
      _ => FlashMode.off,
    };
    setState(() => _flashMode = next);
    await _controller?.setFlashMode(next);
  }

  void _retake() {
    setState(() => _capturedBytes = null);
  }

  void _usePhoto() {
    final bytes = _capturedBytes;
    if (bytes == null) return;
    context.go(
      '/add-scan/review',
      extra: {
        'bodyPart': widget.bodyPart.name,
        if (widget.subPart != null) 'subPart': widget.subPart!.name,
        'imageBytes': bytes,
      },
    );
  }

  IconData get _flashIcon => switch (_flashMode) {
    FlashMode.off => Icons.flash_off,
    FlashMode.auto => Icons.flash_auto,
    FlashMode.always => Icons.flash_on,
    _ => Icons.flash_off,
  };

  @override
  Widget build(BuildContext context) {
    final areaName = widget.subPart?.displayName ?? widget.bodyPart.displayName;

    final captured = _capturedBytes;
    if (captured != null) {
      return _PreviewView(
        imageBytes: captured,
        areaName: areaName,
        onRetake: _retake,
        onUse: _usePhoto,
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_initialising || _controller == null)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            else
              _CameraPreviewFill(controller: _controller!),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _TopBar(
                areaName: areaName,
                flashIcon: _flashIcon,
                onFlash: _cycleFlash,
                onClose: () => context.go(
                  '/add-scan/capture',
                  extra: {
                    'bodyPart': widget.bodyPart.name,
                    if (widget.subPart != null) 'subPart': widget.subPart!.name,
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: _BottomBar(
                capturing: _capturing,
                canFlip: _cameras.length >= 2,
                onCapture: _capture,
                onFlip: _flipCamera,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraPreviewFill extends StatelessWidget {
  const _CameraPreviewFill({required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRect(
          child: OverflowBox(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxWidth / controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.areaName,
    required this.flashIcon,
    required this.onFlash,
    required this.onClose,
  });

  final String areaName;
  final IconData flashIcon;
  final VoidCallback onFlash;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onClose,
          ),
          Expanded(
            child: Text(
              areaName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(flashIcon, color: Colors.white),
            onPressed: onFlash,
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.capturing,
    required this.canFlip,
    required this.onCapture,
    required this.onFlip,
  });

  final bool capturing;
  final bool canFlip;
  final VoidCallback onCapture;
  final VoidCallback onFlip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 64),
        GestureDetector(
          onTap: capturing ? null : onCapture,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              color: capturing
                  ? Colors.white.withValues(alpha: 0.6)
                  : Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 64,
          child: canFlip
              ? IconButton(
                  icon: const Icon(
                    Icons.flip_camera_ios,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: onFlip,
                )
              : null,
        ),
      ],
    );
  }
}

class _PreviewView extends StatelessWidget {
  const _PreviewView({
    required this.imageBytes,
    required this.areaName,
    required this.onRetake,
    required this.onUse,
  });

  final Uint8List imageBytes;
  final String areaName;
  final VoidCallback onRetake;
  final VoidCallback onUse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.memory(imageBytes, fit: BoxFit.contain),
            Positioned(
              top: 8,
              left: 8,
              child: Text(
                areaName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                ),
              ),
            ),
            Positioned(
              bottom: 32,
              left: 24,
              right: 24,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onRetake,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: const Text('Retake'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: onUse,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: const Text('Use Photo'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
