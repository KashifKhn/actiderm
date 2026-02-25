abstract final class AppConstants {
  static const String appName = 'ActiDerm';
  static const String hfModelId =
      'mrdbourke/sunny-medgemma-1.5-4b-finetune-litert';
  static const String modelFilename = 'model.task';
  static const String privacyUrl = 'https://actiderm.kashifkhan.dev/privacy';
  static const String termsUrl = 'https://actiderm.kashifkhan.dev/terms';
  static const String shareUrl = 'https://actiderm.kashifkhan.dev/download';
  static const String skinDataDir = 'ActiDermData';
  static const String imagesDir = 'Images';
  static const String pdfsDir = 'PDFs';
  static const String huggingfaceDir = 'huggingface';
  static const int modelAutoUnloadSeconds = 120;
  static const int scanUpdateThresholdDays = 30;
  static const int maxTokens = 2048;
}

abstract final class PrefsKeys {
  static const String hasCompletedOnboarding = 'hasCompletedOnboarding';
  static const String userAge = 'userAge';
  static const String userSkinType = 'userSkinType';
  static const String userSunExposure = 'userSunExposure';
  static const String userReminderFrequency = 'userReminderFrequency';
  static const String biometricLockEnabled = 'biometricLockEnabled';
}

abstract final class NotificationIds {
  static const String skinCheckReminder = 'skinCheckReminder';
}
