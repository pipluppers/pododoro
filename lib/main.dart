import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pododoro/data_management/database_service.dart';
import 'package:pododoro/data_management/drift/drift_database_service.dart';
import 'package:pododoro/features/home/main_page.dart';
import 'package:pododoro/utilities.dart';
import 'package:get_it/get_it.dart' show GetIt;

/// Used to handle navigating to the correct page when the app is closed and the local notification is tapped
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();
late AppPlatform appPlatform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  DriftDatabaseService driftDatabaseService = DriftDatabaseService();
  await driftDatabaseService.initializeDatabase();
  GetIt.I.registerSingleton<DatabaseService>(driftDatabaseService);

  if (kIsWeb) {
    appPlatform = AppPlatform.web;
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
      home: const InitialPage(),
    );
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<StatefulWidget> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late Future<ITimer?> _activeTimerFuture;
  final List<ITimer> _timers = <ITimer>[];

  @override
  void initState() {
    super.initState();

    _activeTimerFuture = _initializeTimers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _activeTimerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return MainPage(timers: _timers);
        }
      },
    );
  }

  /// Get all existing timers from internal database. If there are no existing timers, then add the default one to the database.
  Future<ITimer> _initializeTimers() async {
    DatabaseService databaseService = GetIt.I<DatabaseService>();

    var existingTimers = await databaseService.getAllTimers();

    setState(() {
      _timers.addAll(existingTimers);
    });

    return _timers[0];
  }
}