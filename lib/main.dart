import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pododoro/constants.dart';
import 'package:pododoro/features/pododoro_timer.dart';
import 'package:pododoro/features/timer.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pododoro/features/timer_page/timer_page.dart';

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
      title: 'Pododoro',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _activeTimer;
  final List<Timer> _timers = <Timer>[];
    int _currentPageIndex = 0;

  List<Widget> get _pages => [
    PododoroTimer(timer: _activeTimer),
    TimerPage(timers: _timers, activeTimerName: _activeTimer?.name, onSelectTimer: _setActiveTimer),
  ];

  @override
  void initState() {
    super.initState();

    initializeUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text(_activeTimer?.name ?? "", style: TextStyle(color: Colors.white))),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Constants.defaultBackgroundColor,
      body: _pages[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: const Color.fromARGB(255, 120, 128, 121),
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.timelapse),
            label: "Timers",
          ),
        ],
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (value) => setState(() => _currentPageIndex = value),
        backgroundColor: Colors.black,
      ),
    );
  }

  Future initializeUserData() async {
    var existingTimers = await isar.timers.where().findAll();

    if (existingTimers.isEmpty) {
      // Create the default timer
      Timer defaultTimer = Timer(name: "Pododoro timer", totalMinutes: 25, totalSeconds: 0);
      await isar.writeTxn(() async => await isar.timers.put(defaultTimer));

      existingTimers.add(defaultTimer);
    }

    setState(() {
      _timers.addAll(existingTimers);
      if (_timers.isNotEmpty) _activeTimer = _timers[0];
    });
  }

  void _setActiveTimer(String? timerName) {
    if (timerName == null) return;

    setState(() {
      _activeTimer = _timers.firstWhere((timer) => timer.name == timerName);
    });
  }
}