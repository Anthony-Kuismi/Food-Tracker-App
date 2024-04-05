import 'dart:async';

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
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
    );
  }

  void startWaterTimer() {
     waterTimer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
       DateTime lastWater = await firestore.getMostRecentWaterForUser();
       if(DateTime.now().difference(lastWater) > Duration(seconds:10)){
         //push notification
         NotificationService().showNotification(
             title: 'WATER NOW', body: 'Chug some wata');
       }
       //debugPrint('test');
       //   if (time since water added is to long) {

       //   }else{
       //   NotificationService().showNotification(
       //     //                           title: 'Nice job staying hydrated', body: 'drink wata accomplished!');
       //   }
       //
       // }
     });
  }


}


//notification sends after a certain time
//1) user adds water
//2) time stamp is attached to that action
//3) time stamp is checked every interval
//4) if time stamp shows its been to long a notification to drink more water is sent
//4) repeat
