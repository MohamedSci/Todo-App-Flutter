import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.high);
  // var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
  const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(
    presentAlert: true,
    // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
    presentBadge: true,
    // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
    presentSound: true,
    // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
    sound: "",
    // Specifics the file path to play (only from iOS 10 onwards)
    badgeNumber: 1,
    // The application's icon badge number
    attachments: [],
    // (only from iOS 10 onwards)
    subtitle: "",
    //Secondary description  (only from iOS 10 onwards)
    threadIdentifier: "", //(only from iOS 10 onwards)
  );

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(
      0,
      'GeeksforGeeks',
      'Your are one step away to connect with GeeksforGeeks',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}
