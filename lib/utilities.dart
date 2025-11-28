import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  /// Shows a toast message for 2 seconds.
  static void showToast(FToast flutterToast, String message) {
    flutterToast.showToast(
      child: AddTimerToast(exceptionMessage: message),
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM
    );
  }
}

class AddTimerToast extends StatelessWidget {
  const AddTimerToast({
    super.key,
    required this.exceptionMessage,
  });

  final String exceptionMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadiusGeometry.all(Radius.elliptical(45, 45)),
      ),
      child: Text(exceptionMessage),
    );
  }
}

class TimeCounter {
  int _minutes;
  int _seconds;

  TimeCounter(this._minutes, this._seconds);

  int get minutes => _minutes;
  int get seconds => _seconds;

  void updateTime(int minutes, int seconds) {
    _minutes = minutes;
    _seconds = seconds;
  }
}

// Exceptions
class AddTimerException implements Exception { }
class RemoveTimerException implements Exception {
  final String message;
  RemoveTimerException(this.message);
}