import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_tracker_app/Service/firestore_service.dart';

class NotificationService extends ChangeNotifier{
  static final NotificationService _notificationService = NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Timer? waterTimer;
  var firestore = FirestoreService();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'hot_dog_channel',
      'Hot Dog Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> showNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'hot_dog_channel',
      'Hot Dog Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, 
      title,
      body,
      platformChannelSpecifics,
    );
  }

  void startWaterTimer() {
     waterTimer = Timer.periodic(const Duration(hours: 2), (Timer timer) async {
       DateTime? lastWater = await firestore.getMostRecentWaterForUser();
       log(DateTime.now().difference(lastWater??DateTime.now()).toString());
       var timeSinceWater = DateTime.now().difference(lastWater??DateTime.now());
       if(timeSinceWater > Duration(hours:2)){
         print("Notification should fire here");
         NotificationService().showNotification(
             title: 'Drink Some Water', body: 'Stay Hydrated its been $timeSinceWater since you drank water');
       }
     });
  }


}