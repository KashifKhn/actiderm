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

  static const String skinExtractPrompt =
      'Role: You are a specialized morphological observer for a skin-tracking application.\n'
      'Task: Describe the skin lesion in the provided image using a structured, narrative format.\n\n'
      'Guidelines:\n'
      '1. No Diagnosis: Do not name conditions (e.g., avoid "melanoma" or "mole").\n'
      '2. No Medical Advice: Do not provide safety assessments.\n'
      '3. Language: Use Sentence Case. Ensure descriptions are readable and descriptive.\n'
      '4. Objectivity: Describe only what is visually present.\n\n'
      'Extraction Schema:\n'
      '{\n'
      '  "lesion_type": "Description of the type (e.g., A pigmented macule/flat).",\n'
      '  "color": "Description of hues and pigment distribution.",\n'
      '  "symmetry": "Description of the balance of shape and color.",\n'
      '  "borders": "Description of the margins/edges.",\n'
      '  "texture": "Description of the surface quality.",\n'
      '  "summary": "A 1-2 sentence takeaway for the user to share with a doctor."\n'
      '}\n\n'
      'Formatting Rules:\n'
      '- Return ONLY valid JSON.\n'
      '- If a feature is not visible due to image quality, return '
      '"Undetermined due to image resolution or focus." for that field.';

  static const String sunscreenExtractPrompt =
      'Role: You are a specialized dermatological data extraction agent.\n'
      'Task: Analyse the sunscreen product label in the provided image and return structured data.\n\n'
      'Extraction Schema:\n'
      '{\n'
      '  "spf": "The SPF number as a string (e.g., \\"50+\\"). Return \\"Not visible\\" if absent.",\n'
      '  "ingredients": "A comma-separated string of the active ingredients and their concentrations '
      '(e.g., \\"Zinc Oxide 25%, Titanium Dioxide 5%\\"). Return \\"Not visible\\" if absent.",\n'
      '  "summary": "One sentence summarising the product type, SPF, and formula '
      '(Mineral, Chemical, or Hybrid)."\n'
      '}\n\n'
      'Formatting Rules:\n'
      '- Return ONLY valid JSON.\n'
      '- If a field cannot be extracted from the image, return the string \\"Not visible\\".';
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
