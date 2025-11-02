import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart';
import 'package:pododoro/features/add_timer.dart';
import 'package:pododoro/features/pododoro_timer.dart';
import 'package:pododoro/features/timer.dart';
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
  final List<Timer> _timers = List.empty();

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
        title: Text(_activeTimer?.name ?? ""),
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView.builder(
          itemCount: _timers.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text(_timers[index].name!));
          },
        ),
      ),
      backgroundColor: Constants.defaultBackgroundColor,
      body: const PododoroTimer(minutes: 0, seconds: 3),
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

    var timers = await _isar.timers.where().findAll();

    setState(() => timers.addAll(timers));
  }

  /// Adds a timer to the internal database.
  Future _addTimer(String name, int totalMinutes, int totalSeconds) async{
    Timer timer = Timer(name: name, totalMinutes: totalMinutes, totalSeconds: totalSeconds);
    await _isar.writeTxn(() async => await _isar.timers.put(timer));

    setState(() => _timers.add(timer));
  }

  /// Removes a specified timer from the internal database.
  Future<bool> _removeTimer(String name) async {
    Timer? timer = await _isar.timers.filter().nameEqualTo(name, caseSensitive: true).findFirst();    

    if (timer == null) return false;

    bool success = await _isar.timers.delete(timer.id);

    if (!success) return false;

    setState(() => _timers.remove(timer));

    return success;
  }

  /// Removes all timers from the internal database.
  Future _removeAllTimers() async {
    await _isar.timers.clear();
    setState(() => _timers.clear());
  }
}
