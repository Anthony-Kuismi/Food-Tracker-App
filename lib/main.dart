import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/food_view.dart';
import 'login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/food.dart';
import 'provider/app_provider.dart';
import 'service/navigator.dart';
import 'view/homepage_view.dart';
import 'view/meal_list_view.dart';
import 'view/search_view.dart';
import 'customitem.dart';

void main() {
  final NavigatorService navigatorService = NavigatorService();
  runApp(MyApp(navigatorService: navigatorService));
}

class MyApp extends StatelessWidget {
  final NavigatorService navigatorService;

  const MyApp({super.key, required this.navigatorService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print("could not connect");
          }
          if(snapshot.connectionState== ConnectionState.done){
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
                home: FoodView(),
                navigatorKey: navigatorService.navigatorKey,
                routes: {
                  'MyHomePage': (context) => const MyHomePage(title: 'Hot Dog', username: ''),
                  'MealListView': (context) => const MealListView(),
                  'SearchView': (context) => const SearchView(),
                },
              ),
            );
          }
          Widget loading = MaterialApp();
          return loading;
        });
  }
}