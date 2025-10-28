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
  int _secondsRemaining = 0;
  int _minutesRemaining = 0;
  bool _isStartButtonVisible = true;
  bool _isTimerVisible = false;
  bool _isCancelButtonVisible = false;
  double _timerOpacity = 1.0;
  
  /// Creates a timer object.
  Timer _createMainTimer() {
    return Timer.periodic(
      const Duration(seconds: 1), // Fires every second
      (timer) {
        setState(() {
          if (_secondsRemaining > 0) {
              _secondsRemaining--;
          } else {
              timer.cancel();
              _finalTimer = _createFinalTimer();
          }
        });
      }
    );
  }

  Timer _createFinalTimer() {
    return Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        setState(() {
          _timerOpacity = _timerOpacity == 0.0 ? 1.0 : 0.0;
        });
      }
    );
  }

  /// Makes the start button visible and hides the timer and other displays.
  void showStartButton() {
    setState(() {
      _isStartButtonVisible = true;
      _isTimerVisible = false;
      _isCancelButtonVisible = false;
      _finalTimer?.cancel(); 
    });
  }

  /// Makes the timer and other displays visible and hides the start button.
  void showTimer() {
    setState(() {
      _isStartButtonVisible = false;
      _isTimerVisible = true;
      _isCancelButtonVisible = true;      
    });    
  }

  void _startTimer() {
    _mainTimer?.cancel();

    setState(() {
      _secondsRemaining = widget.seconds;
      _minutesRemaining = widget.minutes;
      _isCancelButtonVisible = true;
    });

    _mainTimer = _createMainTimer();
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
                showTimer();
                _startTimer();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                minimumSize: const Size(200, 200),
                backgroundColor: Colors.red,
              ),
              child: const Text("Start"),
            ),
          ),
          Visibility(
            visible: _isTimerVisible,
            child: Opacity(
              opacity: _timerOpacity,
              child: Text(
                "${getTimeUnitDisplay(_minutesRemaining)}:${getTimeUnitDisplay(_secondsRemaining)}",
                style: const TextStyle(
                  fontSize: 60,
                )
              ),
            )
          ),
          Visibility(
            visible: _isCancelButtonVisible,
            child: ElevatedButton(
              onPressed: () => showStartButton(),
              child: const Text("Cancel")
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