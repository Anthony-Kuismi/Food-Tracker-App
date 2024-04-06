import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/water.dart';
import 'package:intl/intl.dart';

import '../Service/firestore_service.dart';
import '../Service/navigator_service.dart';
import '../model/home_page.dart';

class HomePageViewModel extends ChangeNotifier {
  late final NavigatorService navigatorService;
  var firestore = FirestoreService();

  double _waterPercentage = 0.0; // initial value

  double get waterPercentage => _waterPercentage;
  int get waterCups => _model.getWaterAmount();
  int get waterCupsGoal => _model.getWaterGoal();

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final HomePage _model = HomePage();

  Future<void> load() async {
    date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await _model.fetchWaterEntry(date);
    notifyListeners();
    updateWaterPercentage();
  }

  void addWater() {
    _model.addWater();
    firestore.updateWaterEntryFromUser(Water(date: date, amount: _model.getWaterAmount()));
    updateWaterPercentage();
  }

  void removeWater() {
    _model.removeWater();
    firestore.updateWaterEntryFromUser(Water(date: date, amount: _model.getWaterAmount()));
    updateWaterPercentage();
  }

  void updateWaterPercentage() {

    if (_model.getWaterAmount() < 0) {
      _model.setWaterGoal(0);
    } else if (_model.getWaterAmount() > _model.getWaterGoal()) {
      _waterPercentage = 1.0;
    } else {
      _waterPercentage = _model.getWaterAmount() / _model.getWaterGoal();
    }

    notifyListeners();
  }

  void setWaterGoal(int goal) {
    _model.setWaterGoal(goal);
    firestore.setWaterGoalForUser(goal);
    updateWaterPercentage();
  }
}
