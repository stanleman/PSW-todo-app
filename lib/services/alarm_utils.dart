import 'package:alarm/alarm.dart';

class AlarmUtils {
  AlarmUtils._();

  factory AlarmUtils() => _instance;
  static final AlarmUtils _instance = AlarmUtils._();

  Future<void> setAlarm(DateTime initialDatetime, String name, int id) async {
    DateTime datetime = initialDatetime.subtract(const Duration(minutes: 10));
    try {
      await Alarm.set(
        alarmSettings: AlarmSettings(
          id: id,
          dateTime: datetime,
          assetAudioPath: 'assets/alarm.wav',
          loopAudio: true,
          vibrate: true,
          volume: 0.8,
          fadeDuration: 3.0,
          androidFullScreenIntent: true,
          notificationSettings: NotificationSettings(
            title: '$name is due in less than 10 minutes!',
            body: 'This is a reminder to finish your task before it dues soon.',
            stopButton: 'Stop the alarm',
            icon: 'notification_icon',
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> cancelAlarm(int id) async {
    try {
      await Alarm.stop(id);
    } catch (e) {
      print(e);
    }
  }
}
