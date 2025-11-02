import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart' show Constants;
import 'package:pododoro/features/countdown.dart';

class PododoroTimer extends StatefulWidget {
  final int minutes;
  final int seconds;

  const PododoroTimer({super.key, required this.minutes, required this.seconds});
  
  @override
  State<PododoroTimer> createState() => _PododoroTimerState();
}

class _PododoroTimerState extends State<PododoroTimer> {
  bool _isMainTimerRunning = false;
  Color _backgroundColor = Constants.defaultBackgroundColor;

  /// Starts the countdown timer and adjusts UI elements
  void _startTimer() {
    setState(() {
      _isMainTimerRunning = true;
      _backgroundColor = Constants.timerBackgroundColor;
    });
  }

  /// Ends the countdown timer and adjusts UI elements
  void _cancelTimer() {
    if (!_isMainTimerRunning) return;

    setState(() {
      _backgroundColor = Constants.defaultBackgroundColor;
      _isMainTimerRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: !_isMainTimerRunning,
              child: ElevatedButton(
                onPressed: _startTimer,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  minimumSize: const Size(200, 200),
                  backgroundColor: const Color.fromARGB(255, 238, 24, 9),
                ),
                child: const Text("Start"),
              ),
            ),
            Visibility(
              visible: _isMainTimerRunning,
              maintainState: true,
              child: CountdownWidget(
                minutes: widget.minutes,
                seconds: widget.seconds,
                onCancel: _cancelTimer,
                isMainTimerRunning: _isMainTimerRunning,
              ),
            ),
          ]
        )
      ),
    );
  }
}