import 'package:food_tracker_app/model/water.dart';
import 'package:food_tracker_app/model/weight.dart';
import 'package:intl/intl.dart';
import '../Service/firestore_service.dart';

class HomePage {
  FirestoreService firestore = FirestoreService();

  Water water =
      Water(date: DateFormat('yyyy-MM-dd').format(DateTime.now()), amount: 0, timestamps: []);
  int waterGoal = 10;

  double calories = 0.0;
  double proteinG = 0.0;
  double carbohydratesTotalG = 0.0;
  double fatTotalG = 0.0;

  double weight = 0;
  double weightGoal = 0;
  int lastEntryNumber = 0;
  double lastWeight = 0;

  Future<void> fetchWaterEntry(String date) async {
    water = await FirestoreService().getWaterEntryForUser(date);
    waterGoal = await FirestoreService().getWaterGoalForUser();
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
    this.waterGoal = goal;
  }

  int getWaterGoal() {
    return waterGoal;
  }

  int getWaterAmount() {
    return water.amount;
  }

  List<int> getTimestamps() {
    return water.timestamps;
  }

  Future<void> fetchWeightEntry(String date) async {
    try {
      lastEntryNumber = await FirestoreService().getUserLastWeightEntryNumber();
      print('Last entry number: ${lastEntryNumber}');

      weight = await FirestoreService().getUserWeightInPounds();
      weightGoal = await FirestoreService().getUserWeightGoal();
      print(lastEntryNumber);

      lastWeight = await FirestoreService().getUserWeightByEntry(lastEntryNumber);
      print("firestore request...");
      print('Last weight goal: $lastWeight'); 
    } catch (e) {
      print('Error fetching weight entry: $e');
    }
  }
}
