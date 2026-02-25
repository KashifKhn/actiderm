import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/app_constants.dart';

part 'biometric_service.g.dart';

class BiometricState {
  const BiometricState({this.isEnabled = false, this.isLocked = false});

  final bool isEnabled;
  final bool isLocked;

  BiometricState copyWith({bool? isEnabled, bool? isLocked}) {
    return BiometricState(
      isEnabled: isEnabled ?? this.isEnabled,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}

@Riverpod(keepAlive: true)
class BiometricService extends _$BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  static const String _prefKey = PrefsKeys.biometricLockEnabled;

  @override
  BiometricState build() => const BiometricState();

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool(_prefKey) ?? false;
    state = BiometricState(isEnabled: isEnabled, isLocked: isEnabled);
  }

  Future<bool> checkAvailability() async {
    try {
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      final success = await _auth.authenticate(
        localizedReason: 'Authenticate to access ActiDerm',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
      if (success) {
        state = state.copyWith(isLocked: false);
      }
      return success;
    } catch (_) {
      return false;
    }
  }

  void lock() {
    if (state.isEnabled) {
      state = state.copyWith(isLocked: true);
    }
  }

  Future<void> setBiometricEnabled({required bool enabled}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, enabled);
    state = state.copyWith(
      isEnabled: enabled,
      isLocked: enabled ? state.isLocked : false,
    );
  }

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  Future<BiometricType?> getPrimaryBiometricType() async {
    try {
      final available = await _auth.getAvailableBiometrics();
      if (available.contains(BiometricType.face)) return BiometricType.face;
      if (available.contains(BiometricType.fingerprint)) {
        return BiometricType.fingerprint;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
