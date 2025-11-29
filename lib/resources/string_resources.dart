import 'package:pododoro/constants.dart';

class StringResources {
  static String bottomNavigationBarHome = 'Home';
  static String bottomNavigationBarTimers = 'Timers';
  static String work = 'Work';
  static String rest = 'Rest';
  static String removeActiveTimerErrorMessage = "The active timer may not be deleted.";
  static String removeDefaultTimerErrorMessage = '${Constants.defaultTimerName} may not be deleted.';

  // Add timer
  static String name = "Name";
  static String workTimeText = "How long to work?";
  static String restTimeText = "How long to rest?";
  static String invalidNameErrorMessage = "Invalid name.";
  static String invalidWorkTimeErrorMessage = "Invalid work time.";
  static String invalidRestTimeErrorMessage = "Invalid rest time.";
}