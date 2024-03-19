import 'package:flutter/material.dart';
import 'login/login.dart';
import 'provider/app_provider.dart';
import 'service/navigator.dart';
import 'view/homepage_view.dart';
import 'view/meal_list_view.dart';
import 'view/search_view.dart';
import '../service/navigator.dart';

void main() {
  final NavigatorService navigatorService = NavigatorService();
  runApp(MyApp(navigatorService: navigatorService));
}

class MyApp extends StatelessWidget {
  final NavigatorService navigatorService;

  const MyApp({super.key, required this.navigatorService});

  @override
  Widget build(BuildContext context) {
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
        home: const LoginApp(title: 'Hot Dog Food Tracker Login'),
        navigatorKey: navigatorService.navigatorKey,
        routes: {
          'MyHomePage': (context) => const MyHomePage(title: 'Hot Dog', username: ''),
          'MealListView': (context) => const MealListView(),
          'SearchView': (context) => const SearchView(),
        },
      ),
    );
  }
}