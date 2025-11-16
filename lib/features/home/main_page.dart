import 'package:flutter/material.dart';
import 'package:pododoro/features/home/home_page.dart';
import 'package:pododoro/features/home/timer_page.dart';
import 'package:pododoro/constants.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:pododoro/utilities.dart' show TimerState;
import 'package:pododoro/data_management/database_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<ITimer> _activeTimerFuture;
  late ITimer _activeTimer;
  final List<ITimer> _timers = <ITimer>[];
  int _currentPageIndex = 0;
  final List<Widget> _pages = <Widget>[];
  TimerState _timerState = TimerState.work;

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
          return _generatePage();
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
      _activeTimer = _timers[0];
    });

    return _timers[0];
  }

  /// Set the active timer and rest the state to use the work timer.
  void _setActiveTimer(String? timerName) {
    if (timerName == null) return;

    setState(() {
      _activeTimer = _timers.firstWhere((timer) => timer.name == timerName);
      _timerState = TimerState.work;
    });
  }

  /// Constructs the main page.
  ///
  /// Updates the _pages member with the home page and the timer page.
  Scaffold _generatePage() {
    final int totalMinutes, totalSeconds;

    if (_timerState == TimerState.work) {
      totalMinutes = _activeTimer.totalWorkMinutes;
      totalSeconds = _activeTimer.totalWorkSeconds;
    } else {
      totalMinutes = _activeTimer.totalRestMinutes;
      totalSeconds = _activeTimer.totalRestSeconds;
    }

    final String currentTimerType = _timerState == TimerState.work ? "Work" : "Rest";

    if (_pages.isNotEmpty) {
      _pages.clear();
    }

    _pages.add(HomePage(currentTimerType: currentTimerType, minutes: totalMinutes, seconds: totalSeconds, updateState: _updateState,));
    _pages.add(TimerPage(timers: _timers, activeTimerName: _activeTimer.name, onSelectTimer: _setActiveTimer));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text(_activeTimer.name, style: TextStyle(color: Colors.white))),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Constants.mainPageBackgroundColor,
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

  /// Updates whether to use the work timer or the rest timer.
  void _updateState() {
    setState(() {
      if (_timerState == TimerState.work) {
        _timerState = TimerState.rest;
      } else {
        _timerState = TimerState.work;
      }
    });
  }

}