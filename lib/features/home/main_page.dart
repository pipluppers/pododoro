import 'package:flutter/material.dart';
import 'package:pododoro/features/home/home_page.dart';
import 'package:pododoro/features/home/timer_page.dart';
import 'package:pododoro/features/timer.dart';
import 'package:pododoro/constants.dart';
import 'package:pododoro/main.dart';
import 'package:isar/isar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<Timer> _activeTimerFuture;
  late Timer _activeTimer;
  final List<Timer> _timers = <Timer>[];
  int _currentPageIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _activeTimerFuture = initializeTimers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _activeTimerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _generatePage();
        }
      },
    );
  }

  /// Get all existing timers from internal database. If there are no existing timers, then add the default one to the database.
  Future<Timer> initializeTimers() async {
    var existingTimers = await isar.timers.where().findAll();

    if (existingTimers.isEmpty) {
      // Create the default timer
      Timer defaultTimer = Timer(name: "Pododoro timer", totalMinutes: 25, totalSeconds: 0);
      await isar.writeTxn(() async => await isar.timers.put(defaultTimer));

      existingTimers.add(defaultTimer);
    }

    setState(() {
      _timers.addAll(existingTimers);
      _activeTimer = _timers[0];
    });

    return _timers[0];
  }

  /// Set the active timer.
  void _setActiveTimer(String? timerName) {
    if (timerName == null) return;

    setState(() => _activeTimer = _timers.firstWhere((timer) => timer.name == timerName));
  }

  /// Constructs the main page.
  ///
  /// Updates the _pages member with the home page and the timer page.
  Scaffold _generatePage() {
    _pages = [
      HomePage(timer: _activeTimer),
      TimerPage(timers: _timers, activeTimerName: _activeTimer.name, onSelectTimer: _setActiveTimer),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text(_activeTimer.name ?? "", style: TextStyle(color: Colors.white))),
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

}