import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:pododoro/features/countdown_page/timer_controller.dart';
import 'package:pododoro/main.dart' show localNotificationsPlugin, appPlatform;
import 'package:pododoro/utilities.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz_latest;
import 'package:timezone/timezone.dart' as tz;

/// Handles sending local notifications to the user's device.
/// 
/// Currently, the id of the local notification will be 0 due to this being the only notification sent by the app.
class NotificationController {
  final TimerController _timerController;

  NotificationController(this._timerController);

  /// Send a local notification with information about the remaining time.
  ///
  /// This will no-op if the platform is not android nor iOS.
  ///
  /// If the app does not have permission, then this will try and request once. If unsuccessful, then the notification will no longer be sent.
  Future sendNotification(bool usesChronometer) async {
    if (appPlatform != AppPlatform.android && appPlatform != AppPlatform.ios) return;

    if (!await _requestNotificationsPermission()) return;

    int? when;
    bool chronometerCountDown = false;

    if (usesChronometer) {
      tz_latest.initializeTimeZones();
      tz.TZDateTime time = tz.TZDateTime.now(tz.local).add(Duration(minutes: _timerController.timeNotifier.value.minutes, seconds: _timerController.timeNotifier.value.seconds));
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

  /// Hides the local notification.
  Future<void> hideNotification() async {
    await localNotificationsPlugin.cancel(0);
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
}