import 'package:food_tracker_app/model/water.dart';
import 'package:intl/intl.dart';

import '../Service/firestore_service.dart';
import 'meal.dart';

class HomePage {
  FirestoreService firestore = FirestoreService();

  Water water =
      Water(date: DateFormat('yyyy-MM-dd').format(DateTime.now()), amount: 0);
  int goal = 10;

  dynamic dailyData;

  Future<void> fetchWaterEntry(String date) async {
    water = await FirestoreService().getWaterEntryForUser(date);
    goal = await FirestoreService().getWaterGoalForUser();
  }

  Future<void> fetchDailyData() async{
    dailyData = await calculateDailySummary();
  }

  void addWater() {
    water.amount++;
  }

  void removeWater() {
    water.amount--;
  }

  void setWaterGoal(int goal) {
    this.goal = goal;
  }

  int getWaterGoal() {
    return goal;
  }

  int getWaterAmount() {
    return water.amount;
  }

  Future  calculateDailySummary() async {
    final meals = await firestore.getMealsFromUserByTimestamp(DateTime.now());

    double totalCalories = 0.0;
    double totalProtein = 0.0;
    double totalCarbs = 0.0;
    double totalFat = 0.0;

    for (Meal meal in meals) {
      if (true) {
        totalCalories += meal.calories;
        totalProtein += meal.proteinG;
        totalCarbs += meal.carbohydratesTotalG;
        totalFat += meal.fatTotalG;
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
