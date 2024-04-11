import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/meal.dart';
import 'package:food_tracker_app/model/water.dart';
import 'package:intl/intl.dart';
import '../Service/firestore_service.dart';
import '../Service/navigator_service.dart';
import '../model/home_page.dart';
import '../model/weight.dart';

class HomePageViewModel extends ChangeNotifier {
  late final NavigatorService navigatorService;
  var firestore = FirestoreService();

  double _waterPercentage = 0.0; 

  double get waterPercentage => _waterPercentage;
  int get waterCups => _model.getWaterAmount();
  int get waterCupsGoal => _model.getWaterGoal();
  double percentChange = 0;

  get calories => _model.calories;
  set calories(newValue) => calories = newValue;
  get carbohydratesTotalG => _model.carbohydratesTotalG;
  set carbohydratesTotalG(newValue) => carbohydratesTotalG = newValue;
  get proteinG => _model.proteinG;
  set proteinG(newValue) => proteinG = newValue;
  get fatTotalG => _model.fatTotalG;
  set fatTotalG(newValue) => fatTotalG = newValue;

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final HomePage _model = HomePage();

  double get weightGoal => _model.weightGoal;
  double get weight => _model.weight;
  int get lastEntryNumber => _model.lastEntryNumber;
  double get lastWeightEntry => _model.lastWeight;


  Future<void> load() async {
    date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await _model.fetchWaterEntry(date);
    await fetchDailyData();
    await _model.fetchWeightEntry(date);
    calcWeightChange();
    updateWaterPercentage();
    notifyListeners();
  }

  Future<void> fetchDailyData({DateTime? day}) async{
    day ??= DateTime.now();
    final meals = await firestore.getMealsFromUserByTimestamp(day);
    _model.calories = 0.0;
    _model.carbohydratesTotalG = 0.0;
    _model.proteinG = 0.0;
    _model.fatTotalG = 0.0;
    for (Meal meal in meals){
      _model.calories += meal.calories;
      _model.carbohydratesTotalG += meal.carbohydratesTotalG;
      _model.proteinG += meal.proteinG;
      _model.fatTotalG += meal.fatTotalG;
    }
  }

  void addWater() {
    _model.addWater();
    firestore.updateWaterEntryFromUser(Water(date: date, amount: _model.getWaterAmount(), timestamps:_model.getTimestamps()));
    updateWaterPercentage();
  }

  void removeWater() {
    _model.removeWater();
    firestore.updateWaterEntryFromUser(Water(date: date, amount: _model.getWaterAmount(), timestamps:_model.getTimestamps()));
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

  void calcWeightChange() {
    percentChange = -((lastWeightEntry - weight) / lastWeightEntry) * 100;
    notifyListeners();
  }

  void setWeightGoal(double goal) {
    _model.weightGoal = goal;
    firestore.setUserWeightGoal(goal);
    notifyListeners();
  }

  void setWeightInPounds(double weight) {
    _model.weight = weight;
    Weight obj = Weight(date: date, weight: weight);
    firestore.setUserWeightInPounds(weight);
    firestore.addWeightEntry(obj, (lastEntryNumber + 2).toString());
    firestore.setUserLastWeightEntry(lastEntryNumber + 1);

    calcWeightChange();
    notifyListeners();
  }
}


