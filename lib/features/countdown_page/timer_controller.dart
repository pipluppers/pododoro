import 'dart:async' show Timer;
import 'package:flutter/material.dart' show ValueNotifier;
import 'package:pododoro/utilities.dart' show TimeCounter;

class TimerController {
  final int _totalSeconds;
  final Function onTimerCompleted;
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  late ValueNotifier<TimeCounter> timeNotifier;

  TimerController(this._totalSeconds, this.onTimerCompleted) {
    final int remainingSeconds = _remainingSeconds;

    timeNotifier = ValueNotifier<TimeCounter>(TimeCounter(remainingSeconds ~/ 60, remainingSeconds % 60));
  }

  int get _remainingSeconds => _totalSeconds - _stopwatch.elapsed.inSeconds;

  /// Creates a timer object based on the remaining seconds.
  void startTimer() {
    _stopwatch.start();

    _timer = Timer.periodic(
      const Duration(milliseconds: 500), // Fires twice per second so we can pick up the correct time depending on when the timer as paused
      (timer) async {
        var remainingSeconds = _remainingSeconds;

        timeNotifier.value = TimeCounter(remainingSeconds ~/ 60, remainingSeconds % 60);

        if (remainingSeconds <= 0) {
          timer.cancel();
          onTimerCompleted();
        }
      }
    );
  }

  /// Pauses the stopwatch and cancels the timer.
  void stopTimer() {
    _timer.cancel();
    _stopwatch.stop();
  }

  /// Cancels the timer and releases the ValueNotifier.
  void dispose() {
    stopTimer();
    timeNotifier.dispose();
  }
}