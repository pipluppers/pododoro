import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart';
import 'package:pododoro/features/pododoro_timer.dart';
import 'package:pododoro/features/timer.dart';
import 'package:pododoro/features/timer_page/timer_page.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const PododoroTimerApp());
}

class PododoroTimerApp extends StatelessWidget {
  const PododoroTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pododoro',
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
  late Isar _isar;
  late Directory _isarDirectory;
  Timer? _activeTimer;
  final List<Timer> _timers = <Timer>[];

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
        title: Text(_activeTimer?.name ?? "", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          children: [
            DrawerHeader(child: const Text("Timers")),
            ListTile(
              title: const Text("Timers"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerPage(
                      timers: _timers,
                      isar: _isar,
                      onSelectTimer: _setActiveTimer,
                    )
                  )
                );
              }
            ),
          ],
        ),
      ),
      backgroundColor: Constants.defaultBackgroundColor,
      body: _activeTimer != null ? PododoroTimer(timer: _activeTimer!) : Container(color: Colors.black,),
    );
  }

  Future initializeUserData() async {
    _isarDirectory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [TimerSchema],
      directory: _isarDirectory.path
    );

    var existingTimers = await _isar.timers.where().findAll();

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
