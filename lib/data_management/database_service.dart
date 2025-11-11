import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pododoro/features/timer.dart';

abstract interface class DatabaseService {
  Future initializeDatabase();
  Future<Timer?> getTimer(int id);
  Future<List<Timer>> getAllTimers();
  Future addTimer(Timer timer);
  Future<bool> removeTimer(int id);
}

/// Service object using the isar database.
/// 
/// This class only supports Android and iOS platforms.
class IsarService implements DatabaseService {
  late Isar _isar;

  /// Initialize the isar database.
  @override
  Future initializeDatabase() async {
    final isarDirectory = (await getApplicationDocumentsDirectory()).path;

    _isar = await Isar.open(
      [TimerSchema],
      directory: isarDirectory,
    );
  }

  /// Gets a timer with the specified id from the database.
  @override
  Future<Timer?> getTimer(int id) {
    return _isar.timers.get(id);
  }

  /// Gets all timers stored in the database.
  @override
  Future<List<Timer>> getAllTimers() async {
    return _isar.timers.where().findAll();
  }

  /// Store a timer to the database.
  @override
  Future addTimer(Timer timer) async {
    await _isar.writeTxn(() async => await _isar.timers.put(timer));
  }

  /// Remove a timer from the database.
  @override
  Future<bool> removeTimer(int id) async {
    return await _isar.writeTxn(() async => await _isar.timers.delete(id));
  }
}