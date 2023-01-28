import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Notification_Service {
  //static class so we can call it publicly
  //create method for local notification plugin
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    //since we use tz package, initialize first
    tz.initializeTimeZones();

    //initialize android launcher as a notification icon
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    // initialize setting
    var initializeSetting = InitializationSettings(android: androidInitialize);

    //call to initialize notificaiton plugin and use the initializeSetting
    await flutterLocalNotificationsPlugin.initialize(
      initializeSetting,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    //create android notification details to show.
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('id_of_notification', 'channel_Name',
            playSound: true,
            //sound: RawResourceAndroidNotificationSound('notification'),
            importance: Importance.max,
            priority: Priority.high);

    //create android notification
    const notif = NotificationDetails(android: androidNotificationDetails);
    return notif;
  }

  Future showNotification({
    var id = 0,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await FlutterLocalNotificationsPlugin().show(
      0,
      title,
      body,
      details,
    );
  }

  Future showScheduleNotification({
    var id = 0,
    required String title,
    required String body,
    required TimeOfDay timeOfDay,
  }) async {
    final details = await _notificationDetails();
    tz.TZDateTime zonedTime = tz.TZDateTime.local(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            timeOfDay.hour,
            timeOfDay.minute)
        .subtract(DateTime.now().timeZoneOffset);
    //handle if date before now, add 1 day after
    if (zonedTime.isBefore(DateTime.now())) {
      zonedTime = zonedTime.add(const Duration(days: 1));
    }
    await FlutterLocalNotificationsPlugin().zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(zonedTime, tz.local),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
