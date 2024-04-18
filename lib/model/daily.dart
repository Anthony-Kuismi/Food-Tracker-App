import 'dart:developer';

import 'package:food_tracker_app/Service/firestore_service.dart';

import 'meal.dart';

class Daily {
  List<Meal> meals = [];
  Meal? data;
  FirestoreService firestoreService = FirestoreService();

  DateTime timestamp;
  Daily(this.timestamp);


  Future<void> fetchData(DateTime timestamp) async {
    log("HELLO!!");
    meals = await firestoreService.getMealsFromUserByTimestamp(timestamp);
    data = Meal.fromFoodList(meals.expand((meal) => meal.foods.values).toList());
    log('DATA FETCHED. DAILY CALORIES: ${data?.calories}');
  }

  Future<void> init() async {
    log("HELLO?!");
    await fetchData(timestamp);
  }
}