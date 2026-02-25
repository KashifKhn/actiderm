import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/body_part.dart';

class CaptureOptionsScreen extends StatefulWidget {
  const CaptureOptionsScreen({super.key, required this.bodyPart, this.subPart});

  final BodyPart bodyPart;
  final BodySubPart? subPart;

  @override
  State<CaptureOptionsScreen> createState() => _CaptureOptionsScreenState();
}

class _CaptureOptionsScreenState extends State<CaptureOptionsScreen> {
  bool _picking = false;

  void _goToCamera() {
    context.go(
      '/add-scan/camera',
      extra: {
        'bodyPart': widget.bodyPart.name,
        if (widget.subPart != null) 'subPart': widget.subPart!.name,
      },
    );
  }

  Future<void> _pickFromGallery() async {
    if (_picking) return;
    setState(() => _picking = true);
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxWidth: 2048,
        maxHeight: 2048,
      );
      if (file == null || !mounted) return;
      final bytes = await file.readAsBytes();
      _goToReview(bytes);
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  void _goToReview(Uint8List bytes) {
    context.go(
      '/add-scan/review',
      extra: {
        'bodyPart': widget.bodyPart.name,
        if (widget.subPart != null) 'subPart': widget.subPart!.name,
        'imageBytes': bytes,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final areaName = widget.subPart?.displayName ?? widget.bodyPart.displayName;

    return Scaffold(
      appBar: AppBar(title: Text(areaName), leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add a photo', style: textTheme.displayMedium),
            const SizedBox(height: 8),
            Text(
              'Take a new photo or choose from your library.',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 40),
            _OptionTile(
              icon: Icons.camera_alt_outlined,
              title: 'Take Photo',
              description: 'Use the camera to photograph your skin',
              onTap: _picking ? null : _goToCamera,
            ),
            const SizedBox(height: 16),
            _OptionTile(
              icon: Icons.photo_library_outlined,
              title: 'Choose from Library',
              description: 'Import an existing photo from your gallery',
              onTap: _picking ? null : _pickFromGallery,
            ),
            if (_picking) ...[
              const SizedBox(height: 32),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B6B7B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: const Color(0xFF1B6B7B), size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(description, style: textTheme.bodyMedium),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
