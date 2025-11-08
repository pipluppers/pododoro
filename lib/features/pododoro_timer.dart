import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart' show Constants;
import 'package:pododoro/features/countdown_page/countdown_page.dart';
import 'package:pododoro/features/timer.dart';

class PododoroTimer extends StatefulWidget {
  final Timer? timer;

  const PododoroTimer({super.key, required this.timer});
  
  @override
  State<PododoroTimer> createState() => _PododoroTimerState();
}

class _PododoroTimerState extends State<PododoroTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.defaultBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountdownPage(
                    minutes: widget.timer!.totalMinutes!,
                    seconds: widget.timer!.totalSeconds!,
                  ),
                )
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                minimumSize: const Size(200, 200),
                backgroundColor: const Color.fromARGB(255, 238, 24, 9),
              ),
              child: const Text("Start"),
            ),
          ]
        )
      ),
    );
  }
}