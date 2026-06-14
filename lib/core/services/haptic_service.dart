import 'package:flutter/services.dart';

class HapticService {
  /// Triggers a medium impact haptic feedback.
  /// Used for incorrect quiz answers.
  static Future<void> mediumImpact() async {
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      // Ignore if not supported on the device.
      debugPrint('Haptic feedback failed: $e');
    }
  }

  /// Triggers a light impact haptic feedback.
  /// Could be used for correct answers or button taps.
  static Future<void> lightImpact() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Haptic feedback failed: $e');
    }
  }
}

// Ignore debugPrint for simple logging without importing material where unnecessary
void debugPrint(String message) {
  // In a real app this would use a logging package
  // print(message);
}
