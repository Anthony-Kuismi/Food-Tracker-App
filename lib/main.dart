import 'package:flutter/material.dart';
import 'provider/app_provider.dart';
import 'service/navigator.dart';
import 'view/screen/homepage_view.dart';
import 'view/screen/meal_view.dart';
import 'view/screen/search_view.dart';

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
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Hot Dog'),
        navigatorKey: navigatorService.navigatorKey,
        routes: {
          'MyHomePage': (context) => const MyHomePage(title: 'Hot Dog'),
          'MealListView': (context) => const MealListView(),
          'SearchView': (context) => const SearchView(),
        },
      ),
    );
  }
}
