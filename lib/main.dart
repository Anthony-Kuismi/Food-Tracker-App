import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_tracker_app/service/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'provider/app_provider.dart';
import 'service/navigator.dart';
import 'view/homepage_view.dart';
import 'view/meal_list_view.dart';
import 'view/search_view.dart';
import 'dart:developer';


void main() async {
  final NavigatorService navigatorService = NavigatorService();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final NotificationService notificationService = NotificationService();

  runApp(MyApp(navigatorService: navigatorService, isLoggedIn: isLoggedIn, notificationService: notificationService,));
}

class MyApp extends StatelessWidget {
  final NavigatorService navigatorService;
  final bool isLoggedIn;
  final NotificationService notificationService;


  const MyApp({super.key, required this.navigatorService, required this.isLoggedIn, required this.notificationService});

  @override
  Widget build(BuildContext context) {
  log("test123");
    notificationService.startWaterTimer();
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print("Could not connect to Firebase");
            //return SomethingWentWrong(); // Please add this functionality
          }
          if(snapshot.connectionState== ConnectionState.done){
            return AppProvider(
              navigatorService: navigatorService,
              notificationService: notificationService,
              child: MaterialApp(
                title: 'Food Tracker App',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurpleAccent,
                    brightness: Brightness.dark,
                  ),
                  primarySwatch: Colors.blue,
                ),
                home: isLoggedIn
                    ? const MyHomePage(title: 'Hot Dog', username: 'User') // Adjust according to your logic
                    : const LoginApp(title: 'Login'),
                navigatorKey: navigatorService.navigatorKey,
                routes: {
                  'MyHomePage': (context) => const MyHomePage(title: 'Hot Dog', username: ''),
                  'MealListView': (context) => const MealListView(),
                  'SearchView': (context) => const SearchView(),
                },
              ),
            );
          }
          return const MaterialApp(home: CircularProgressIndicator()); // Loading indicator;
        });
  }



}
