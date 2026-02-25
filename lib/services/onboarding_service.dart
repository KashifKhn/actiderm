import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import '../core/constants/app_constants.dart';

part 'onboarding_service.g.dart';

enum AgeRange {
  under18,
  age18to29,
  age30to49,
  age50to64,
  age65plus;

  String get displayName => switch (this) {
    under18 => 'Under 18',
    age18to29 => '18–29',
    age30to49 => '30–49',
    age50to64 => '50–64',
    age65plus => '65+',
  };
}

enum SkinType {
  typeI,
  typeII,
  typeIII,
  typeIV,
  typeV,
  typeVI;

  String get displayName => switch (this) {
    typeI => 'Type I',
    typeII => 'Type II',
    typeIII => 'Type III',
    typeIV => 'Type IV',
    typeV => 'Type V',
    typeVI => 'Type VI',
  };

  String get description => switch (this) {
    typeI => 'Always burns, never tans',
    typeII => 'Usually burns, tans minimally',
    typeIII => 'Sometimes burns, tans uniformly',
    typeIV => 'Burns minimally, always tans',
    typeV => 'Rarely burns, tans profusely',
    typeVI => 'Never burns, deeply pigmented',
  };

  int get skinToneHex => switch (this) {
    typeI => 0xFFF5DBCB,
    typeII => 0xFFECC5A0,
    typeIII => 0xFFD4A574,
    typeIV => 0xFFB8834A,
    typeV => 0xFF8D5524,
    typeVI => 0xFF4A2912,
  };
}

enum SunExposure {
  minimal,
  moderate,
  frequent,
  extensive;

  String get displayName => switch (this) {
    minimal => 'Minimal',
    moderate => 'Moderate',
    frequent => 'Frequent',
    extensive => 'Extensive',
  };

  String get description => switch (this) {
    minimal => 'Mostly indoors, occasional sun',
    moderate => 'Mix of indoor and outdoor',
    frequent => 'Frequently outdoors',
    extensive => 'Outdoor profession or sport',
  };
}

enum ReminderFrequency {
  weekly,
  biweekly,
  monthly,
  quarterly,
  never;

  String get displayName => switch (this) {
    weekly => 'Weekly',
    biweekly => 'Every 2 Weeks',
    monthly => 'Monthly',
    quarterly => 'Every 3 Months',
    never => 'Never',
  };
}

class OnboardingState {
  const OnboardingState({
    this.currentStep = 0,
    this.selectedAge,
    this.selectedSkinType,
    this.selectedSunExposure,
    this.selectedReminder = ReminderFrequency.monthly,
    this.isComplete = false,
  });

  final int currentStep;
  final AgeRange? selectedAge;
  final SkinType? selectedSkinType;
  final SunExposure? selectedSunExposure;
  final ReminderFrequency selectedReminder;
  final bool isComplete;

  OnboardingState copyWith({
    int? currentStep,
    AgeRange? selectedAge,
    SkinType? selectedSkinType,
    SunExposure? selectedSunExposure,
    ReminderFrequency? selectedReminder,
    bool? isComplete,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      selectedAge: selectedAge ?? this.selectedAge,
      selectedSkinType: selectedSkinType ?? this.selectedSkinType,
      selectedSunExposure: selectedSunExposure ?? this.selectedSunExposure,
      selectedReminder: selectedReminder ?? this.selectedReminder,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

@Riverpod(keepAlive: true)
class OnboardingService extends _$OnboardingService {
  static const int totalSteps = 11;

  static const int _notificationId = 1001;
  static const String _channelId = 'actiderm_reminders';

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  @override
  OnboardingState build() => const OnboardingState();

  void nextStep() {
    if (state.currentStep < totalSteps - 1) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void goToStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  void selectAge(AgeRange age) {
    state = state.copyWith(selectedAge: age);
  }

  void selectSkinType(SkinType skinType) {
    state = state.copyWith(selectedSkinType: skinType);
  }

  void selectSunExposure(SunExposure exposure) {
    state = state.copyWith(selectedSunExposure: exposure);
  }

  void selectReminder(ReminderFrequency frequency) {
    state = state.copyWith(selectedReminder: frequency);
  }

  Future<void> saveOnboardingCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.hasCompletedOnboarding, true);
    if (state.selectedAge != null) {
      await prefs.setString(PrefsKeys.userAge, state.selectedAge!.name);
    }
    if (state.selectedSkinType != null) {
      await prefs.setString(
        PrefsKeys.userSkinType,
        state.selectedSkinType!.name,
      );
    }
    if (state.selectedSunExposure != null) {
      await prefs.setString(
        PrefsKeys.userSunExposure,
        state.selectedSunExposure!.name,
      );
    }
    await prefs.setString(
      PrefsKeys.userReminderFrequency,
      state.selectedReminder.name,
    );
    await _scheduleReminder(state.selectedReminder);
    state = state.copyWith(isComplete: true);
  }

  Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.hasCompletedOnboarding, false);
    await _notifications.cancel(_notificationId);
    state = const OnboardingState();
  }

  Future<void> _scheduleReminder(ReminderFrequency frequency) async {
    await _notifications.cancel(_notificationId);

    if (frequency == ReminderFrequency.never) return;

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      'Skin Check Reminders',
      channelDescription: 'Periodic reminders to perform a skin check',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const darwinDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    const title = 'Time for your skin check';
    const body = 'Open ActiDerm to scan and track any changes.';

    switch (frequency) {
      case ReminderFrequency.weekly:
        await _notifications.periodicallyShow(
          _notificationId,
          title,
          body,
          RepeatInterval.weekly,
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      case ReminderFrequency.biweekly:
        await _notifications.periodicallyShowWithDuration(
          _notificationId,
          title,
          body,
          const Duration(days: 14),
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      case ReminderFrequency.monthly:
        final scheduledDate = tz.TZDateTime.now(
          tz.local,
        ).add(const Duration(days: 30));
        await _notifications.zonedSchedule(
          _notificationId,
          title,
          body,
          scheduledDate,
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
        );
      case ReminderFrequency.quarterly:
        await _notifications.periodicallyShowWithDuration(
          _notificationId,
          title,
          body,
          const Duration(days: 90),
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      case ReminderFrequency.never:
        break;
    }
  }
}
