import 'package:pododoro/constants.dart';

class StringResources {
  static String bottomNavigationBarHome = 'Home';
  static String bottomNavigationBarTimers = 'Timers';
  static String work = 'Work';
  static String rest = 'Rest';
  static String removeActiveTimerErrorMessage = "The active timer may not be deleted.";
  static String removeDefaultTimerErrorMessage = '${Constants.defaultTimerName} may not be deleted.';

  // Add timer
  static const String name = "Name";
  static const String workTimeText = "How long to work?";
  static const String restTimeText = "How long to rest?";
  static const String invalidNameErrorMessage = "Invalid name.";
  static const String invalidWorkTimeErrorMessage = "Invalid work time.";
  static const String invalidRestTimeErrorMessage = "Invalid rest time.";
  static const String delete = "Delete";
}