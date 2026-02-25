import 'package:flutter/services.dart';

class HapticManager {
  const HapticManager._();

  static Future<void> lightImpact() => HapticFeedback.lightImpact();

  static Future<void> mediumImpact() => HapticFeedback.mediumImpact();

  static Future<void> heavyImpact() => HapticFeedback.heavyImpact();

  static Future<void> selectionClick() => HapticFeedback.selectionClick();

  static Future<void> vibrate() => HapticFeedback.vibrate();

  static Future<void> success() async {
    await HapticFeedback.mediumImpact();
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.selectionClick();
  }

  static Future<void> error() async {
    await HapticFeedback.heavyImpact();
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }
}
