import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart';
import 'package:pododoro/features/add_timer.dart';
import 'package:pododoro/features/pododoro_timer.dart';
import 'package:pododoro/features/timer.dart';
import 'package:pododoro/features/timer_page/timer_page.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                      onSelectTimer: _setActiveTimer,
                      onDeleteTimer: _removeTimer,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context2) {
              return AddTimerWidget(onAdd: _addTimer);
            }
          );
        },
        tooltip: 'Add timer',
        child: const Icon(Icons.add),
      ),
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

  /// Adds a timer to the internal database.
  Future _addTimer(String name, int totalMinutes, int totalSeconds) async{
    Timer timer = Timer(name: name, totalMinutes: totalMinutes, totalSeconds: totalSeconds);
    await _isar.writeTxn(() async => await _isar.timers.put(timer));

    setState(() => _timers.add(timer));
  }

  /// Removes a specified timer from the internal database.
  Future<bool> _removeTimer(int id) async {
    Timer? timer = await _isar.timers.get(id);

    if (timer == null) return false;

    bool success = await _isar.writeTxn(() async => _isar.timers.delete(id));

    if (!success) return false;

    setState(() => _timers.remove(timer));

    return success;
  }

  /// Removes all timers from the internal database.
  Future _removeAllTimers() async {
    await _isar.timers.clear();
    setState(() => _timers.clear());
  }

  void _setActiveTimer(String? timerName) {
    if (timerName == null) return;

    setState(() {
      _activeTimer = _timers.firstWhere((timer) => timer.name == timerName);
    });
  }
}
