import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'services/biometric_service.dart';

class ActiDermApp extends ConsumerStatefulWidget {
  const ActiDermApp({super.key});

  @override
  ConsumerState<ActiDermApp> createState() => _ActiDermAppState();
}

class _ActiDermAppState extends ConsumerState<ActiDermApp> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onPause: _onAppPause,
      onResume: _onAppResume,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(biometricServiceProvider.notifier).initialize();
      if (ref.read(biometricServiceProvider).isLocked) {
        await ref.read(biometricServiceProvider.notifier).authenticate();
      }
    });
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  void _onAppPause() {
    ref.read(biometricServiceProvider.notifier).lock();
  }

  Future<void> _onAppResume() async {
    if (ref.read(biometricServiceProvider).isLocked) {
      await ref.read(biometricServiceProvider.notifier).authenticate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final isLocked = ref.watch(biometricServiceProvider).isLocked;

    return MaterialApp.router(
      title: 'ActiDerm',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Stack(
        children: [
          child!,
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isLocked
                ? const LockScreenView(key: ValueKey('lock'))
                : const SizedBox.shrink(key: ValueKey('unlocked')),
          ),
        ],
      ),
    );
  }
}

class LockScreenView extends ConsumerStatefulWidget {
  const LockScreenView({super.key});

  @override
  ConsumerState<LockScreenView> createState() => _LockScreenViewState();
}

class _LockScreenViewState extends ConsumerState<LockScreenView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;
  bool _isAuthenticating = false;
  bool _didFail = false;
  BiometricType? _biometricType;
  bool _hasBiometrics = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    _scaleController.forward();
    _loadBiometricInfo();
  }

  Future<void> _loadBiometricInfo() async {
    final service = ref.read(biometricServiceProvider.notifier);
    final results = await Future.wait([
      service.getPrimaryBiometricType(),
      service.hasBiometrics(),
    ]);
    if (mounted) {
      setState(() {
        _biometricType = results[0] as BiometricType?;
        _hasBiometrics = results[1] as bool;
      });
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    setState(() {
      _isAuthenticating = true;
      _didFail = false;
    });
    final success = await ref
        .read(biometricServiceProvider.notifier)
        .authenticate();
    if (!mounted) return;
    setState(() => _isAuthenticating = false);
    if (!success) {
      setState(() => _didFail = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final (
      IconData biometricIcon,
      String biometricName,
    ) = switch (_biometricType) {
      BiometricType.face => (Icons.face_outlined, 'Face ID'),
      BiometricType.fingerprint => (Icons.fingerprint, 'Touch ID'),
      _ => (Icons.lock_outlined, 'Biometrics'),
    };

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: colorScheme.surface.withValues(alpha: 0.75),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          colorScheme.primary.withValues(alpha: 0.2),
                          colorScheme.primary.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.health_and_safety_outlined,
                      size: 60,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'ActiDerm is Locked',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your health data is protected.\nAuthenticate to continue.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      if (_didFail) ...[
                        Text(
                          'Authentication failed. Please try again.',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                      ],
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton.icon(
                          onPressed: _isAuthenticating ? null : _authenticate,
                          icon: _isAuthenticating
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  _hasBiometrics
                                      ? biometricIcon
                                      : Icons.pin_outlined,
                                ),
                          label: Text(
                            _isAuthenticating
                                ? 'Authenticating…'
                                : _hasBiometrics
                                ? 'Unlock with $biometricName'
                                : 'Unlock with Device PIN',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      if (_hasBiometrics) ...[
                        const SizedBox(height: 12),
                        TextButton.icon(
                          onPressed: _isAuthenticating ? null : _authenticate,
                          icon: Icon(
                            Icons.pin_outlined,
                            size: 18,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          label: Text(
                            'Use Device PIN instead',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
