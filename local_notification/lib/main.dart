import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notificationPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initializating setting for anroid
  AndroidInitializationSettings anroidSetting =
      AndroidInitializationSettings('logo');

  // initialization setting for ios
  DarwinInitializationSettings iosSetting =
      DarwinInitializationSettings(defaultPresentSound: true);

  // combined iniialized setting
  InitializationSettings initializationSettings =
      InitializationSettings(android: anroidSetting, iOS: iosSetting);

  bool? initialized =
      await notificationPlugin.initialize(initializationSettings);

  print("notification: $initialized");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // function that triggers when button is pressed
  void showNotification() {
    AndroidNotificationDetails anroidDetails = AndroidNotificationDetails(
        'notifications', 'flutter local notification',
        priority: Priority.max, importance: Importance.max);

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    NotificationDetails combinedDetails =
        NotificationDetails(android: anroidDetails, iOS: iosDetails);

    notificationPlugin.show(0, 'flutter notification',
        'local flutter notification', combinedDetails);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter local notification')),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: showNotification,
                  icon: Icon(Icons.notifications),
                  label: Text('simple notification')),
              SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_active),
                  label: Text('scheduled notification')),
              SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                  label: Text('remove notification'))
            ],
          ),
        ),
      ),
    );
  }
}
