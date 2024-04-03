import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/food_view.dart';
import 'package:food_tracker_app/view/meal_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_tracker_app/view/custom_food_view.dart';
import 'login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'provider/app_provider.dart';
import 'service/navigator_service.dart';
import 'view/home_page_view.dart';
import 'view/meal_list_view.dart';
import 'view/search_view.dart';

void main() async {
  final NavigatorService navigatorService = NavigatorService();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(navigatorService: navigatorService, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final NavigatorService navigatorService;
  final bool isLoggedIn;

  const MyApp(
      {super.key, required this.navigatorService, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //return SomethingWentWrong(); // Please add this functionality
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return AppProvider(
              navigatorService: navigatorService,
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
                    ? const MyHomePage(
                        title: 'Hot Dog',
                        username: 'User') // Adjust according to your logic
                    : const LoginApp(title: 'Login'),
                navigatorKey: navigatorService.navigatorKey,
                routes: {
                  'MyHomePage': (context) =>
                      const MyHomePage(title: 'Hot Dog', username: ''),
                  'MealListView': (context) => const MealListView(),
                  'SearchView': (context) => const SearchView(),
                  'CustomFoodView': (context) => const CustomFoodView(),
                },
              ),
            );
          }
          return const MaterialApp(
              home: CircularProgressIndicator()); // Loading indicator;
        });
  }
}
