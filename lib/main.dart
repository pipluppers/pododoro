import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pododoro/data_management/database_service.dart';
import 'package:pododoro/features/home/main_page.dart';
import 'package:pododoro/utilities.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:isar/isar.dart';

/// Used to handle navigating to the correct page when the app is closed and the local notification is tapped
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();
late Isar isar;
late AppPlatform appPlatform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    appPlatform = AppPlatform.web;
    // TODO Use another db. Isar is not supported in Dart 3.x +
  } else {
    if (Platform.isAndroid) {
      appPlatform = AppPlatform.android;
    } else if (Platform.isIOS) {
      appPlatform = AppPlatform.ios;
    } else {
      throw UnsupportedError('Pododoro timer does not support this platform.');
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // Uses your app icon

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid
    );

    IsarService isarService = IsarService();
    isarService.initializeDatabase();

    GetIt.I.registerSingleton<DatabaseService>(isarService);

    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload == "Reopen app") {
          navigatorKey.currentState?.popUntil((Route<dynamic> route) { return route.isFirst; });
        }
      }
    );
  }

  runApp(const PododoroTimerApp());
}

class PododoroTimerApp extends StatelessWidget {
  const PododoroTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pododoro timer',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}