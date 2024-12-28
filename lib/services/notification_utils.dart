import 'dart:isolate';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationUtils {
  NotificationUtils._();

  factory NotificationUtils() => _instance;
  static final NotificationUtils _instance = NotificationUtils._();
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
  static ReceivePort? receivePort;

  void requestNotificationPermission(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('We would like to send you notifications.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Don\'t Allow'),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((value) => Navigator.pop(context)),
                child: const Text(
                  'Allow',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Future<void> configuration() async {
    await awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelDescription: 'Basic Instant Notification',
          channelGroupKey: 'basic_channel_group',
        ),
      ],
      debug: true,
    );
  }

  Future<void> createScheduleNotification(
      DateTime initialDatetime, String name, int id) async {
    DateTime datetime = initialDatetime.subtract(const Duration(minutes: 30));
    try {
      await awesomeNotifications.createNotification(
        schedule: NotificationCalendar(
          day: datetime.day,
          month: datetime.month,
          year: datetime.year,
          hour: datetime.hour,
          minute: datetime.minute - 30,
        ),
        content: NotificationContent(
          id: id,
          channelKey: 'basic_channel',
          title: '$name is due in 30 minutes!',
          body: 'This is a reminder to finish your task before it dues.',
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> cancelScheduleNotification(int id) async {
    try {
      await awesomeNotifications.cancelSchedule(id);
    } catch (e) {
      print(e);
    }
  }

  Future<void> showAlarmPage() async {
    try {
      await awesomeNotifications.showAlarmPage();
    } catch (e) {
      print(e);
    }
  }
}
