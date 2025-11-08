import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pododoro/features/home/main_page.dart';
import 'package:pododoro/features/timer.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// Used to handle navigating to the correct page when the app is closed and the local notification is tapped
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();
late Isar isar;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Uses your app icon

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid
  );

  await localNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload == "Reopen app") {
        navigatorKey.currentState?.popUntil((Route<dynamic> route) { return route.isFirst; });
      }
    }
  );

  // Initialize database
  var isarDirectory = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [TimerSchema],
    directory: isarDirectory.path
  );

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