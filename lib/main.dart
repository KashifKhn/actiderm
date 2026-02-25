import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;

import 'app.dart';
import 'data/database/app_database.dart';
import 'services/file_manager_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterGemma.initialize();

  tz_data.initializeTimeZones();

  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const darwinInit = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const initSettings = InitializationSettings(
    android: androidInit,
    iOS: darwinInit,
  );
  await FlutterLocalNotificationsPlugin().initialize(initSettings);

  const androidChannel = AndroidNotificationChannel(
    'actiderm_reminders',
    'Skin Check Reminders',
    description: 'Periodic reminders to perform a skin check',
    importance: Importance.defaultImportance,
  );
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(androidChannel);

  final database = AppDatabase();
  final fileManager = FileManagerService();
  await fileManager.initialize();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        fileManagerServiceProvider.overrideWithValue(fileManager),
      ],
      child: const ActiDermApp(),
    ),
  );
}
