abstract interface class DatabaseService {
  Future<void> initializeDatabase();
  Future<ITimer?> getTimer(int id);
  Future<List<ITimer>> getAllTimers();
  Future<int> addTimer(String name, int totalWorkMinutes, int totalWorkSeconds, int totalRestMinutes, int totalRestSeconds);
  Future<bool> removeTimer(int id);
  ITimer constructTimer(int id, String name, int totalWorkMinutes, int totalWorkSeconds, int totalRestMinutes, int totalRestSeconds);
}

abstract interface class ITimer {
  int get id;
  String get name;
  int get totalWorkMinutes;
  int get totalWorkSeconds;
  int get totalRestMinutes;
  int get totalRestSeconds;
}