import 'dart:async' show Timer;
import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart' show Constants;

class CountdownWidget extends StatefulWidget {
  final VoidCallback? onCancel;
  final int minutes;
  final int seconds;
  final bool isMainTimerRunning;

  const CountdownWidget({super.key, required this.minutes, required this.seconds, required this.onCancel, required this.isMainTimerRunning});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer? _mainTimer;
  Timer? _finalTimer;
  int _remainingMinutes = 0;
  int _remainingSeconds = 0;

  double _timerOpacity = 1.0;

  IconData _pauseResumeIcon = Constants.pauseIcon;
  final ButtonStyle _iconButtonStyle = const ButtonStyle(iconSize: WidgetStatePropertyAll(50));

  @override
  void didUpdateWidget(covariant CountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isMainTimerRunning && widget.isMainTimerRunning) {
      // Start the timer

      setState(() {
        _mainTimer?.cancel();

        _pauseResumeIcon = Constants.pauseIcon;
        _remainingSeconds = widget.seconds;
        _remainingMinutes = widget.minutes;
        _timerOpacity = 1.0;

        _mainTimer = _createMainTimer();
      });
    } else if (oldWidget.isMainTimerRunning && !widget.isMainTimerRunning) {
      _cancelAllTimers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Opacity(
          opacity: _timerOpacity,
          child: Text(
            "${_getTimeUnitDisplay(_remainingMinutes)}:${_getTimeUnitDisplay(_remainingSeconds)}",
            style: const TextStyle(
              fontSize: 60,
            )
          ),
        ),
        Row(
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
              onPressed: widget.onCancel,
              icon: const Icon(Icons.cancel),
              style: _iconButtonStyle,
            )
          ]
        )
      ]
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cancelAllTimers();
  }

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
      if (_pauseResumeIcon == Constants.pauseIcon) {
        _pauseResumeIcon = Constants.resumeIcon;
        _mainTimer?.cancel();
      } else {
        _pauseResumeIcon = Constants.pauseIcon;

        if (_remainingSeconds > 0) {
          _mainTimer = _createMainTimer();
        }
      }
    });
  }

  /// Resets all internal timers
  void _cancelAllTimers() {
    _mainTimer?.cancel();
    _finalTimer?.cancel();
  }

  /// Gets the display string for the time unit.
  String _getTimeUnitDisplay(int timeUnit) {
    if (timeUnit >= 10 && timeUnit < 60) {
      return timeUnit.toString();
    } else if (timeUnit >= 0 && timeUnit < 10) {
      return "0$timeUnit";
    } else {
      return ""; // Shouldn't happen
    }
  }
}