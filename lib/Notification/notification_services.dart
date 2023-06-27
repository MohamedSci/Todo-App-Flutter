import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon_todo');
    // ios initialization
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    tz.initializeTimeZones(); // <------
    // the initialization settings are initialized after they are setted
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse : selectNotification,
    // onDidReceiveBackgroundNotificationResponse: selectNotification
    );
  }

   selectNotification(NotificationResponse payload) async {
    //Handle notification tapped logic here
     print('selectNotification');
  }

  Future<void> showNotification(int id, String title, String body, int minutes ) async {
    print("showNotification back 0 minutes${minutes.toString()}");
    try{
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(
            minutes: minutes)), //schedule the notification to show after 2 seconds.
        const NotificationDetails(
          // Android details
          android: AndroidNotificationDetails(
              'main_channel', 'Main Channel', channelDescription: "ashwin",
              importance: Importance.max, priority: Priority.max),
          // iOS details
          iOS: DarwinNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),

        // Type of time interpretation
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle:
        true, // To show notification even when the app is closed
      );
    }catch(e){
      print("showNotification Exception back 0 minutes${minutes.toString()} $e");

    }

  }

  showScheduledNotification({
    @required int id,
    @required String title,
    @required String body,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(days: 3)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
