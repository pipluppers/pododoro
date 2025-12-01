import 'package:flutter/material.dart';

import 'package:pododoro/constants.dart';
import 'package:pododoro/data_management/database_service.dart';
import 'package:pododoro/features/countdown_page/countdown_page.dart';
import 'package:pododoro/features/home/home_page.dart';
import 'package:pododoro/features/home/timer_page.dart';
import 'package:pododoro/resources/string_resources.dart';
import 'package:pododoro/utilities.dart' show AlarmAction, TimerState;

/// Represents the landing page of the app.
/// 
/// Consists of two internal pages: HomePage and TimerPage.
class MainPage extends StatefulWidget {
  final List<ITimer> timers;

  const MainPage({
    super.key,
    required this.timers,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ITimer _activeTimer;
  late List<ITimer> _timers;
  int _currentPageIndex = 0;
  TimerState _timerState = TimerState.work;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    // There should never be 0 timers. The default timer is not editable.
    assert(widget.timers.isNotEmpty);
    _timers = widget.timers;
    _activeTimer = _timers[0];
  }

  @override
  Widget build(BuildContext context) {
    final int totalMinutes, totalSeconds;

    if (_timerState == TimerState.work) {
      totalMinutes = _activeTimer.totalWorkMinutes;
      totalSeconds = _activeTimer.totalWorkSeconds;
    } else {
      totalMinutes = _activeTimer.totalRestMinutes;
      totalSeconds = _activeTimer.totalRestSeconds;
    }

    final String currentTimerType = _timerState == TimerState.work ? StringResources.work : StringResources.rest;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text(_activeTimer.name, style: TextStyle(color: Colors.white))),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Constants.mainPageBackgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          // Update the UI to show which NavigationDestination is active
          setState(() => _currentPageIndex = value);
        },
        children: [
          HomePage(currentTimerType: currentTimerType, minutes: totalMinutes, seconds: totalSeconds, startCountdown: _startCountdown,),
          TimerPage(timers: _timers, activeTimerName: _activeTimer.name, onSelectTimer: _setActiveTimer),
        ]
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Constants.bottomNavigationBarColor,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: StringResources.bottomNavigationBarHome,
          ),
          NavigationDestination(
            icon: Icon(Icons.timelapse),
            label: StringResources.bottomNavigationBarTimers,
          ),
        ],
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (value) =>_pageController.jumpToPage(value),
        backgroundColor: Colors.black,
      ),
    );
  }

  Future<void> _startCountdown() async {
    AlarmAction? result;
    late String timerType;
    late int totalMinutes;
    late int totalSeconds;

    do {
      if (_timerState == TimerState.work) {
        timerType = StringResources.work;
        totalMinutes = _activeTimer.totalWorkMinutes;
        totalSeconds = _activeTimer.totalWorkSeconds;
      } else {
        timerType = StringResources.rest;
        totalMinutes = _activeTimer.totalRestMinutes;
        totalSeconds = _activeTimer.totalRestSeconds;
      }

      result = await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => CountdownPage(
            currentTimerType: timerType,
            minutes: totalMinutes,
            seconds: totalSeconds
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curve = Curves.fastOutSlowIn;
            CurvedAnimation curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
          transitionDuration: Duration(seconds: 3),
          reverseTransitionDuration: Duration(seconds: 1),
        )
      );

      if (result == null) {
        // The user either pressed the back button or did something else to leave the alarm page screen.
        // Require the user to manually click to start the timer again.
        return;
      }

      setState(() {
        if (_timerState == TimerState.work) {
          _timerState = TimerState.rest;
        } else {
          _timerState = TimerState.work;
        }
      });
    } while (result == AlarmAction.startNextTimer);
  }

  /// Set the active timer and rest the state to use the work timer.
  void _setActiveTimer(String timerName) {
    setState(() {
      _activeTimer = _timers.firstWhere((timer) => timer.name == timerName);
      _timerState = TimerState.work;
    });
  }

}