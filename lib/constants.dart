import 'package:flutter/material.dart';

class Constants {
  static const Color mainPageBackgroundColor = Color(0xCFF3E5AB);
  static const Color mainPageComplementColor = Color(0xAF5D4037);
  static const Color mainPageComplementShadowColor = Color.fromARGB(174, 48, 33, 28);
  static const Color mainPageComplementTextColor = Colors.white;
  static const Color bottomNavigationBarColor = Color.fromARGB(255, 120, 128, 121);
  static const Color selectedTimerTileColor = Colors.red;
  static const Color removeTimerSwipeColor = Colors.red;

  static const Color timerBackgroundColor = Colors.black;

  static const IconData pauseIcon = Icons.pause;
  static const IconData resumeIcon = Icons.play_arrow_rounded;
  static const IconData cancelIcon = Icons.cancel;

  static const double timerSeparation = 12.0;
  static const double timerPadding = 16.0;
  static const double timerBorderRadius = 16.0;

  static const String defaultTimerName = 'Pododoro timer';
  static const int defaultTimerWorkMinutes = 25;
  static const int defaultTimerWorkSeconds = 0;
  static const int defaultTimerRestMinutes = 5;
  static const int defaultTimerRestSeconds = 0;
}