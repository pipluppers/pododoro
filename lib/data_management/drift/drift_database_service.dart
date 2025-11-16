import 'package:pododoro/constants.dart';
import 'package:pododoro/utilities.dart' show AddTimerException;
import 'package:pododoro/data_management/database_service.dart';
import 'package:pododoro/data_management/drift/drift_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/remote.dart' show DriftRemoteException;

class DriftDatabaseService implements DatabaseService {
  late TimerDriftDatabase _database;

  DriftDatabaseService();

  @override
  Future<void> initializeDatabase() async {
    _database = TimerDriftDatabase();

    // Adds the default timer if there aren't any timers.
    int? count = await _getCount();
    if (count == 0) {
      await addTimer(
        Constants.defaultTimerName,
        Constants.defaultTimerWorkMinutes,
        Constants.defaultTimerWorkSeconds,
        Constants.defaultTimerRestMinutes,
        Constants.defaultTimerRestSeconds
      );
    }
  }

  @override
  Future<ITimer?> getTimer(int id) async {
    var data = await (_database.select(_database.timerTable)..where((table) => table.id.equals(id))).getSingleOrNull();

    return data != null ?
      DriftTimer(data.id, data.name, data.totalWorkMinutes, data.totalWorkSeconds, data.totalRestMinutes, data.totalRestSeconds) :
      null;
  }

  @override
  Future<List<ITimer>> getAllTimers() async {
    final dataObjects = await _database.select(_database.timerTable).get();

    List<DriftTimer> timers = <DriftTimer>[];
    for (int i = 0; i < dataObjects.length; i++) {
      final dataObject = dataObjects[i];

      timers.add(DriftTimer(
        dataObject.id,
        dataObject.name,
        dataObject.totalWorkMinutes,
        dataObject.totalWorkSeconds,
        dataObject.totalRestMinutes,
        dataObject.totalRestSeconds
      ));
    }

    return timers;
  }

  /// Inserts the timer record to the table and returns the id of record.
  @override
  Future<int> addTimer(String name, int totalWorkMinutes, int totalWorkSeconds, int totalRestMinutes, int totalRestSeconds) async {
    try {
      final dataObject = await _database.into(_database.timerTable).insertReturning(
        TimerTableCompanion(
          name: Value(name),
          totalWorkMinutes: Value(totalWorkMinutes),
          totalWorkSeconds: Value(totalWorkSeconds),
          totalRestMinutes: Value(totalRestMinutes),
          totalRestSeconds: Value(totalRestSeconds),
        )
      );

      return dataObject.id;
    } on DriftRemoteException {
      throw AddTimerException();
    }
  }

  /// Deletes the timer with the specified id.
  @override
  Future<bool> removeTimer(int id) async {
    int numDeletedRows = await (_database.delete(_database.timerTable)..where((t) => t.id.equals(id))).go();

    return numDeletedRows > 0;
  }

  @override
  ITimer constructTimer(int id, String name, int totalWorkMinutes, int totalWorkSeconds, int totalRestMinutes, int totalRestSeconds) {
    return DriftTimer(id, name, totalWorkMinutes, totalWorkSeconds, totalRestMinutes, totalRestSeconds);
  }

  /// Gets the number of rows in the timer table.
  Future<int?> _getCount() async {
    // Define count expression
    final Expression<int> countExpression = _database.timerTable.id.count();

    // Create query that selects only that count
    final query = _database.selectOnly(_database.timerTable)..addColumns([countExpression]);

    // Execute the query
    final result = await query.getSingle();

    // Get the value from the result
    return result.read(countExpression);
  }
}

class DriftTimer implements ITimer {
  final int _id;
  final String _name;
  final int _totalWorkMinutes;
  final int _totalWorkSeconds;
  final int _totalRestMinutes;
  final int _totalRestSeconds;

  DriftTimer(this._id, this._name, this._totalWorkMinutes, this._totalWorkSeconds, this._totalRestMinutes, this._totalRestSeconds);

  static DriftTimer defaultTimer() => DriftTimer(
    0, // The id of the default timer will always be 0
    Constants.defaultTimerName,
    Constants.defaultTimerWorkMinutes,
    Constants.defaultTimerWorkSeconds,
    Constants.defaultTimerRestMinutes,
    Constants.defaultTimerRestSeconds    
  );

  @override
  int get id => _id;

  @override
  String get name => _name;

  @override
  int get totalWorkMinutes => _totalWorkMinutes;

  @override
  int get totalWorkSeconds => _totalWorkSeconds;

  @override
  int get totalRestMinutes => _totalRestMinutes;

  @override
  int get totalRestSeconds => _totalRestSeconds;

}