import 'dart:async' show Timer;
import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart' show Constants;
import 'package:pododoro/utilities.dart';

class CountdownPage extends StatefulWidget {
  final int minutes;
  final int seconds;

  const CountdownPage({super.key, required this.minutes, required this.seconds});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late Timer _mainTimer;
  Timer? _finalTimer;
  late int _remainingMinutes;
  late int _remainingSeconds;
  double _timerOpacity = 1.0;

  IconData _pauseResumeIcon = Constants.pauseIcon;
  final ButtonStyle _iconButtonStyle = const ButtonStyle(iconSize: WidgetStatePropertyAll(50));

  @override
  void initState() {
    super.initState();

    _remainingMinutes = widget.minutes;
    _remainingSeconds = widget.seconds;
    _mainTimer = _createMainTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.timerBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Opacity(
              opacity: _timerOpacity,
              child: Text(
                Utilities.getTimeUnitDisplay(_remainingMinutes, _remainingSeconds),
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
                  onPressed: () {
                    _mainTimer.cancel();
                    _finalTimer?.cancel();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel),
                  style: _iconButtonStyle,
                )
              ]
            )
          ]
        ),
      ),
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
            if (_remainingMinutes > 0) {
              _remainingMinutes--;
              _remainingSeconds = 59;
            } else {
              timer.cancel();
              _finalTimer = _createFinalTimer();
            }
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
        _mainTimer.cancel();
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
    _mainTimer.cancel();
    _finalTimer?.cancel();
  }
}