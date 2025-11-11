import 'dart:async' show Timer;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pododoro/constants.dart' show Constants;
import 'package:pododoro/main.dart' show localNotificationsPlugin, appPlatform;
import 'package:pododoro/features/alarm_page/alarm_page.dart';
import 'package:pododoro/features/home/home_page.dart' show TimerInfoWidget;
import 'package:permission_handler/permission_handler.dart';
import 'package:pododoro/utilities.dart';
import 'package:timezone/data/latest.dart' as tz_latest;
import 'package:timezone/timezone.dart' as tz;

class CountdownPage extends StatefulWidget {
  final String currentTimerType;
  final int minutes;
  final int seconds;

  const CountdownPage({super.key, required this.currentTimerType, required this.minutes, required this.seconds});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late Timer _mainTimer;
  late int _remainingMinutes;
  late int _remainingSeconds;

  IconData _pauseResumeIcon = Constants.pauseIcon;
  final ButtonStyle _iconButtonStyle = const ButtonStyle(iconSize: WidgetStatePropertyAll(50));

  @override
  void initState() {
    super.initState();

    _remainingMinutes = widget.minutes;
    _remainingSeconds = widget.seconds;
    _mainTimer = _createMainTimer();
    _sendNotification(true);
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
              TimerInfoWidget(text: widget.currentTimerType, minutes: _remainingMinutes, seconds: _remainingSeconds),
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
    _mainTimer.cancel();
  }

  /// Request permission to send notifications. If denied, then do not ask again.
  Future<bool> _requestNotificationsPermission() async {
    PermissionStatus status = await Permission.notification.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      // Try once to get the permission
      return await Permission.notification.request().isGranted;
    }

    return false;
  }

  /// Send a local notification with information about the remaining time.
  ///
  /// This will no-op if the platform is not android nor iOS.
  ///
  /// If the app does not have permission, then this will try and request once. If unsuccessful, then the notification will no longer be sent.
  Future _sendNotification(bool usesChronometer) async {
    if (appPlatform != AppPlatform.android && appPlatform != AppPlatform.ios) return;

    if (!await _requestNotificationsPermission()) return;

    int? when;
    bool chronometerCountDown = false;

    if (usesChronometer) {
      tz_latest.initializeTimeZones();
      tz.TZDateTime time = tz.TZDateTime.now(tz.local).add(Duration(minutes: _remainingMinutes, seconds: _remainingSeconds));
      when = time.millisecondsSinceEpoch;
      chronometerCountDown = true;
    }

    localNotificationsPlugin.show(
      0,
      "Pododoro timer",
      "Tap to reopen the timer",
      NotificationDetails(
        android: AndroidNotificationDetails(
          "timer_channel",
          "Timer channel",
          channelDescription: "Notification channel for timers",
          importance: Importance.max,
          priority: Priority.high,
          when: when,
          usesChronometer: usesChronometer,
          chronometerCountDown: chronometerCountDown,
          ongoing: true,
          onlyAlertOnce: true,
          autoCancel: false,
          enableVibration: false,
          silent: true,
        )
      ),
    );
  }

  /// Creates a timer object based on the remaining seconds.
  Timer _createMainTimer() {
    return Timer.periodic(
      const Duration(seconds: 1), // Fires every second
      (timer) async {
        setState(() {
          if (_remainingSeconds > 0) {
              _remainingSeconds--;
          } else {
            if (_remainingMinutes > 0) {
              _remainingMinutes--;
              _remainingSeconds = 59;
            } else {
              timer.cancel();
            }
          }
        });

        if (!timer.isActive) {
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

    if (_pauseResumeIcon == Constants.pauseIcon) {
      _sendNotification(true);
    } else {
      _sendNotification(false);
    }
  }

}