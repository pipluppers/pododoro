import 'package:flutter/material.dart';

import 'package:pododoro/constants.dart' show Constants;
import 'package:pododoro/utilities.dart' show Utilities;

/// Represents the second page on the main page.
/// 
/// Displays the button to start the pododoro timer.
class HomePage extends StatefulWidget {
  final String currentTimerType;
  final int minutes;
  final int seconds;
  final Function startCountdown;

  const HomePage({super.key, required this.currentTimerType, required this.minutes, required this.seconds, required this.startCountdown});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.mainPageBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async => await widget.startCountdown(),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                minimumSize: const Size(200, 200),
                backgroundColor: Constants.mainPageComplementColor,
                elevation: 8.0,
                shadowColor: Constants.mainPageComplementShadowColor,
              ),
              child: TimerInfoWidget(text: widget.currentTimerType, minutes: widget.minutes, seconds: widget.seconds,),
            ),
          ]
        )
      ),
    );
  }
}

class TimerInfoWidget extends StatelessWidget {
  const TimerInfoWidget({
    super.key,
    required this.text,
    required this.minutes,
    required this.seconds,
  });

  final String text;
  final int minutes;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$text\n${Utilities.getTimeUnitDisplay(minutes, seconds)}",
          style: TextStyle(
            color: Constants.mainPageComplementTextColor,
            fontWeight: FontWeight.normal,
            fontSize: 50,
          ),
          textAlign: TextAlign.center,
        ),
      ]
    );
  }
}