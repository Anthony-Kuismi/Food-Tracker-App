import 'package:food_tracker_app/model/water.dart';
import 'package:intl/intl.dart';
import '../Service/firestore_service.dart';

class HomePage {
  FirestoreService firestore = FirestoreService();

  Water water =
      Water(date: DateFormat('yyyy-MM-dd').format(DateTime.now()), amount: 0, timestamps: []);
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
    water.timestamps.add(DateTime.now().millisecondsSinceEpoch);
  }

  void removeWater() {
    water.amount--;
    water.timestamps.removeLast();
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

  List<int> getTimestamps() {
    return water.timestamps;
  }
}
