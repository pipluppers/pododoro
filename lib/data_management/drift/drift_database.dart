import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart' show driftDatabase, DriftNativeOptions;

part 'drift_database.g.dart';

class TimerTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  IntColumn get totalWorkMinutes => integer().customConstraint('NOT NULL CHECK (total_work_minutes >= 0 AND total_work_minutes < 60)')();
  IntColumn get totalWorkSeconds => integer().customConstraint('NOT NULL CHECK (total_work_seconds >= 0 AND total_work_seconds < 60)')();
  IntColumn get totalRestMinutes => integer().customConstraint('NOT NULL CHECK (total_rest_minutes >= 0 AND total_rest_minutes < 60)')();
  IntColumn get totalRestSeconds => integer().customConstraint('NOT NULL CHECK (total_rest_seconds >= 0 AND total_rest_seconds < 60)')();
}

@DriftDatabase(tables: [TimerTable])
class TimerDriftDatabase extends _$TimerDriftDatabase {

  TimerDriftDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// Current schema version of the database
  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'timer_database',
      native: const DriftNativeOptions(
      )
    );
  }
}
