import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/water.dart';
import 'package:intl/intl.dart';

import '../Service/firestore_service.dart';
import '../Service/navigator_service.dart';
import '../model/home_page.dart';

class HomePageViewModel extends ChangeNotifier {
  late final NavigatorService navigatorService;
  var firestore = FirestoreService();

  //needs to be changed to store data in firestore
  int waterCups = 0;
  int waterCupsGoal = 10;

  double _waterPercentage = 0.0; // initial value

  double get waterPercentage => _waterPercentage;

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final HomePage _model = HomePage();

  Future<void> load() async {
    date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await _model.fetchWaterEntry(date);
    notifyListeners();
    waterCups = _model.water.amount;
    waterCupsGoal = _model.goal;
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

    firestore.updateWaterEntryFromUser(Water(date: date, amount: waterCups));

    notifyListeners();
  }

  void setWaterGoal(int goal) {
    waterCupsGoal = goal;
    firestore.setWaterGoalForUser(goal);
    updateWaterPercentage();
  }
}
