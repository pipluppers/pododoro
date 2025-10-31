import 'package:flutter/material.dart';
import 'dart:async' show Timer;

class PododoroTimer extends StatefulWidget {
  final int minutes;
  final int seconds;

  const PododoroTimer({super.key, required this.minutes, required this.seconds});
  
  @override
  State<PododoroTimer> createState() => _PododoroTimerState();
}

class _PododoroTimerState extends State<PododoroTimer> {
  Timer? _mainTimer;
  Timer? _finalTimer;
  int _remainingMinutes = 0;
  int _remainingSeconds = 0;
  bool _isStartButtonVisible = true;
  bool _isTimerVisible = false;
  bool _areTimerButtonsVisible = false;
  double _timerOpacity = 1.0;

  IconData _pauseResumeIcon = Icons.pause;
  final ButtonStyle _iconButtonStyle = const ButtonStyle(iconSize: WidgetStatePropertyAll(50));

  /// Creates a timer object based on the remaining seconds.
  Timer _createMainTimer() {
    return Timer.periodic(
      const Duration(seconds: 1), // Fires every second
      (timer) {
        setState(() {
          if (_remainingSeconds > 0) {
              _remainingSeconds--;
          } else {
              timer.cancel();
              _finalTimer = _createFinalTimer();
          }
        });
      }
    );
  }

  /// Creates a timer object that will blink 00:00. This should only be called once the main timer is finished.
  Timer _createFinalTimer() {
    return Timer.periodic(
      const Duration(milliseconds: 650),
      (timer) {
        setState(() {
          _timerOpacity = _timerOpacity == 0.0 ? 1.0 : 0.0;
        });
      }
    );
  }

  /// Pause the main timer if it is active. Otherwise, resume the main timer.
  void _pauseTimer() {
    setState(() {
      if (_pauseResumeIcon == Icons.pause) {
        _pauseResumeIcon = Icons.play_arrow_rounded;
        _mainTimer?.cancel();
      } else {
        _pauseResumeIcon = Icons.pause;

        if (_remainingSeconds > 0) {
          _mainTimer = _createMainTimer();
        }
      }
    });
  }

  /// Makes the start button visible and hides the timer and other displays.
  void _cancelTimer() {
    setState(() {
      _isStartButtonVisible = true;
      _isTimerVisible = false;
      _areTimerButtonsVisible = false;
      _finalTimer?.cancel(); 
    });
  }

  /// Start the main timer.
  /// Makes the start button invisible, and makes the timer buttons visible.
  void _startMainTimer() {
    setState(() {
      _mainTimer?.cancel();

      _isStartButtonVisible = false;
      _isTimerVisible = true;
      _areTimerButtonsVisible = true;
      _pauseResumeIcon = Icons.pause;
      _remainingSeconds = widget.seconds;
      _remainingMinutes = widget.minutes;

      _mainTimer = _createMainTimer();
    });
  }

  /// Gets the display string for the time unit.
  String getTimeUnitDisplay(int timeUnit) {
    if (timeUnit >= 10 && timeUnit < 60) {
      return timeUnit.toString();
    } else if (timeUnit >= 0 && timeUnit < 10) {
      return "0$timeUnit";
    } else {
      return ""; // Shouldn't happen
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: _isStartButtonVisible,
            child: ElevatedButton(
              onPressed: () {
                _startMainTimer();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                minimumSize: const Size(200, 200),
                backgroundColor: const Color.fromARGB(255, 238, 24, 9),
              ),
              child: const Text("Start"),
            ),
          ),
          Visibility(
            visible: _isTimerVisible,
            child: Opacity(
              opacity: _timerOpacity,
              child: Text(
                "${getTimeUnitDisplay(_remainingMinutes)}:${getTimeUnitDisplay(_remainingSeconds)}",
                style: const TextStyle(
                  fontSize: 60,
                )
              ),
            )
          ),
          Visibility(
            visible: _areTimerButtonsVisible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () => _remainingSeconds > 0 ? _pauseTimer() : null,
                  icon: Icon(_pauseResumeIcon),
                  style: _iconButtonStyle
                )
              ),
              IconButton(
                onPressed: () => _cancelTimer(),
                icon: const Icon(Icons.cancel),
                style: _iconButtonStyle
              ),
              ],
            )
          )
        ]
      )
    );
  }

  @override
  void dispose() {
    _mainTimer?.cancel(); // Disposes the timer
    _finalTimer?.cancel();
    super.dispose();
  }
}