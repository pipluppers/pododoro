import 'package:flutter/material.dart';

import 'package:pododoro/constants.dart' show Constants;
import 'package:pododoro/features/alarm_page/alarm_page.dart';
import 'package:pododoro/features/countdown_page/notification_controller.dart';
import 'package:pododoro/features/countdown_page/timer_controller.dart';
import 'package:pododoro/utilities.dart' show TimeCounter, Utilities;

class CountdownPage extends StatefulWidget {
  final String currentTimerType;
  final int minutes;
  final int seconds;

  const CountdownPage({super.key, required this.currentTimerType, required this.minutes, required this.seconds});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  IconData _pauseResumeIcon = Constants.pauseIcon;
  final ButtonStyle _iconButtonStyle = const ButtonStyle(iconSize: WidgetStatePropertyAll(50));

  late TimerController _timerController;
  late NotificationController _notificationController;

  @override
  void initState() {
    super.initState();

    _timerController = TimerController((widget.minutes * 60) + widget.seconds, activateAlarmPage);
    _notificationController = NotificationController(_timerController);
    _timerController.startTimer();
    _notificationController.sendNotification(true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Scaffold(
        body: Container(
          color: Constants.timerBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder<TimeCounter>(
                    valueListenable: _timerController.timeNotifier,
                    builder: (context, value, child) {
                      return Text(
                        '${widget.currentTimerType}\n${Utilities.getTimeUnitDisplay(value.minutes, value.seconds)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Constants.mainPageComplementTextColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 50,
                        )
                      );
                    }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    // Pause button
                    onPressed: () {
                      if (_pauseResumeIcon == Constants.pauseIcon) {
                        setState(() => _pauseResumeIcon = Constants.resumeIcon);
                        _timerController.stopTimer();
                        _notificationController.sendNotification(false);
                      } else {
                        setState(() => _pauseResumeIcon = Constants.pauseIcon);
                        _timerController.startTimer();
                        _notificationController.sendNotification(true);
                      }
                    },
                    icon: Icon(_pauseResumeIcon),
                    style: _iconButtonStyle
                  ),
                  IconButton(
                    // Cancel button
                    onPressed: () {
                      _timerController.stopTimer();
                      _notificationController.hideNotification();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel),
                    style: _iconButtonStyle,
                  )
                ]
              ),
            ]
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _notificationController.hideNotification();
    _timerController.dispose();
  }

  /// Switches the active page to the alarm page.
  Future<void> activateAlarmPage() async {
    // This does not need to be awaited here
    _notificationController.hideNotification();

    final navigator = Navigator.of(context);

    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AlarmPage()),
    );

    if (context.mounted) {
      navigator.pop(result);
    }
  }
}