import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/constants/app_constants.dart';
import '../../services/ai_model/ai_model_service.dart';
import '../../services/ai_model/model_state.dart';
import '../../services/biometric_service.dart';
import '../../services/onboarding_service.dart';
import '../../services/theme_service.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _biometricBusy = false;

  Future<void> _handleBiometricToggle(bool enabled) async {
    setState(() => _biometricBusy = true);
    try {
      if (enabled) {
        final granted = await ref
            .read(biometricServiceProvider.notifier)
            .authenticate();
        if (granted) {
          ref
              .read(biometricServiceProvider.notifier)
              .setBiometricEnabled(enabled: true);
        }
      } else {
        ref
            .read(biometricServiceProvider.notifier)
            .setBiometricEnabled(enabled: false);
      }
    } finally {
      if (mounted) setState(() => _biometricBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final modelState = ref.watch(aiModelServiceProvider);
    final biometricEnabled = ref.watch(biometricServiceProvider).isEnabled;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader(title: 'AI Model'),
          _ModelStatusTile(modelState: modelState),
          ListTile(
            leading: const Icon(Icons.smart_toy_outlined),
            title: const Text('Model'),
            trailing: Text(
              'ActiDerm-MedGemma',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const _SettingsDivider(),
          const _SectionHeader(title: 'Reports'),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('View Reports'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/reports'),
          ),
          const _SettingsDivider(),
          const _SectionHeader(title: 'Appearance'),
          _AppearanceTile(),
          const _SettingsDivider(),
          const _SectionHeader(title: 'Security'),
          FutureBuilder<BiometricType?>(
            future: ref
                .read(biometricServiceProvider.notifier)
                .getPrimaryBiometricType(),
            builder: (context, snapshot) {
              final biometricType = snapshot.data;
              final (IconData icon, String label) = switch (biometricType) {
                BiometricType.face => (Icons.face_outlined, 'Face ID Lock'),
                BiometricType.fingerprint => (
                  Icons.fingerprint,
                  'Touch ID Lock',
                ),
                _ => (Icons.lock_outlined, 'Biometric Lock'),
              };
              return SwitchListTile(
                secondary: _biometricBusy
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(icon),
                title: Text(label),
                subtitle: const Text(
                  'Require biometric authentication on launch',
                ),
                value: biometricEnabled,
                onChanged: _biometricBusy ? null : _handleBiometricToggle,
              );
            },
          ),
          const _SettingsDivider(),
          const _SectionHeader(title: 'Account'),
          ListTile(
            leading: const Icon(Icons.restart_alt),
            title: const Text('Reset Onboarding'),
            subtitle: const Text('Re-run the setup wizard'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _confirmResetOnboarding(),
          ),
          const _SettingsDivider(),
          const _SectionHeader(title: 'About'),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              final info = snapshot.data;
              final versionText = info != null
                  ? '${info.version} (${info.buildNumber})'
                  : '—';
              return ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Version'),
                trailing: Text(
                  versionText,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _MedicalDisclaimerCard(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _confirmResetOnboarding() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Onboarding'),
        content: const Text(
          'This will restart the setup wizard on next launch. '
          'Your scan data will not be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(onboardingServiceProvider.notifier).resetOnboarding();
      if (!mounted) return;
      context.go('/onboarding');
    }
  }
}

class _AppearanceTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeServiceProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final String currentLabel = switch (themeMode) {
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
      ThemeMode.system => 'System',
    };

    return ListTile(
      leading: Icon(switch (themeMode) {
        ThemeMode.light => Icons.light_mode_outlined,
        ThemeMode.dark => Icons.dark_mode_outlined,
        ThemeMode.system => Icons.brightness_auto_outlined,
      }),
      title: const Text('Theme'),
      subtitle: const Text('Choose your preferred appearance'),
      trailing: Text(
        currentLabel,
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      onTap: () => _showThemePicker(context, ref, themeMode),
    );
  }

  void _showThemePicker(
    BuildContext context,
    WidgetRef ref,
    ThemeMode current,
  ) {
    showDialog<void>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Theme'),
        children: ThemeMode.values.map((ThemeMode mode) {
          final (IconData icon, String label) = switch (mode) {
            ThemeMode.light => (Icons.light_mode_outlined, 'Light'),
            ThemeMode.dark => (Icons.dark_mode_outlined, 'Dark'),
            ThemeMode.system => (Icons.brightness_auto_outlined, 'System'),
          };
          return SimpleDialogOption(
            onPressed: () {
              ref.read(themeServiceProvider.notifier).setThemeMode(mode);
              Navigator.of(ctx).pop();
            },
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: mode == current
                      ? Theme.of(ctx).colorScheme.primary
                      : null,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: mode == current
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: mode == current
                        ? Theme.of(ctx).colorScheme.primary
                        : null,
                  ),
                ),
                const Spacer(),
                if (mode == current)
                  Icon(
                    Icons.check,
                    size: 18,
                    color: Theme.of(ctx).colorScheme.primary,
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MedicalDisclaimerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: colorScheme.errorContainer.withValues(alpha: 0.35),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: colorScheme.error,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ActiDerm is not a medical device and does not provide '
                  'medical diagnoses. AI analysis results are for informational '
                  'purposes only and must not replace professional medical advice, '
                  'diagnosis, or treatment. Always consult a qualified '
                  'dermatologist or healthcare provider regarding skin concerns.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onErrorContainer,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: textTheme.labelLarge?.copyWith(
          color: colorScheme.primary,
          letterSpacing: 0.8,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, indent: 16, endIndent: 16);
}

class _ModelStatusTile extends ConsumerStatefulWidget {
  const _ModelStatusTile({required this.modelState});

  final ModelState modelState;

  @override
  ConsumerState<_ModelStatusTile> createState() => _ModelStatusTileState();
}

class _ModelStatusTileState extends ConsumerState<_ModelStatusTile> {
  Future<void> _download() async {
    await ref
        .read(aiModelServiceProvider.notifier)
        .downloadModel(
          url:
              'https://huggingface.co/${AppConstants.hfModelId}/resolve/main/${AppConstants.modelFilename}',
          onProgress: (_) {},
        );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final modelState = widget.modelState;

    final isIdle = modelState is Idle;
    final isFailed = modelState is Failed;
    final isDownloading = modelState is Downloading;

    final (String label, Color badgeColor) = switch (modelState) {
      Idle() => ('Not Loaded', colorScheme.onSurfaceVariant),
      Downloading() => ('Downloading…', colorScheme.primary),
      Loading() => ('Loading…', colorScheme.primary),
      Ready() => ('Ready', const Color(0xFF16A34A)),
      Generating() => ('Generating…', colorScheme.primary),
      Failed() => ('Failed', colorScheme.error),
    };

    Widget? trailingWidget;
    if (isIdle || isFailed) {
      trailingWidget = SizedBox(
        width: 100,
        child: FilledButton.tonal(
          onPressed: _download,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            textStyle: textTheme.labelMedium,
          ),
          child: Text(isFailed ? 'Retry' : 'Download'),
        ),
      );
    } else if (isDownloading) {
      trailingWidget = null;
    } else {
      trailingWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: badgeColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: textTheme.labelLarge?.copyWith(
            color: badgeColor,
            fontSize: 12,
          ),
        ),
      );
    }

    if (modelState is Downloading) {
      final progress = modelState.progress;
      return ListTile(
        leading: const Icon(Icons.memory_outlined),
        title: const Text('On-Device AI'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: colorScheme.surfaceContainerHighest,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Downloading… ${(progress * 100).toStringAsFixed(0)}%',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        isThreeLine: true,
      );
    }

    return ListTile(
      leading: const Icon(Icons.memory_outlined),
      title: const Text('On-Device AI'),
      subtitle: Text(switch (modelState) {
        Idle() => 'Tap Download to install the AI model (~2.5 GB)',
        Failed(:final message) => message,
        Ready() => 'On-device AI model is loaded',
        Loading() => 'Preparing the AI model',
        Generating() => 'Analysing image',
        Downloading() => '',
      }),
      trailing: trailingWidget,
    );
  }
}
