import 'package:flutter/material.dart';
import 'package:food_tracker_app/service/local_notification_service.dart';
import 'package:food_tracker_app/service/navigator.dart';
import 'component/navbar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required String username});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: const Text(
          'Food Tracking: Hotdog Version',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(key: Key('navBar')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              NotificationService().showNotification(title: 'test title',body: 'get bodied');
            }, child: Text('Send Notification'))
          ],
        ),
      ),
    );
  }
}
