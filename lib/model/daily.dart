import 'dart:developer';

import 'package:food_tracker_app/service/firestore_service.dart';

import 'meal.dart';

class Daily {
  List<Meal> meals = [];
  Meal? data;
  String dailyNote='';


  FirestoreService firestoreService = FirestoreService();

  DateTime timestamp;
  Daily(this.timestamp);


  Future<void> fetchData(DateTime timestamp) async {
        meals = await firestoreService.getMealsFromUserByTimestamp(timestamp);
        data = Meal.fromFoodList(meals.expand((meal) => meal.foods.values).toList());
        dailyNote = await firestoreService.getDailyNote(timestamp);
      }

  Future<void> init() async {
        await fetchData(timestamp);
  }
}