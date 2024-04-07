import 'package:food_tracker_app/model/water.dart';
import 'package:intl/intl.dart';

import '../Service/firestore_service.dart';
import 'meal.dart';

class HomePage {
  FirestoreService firestore = FirestoreService();

  Water water =
      Water(date: DateFormat('yyyy-MM-dd').format(DateTime.now()), amount: 0);
  int goal = 10;

  double calories = 0.0;
  double proteinG = 0.0;
  double carbohydratesTotalG = 0.0;
  double fatTotalG = 0.0;



  Future<void> fetchWaterEntry(String date) async {
    water = await FirestoreService().getWaterEntryForUser(date);
    goal = await FirestoreService().getWaterGoalForUser();
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
}
