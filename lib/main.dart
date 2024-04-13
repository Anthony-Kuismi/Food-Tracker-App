import 'package:flutter/material.dart';
import 'package:food_tracker_app/service/local_notification_service.dart';
import 'package:food_tracker_app/view/charts_view.dart';
import 'package:food_tracker_app/view/settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_tracker_app/view/custom_food_view.dart';
import 'login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'provider/app_provider.dart';
import 'service/navigator_service.dart';
import 'view/home_page_view.dart';
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
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            
          }
          if (snapshot.connectionState == ConnectionState.done) {
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
                    ? MyHomePage(
                        title: 'Hot Dog',
                        username: 'User') 
                    : const LoginApp(title: 'Login'),
                navigatorKey: navigatorService.navigatorKey,
                routes: {
                  'MyHomePage': (context) =>
                      MyHomePage(title: 'Hot Dog', username: ''),
                  'MealListView': (context) => const MealListView(),
                  'SearchView': (context) => const SearchView(),
                  'SettingsView': (context) => const SettingsView(username: ''),
                  'CustomFoodView': (context) => CustomFoodView(),
                  'ChartsView' : (context) => ChartsView(),
                },
              ),
            );
          }
          return const MaterialApp(
              home: CircularProgressIndicator()); 
        });
  }



}
