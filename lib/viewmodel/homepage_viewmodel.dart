import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/meal.dart';
import 'package:food_tracker_app/model/water.dart';
import 'package:intl/intl.dart';
import 'package:food_tracker_app/model/food.dart';
import 'package:food_tracker_app/Service/FirestoreService.dart';
import '../Service/FirestoreService.dart';
import '../Service/navigator.dart';
import '../model/homePage.dart';

class HomePageViewModel extends ChangeNotifier {
  late final NavigatorService navigatorService;
  var firestore = FirestoreService();

  //needs to be changed to store data in firestore
  //Water Goal
  int waterCups = 0;
  int waterCupsGoal = 10;

  double _waterPercentage = 0.0; // initial value

  double get waterPercentage => _waterPercentage;

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //Daily Summary
  int totalCalories = 0;
  double _totalProtein = 0.0;
  double _totalCarbs = 0.0;
  double _totalFat = 0.0;
  double get totalProtein => _totalProtein;
  double get totalCarbs => _totalCarbs;
  double get totalFat => _totalFat;



  final HomePage _model = HomePage();


  Future<void> load() async {
    date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await _model.fetchWaterEntry(date);
    notifyListeners();
    waterCups = _model.water.amount;
    waterCupsGoal = firestore.getWaterGoalForUser() as int;
    updateWaterPercentage();
  }

  void addWater() {
    waterCups++;
    updateWaterPercentage();
  }

  void removeWater() {
    waterCups--;
    updateWaterPercentage();
  }

  void updateWaterPercentage() {

    if (waterCups < 0) {
      waterCups = 0;
    } else if (waterCups > waterCupsGoal) {
      _waterPercentage = 1.0;
    } else {
      _waterPercentage = waterCups / waterCupsGoal;
    }

    firestore.updateWaterEntryFromUser(
        Water(date: date, amount: waterCups)
    );

    notifyListeners();
  }

  void setWaterGoal(int goal) {
    waterCupsGoal = goal;
    firestore.setWaterGoalForUser(goal);
    updateWaterPercentage();
  }


    /*for (Meal meal in meals) {
      totalCalories += meal.calories;
      totalProtein += meal.protein;
      totalCarbs += meal.carbs;
      totalFat += meal.fat;
    }*/
    Future <Map<String, double>> calculateDailySummary() async {
      final meals = await firestore.getMealsFromUser();

      double totalCalories = 0.0;
      double totalProtein = 0.0;
      double totalCarbs = 0.0;
      double totalFat = 0.0;

      for (Meal meal in meals) {
        if () {
          totalCalories += meal.calories;
          totalProtein += meal.protein;
          totalCarbs += meal.carbs;
          totalFat += meal.fat;
        }
      }

      return {
        'totalCalories': totalCalories,
        'totalProtein': totalProtein,
        'totalCarbs': totalCarbs,
        'totalFat': totalFat,
      };
    }
}