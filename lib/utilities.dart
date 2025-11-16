enum AppPlatform {
  android,
  ios,
  web
}

enum TimerState {
  work,
  rest
}

enum AlarmAction {
  startNextTimer,
  returnHome
}

class Utilities {
  /// Gets the display string for the time unit.
  static String getTimeUnitDisplay(int? minutes, int? seconds) {
    if (minutes == null || seconds == null) return "";
    
    return "${_getTimeUnitDisplay(minutes)}:${_getTimeUnitDisplay(seconds)}";
  }

  /// Gets the display string for the time unit.
  static String _getTimeUnitDisplay(int timeUnit) {
    if (timeUnit >= 10 && timeUnit < 60) {
      return timeUnit.toString();
    } else if (timeUnit >= 0 && timeUnit < 10) {
      return "0$timeUnit";
    } else {
      return ""; // Shouldn't happen
    }
  }
}

// Exceptions
class AddTimerException implements Exception { }