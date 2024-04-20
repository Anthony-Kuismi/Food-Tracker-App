import 'dart:developer';

import 'package:food_tracker_app/service/firestore_service.dart';
import 'package:intl/intl.dart';

import 'meal.dart';

class DataPoint {
  DateTime timestamp;

  String get timestampString =>
      DateFormat('HH:mm MM-dd-yyyy').format(timestamp);
  double value;

  DataPoint({required this.timestamp, required this.value});
}


class Charts {
  DateTime start;
  DateTime end;

  int currentTabIndex = 0;

  int currentDateTabIndex = 0;

  int dateModifier = 0;


  Charts({required this.start, required this.end});
  List<DataPoint> calories = [];
  List<DataPoint> proteinTotalG = [];
  List<DataPoint> carbohydratesTotalG = [];
  List<DataPoint> fatTotalG = [];
  final data = <double>[18, 24, 30, 14, 28];
  List<List<double>> datasets = [
    <double>[18, 24, 30, 14, 28],
    <double>[18, 24, 30, 14, 28],
    <double>[18, 24, 30, 14, 28],
    <double>[18, 24, 30, 14, 28],
    <double>[18, 24, 30, 14, 28],
  ];


  Future<void> init() async {
    await fetchData();
          }

  Future<void> fetchData() async {
            calories = [];
    proteinTotalG = [];
    carbohydratesTotalG = [];
    fatTotalG = [];
    final data = await FirestoreService().getMealsFromUserByTimestampRange(start,end);
    Map<DateTime,Meal> mukbangs = {};
    var date = DateTime(start.year,start.month,start.day);
    var endDate = DateTime(end.year,end.month,end.day);
    while(date.millisecondsSinceEpoch <= endDate.millisecondsSinceEpoch){
      mukbangs[date] = Meal.fromFoodList([]);
      date = date.add(Duration(days:1));
    }
    for(var item in data.entries){
      mukbangs[item.key] = Meal.fromFoodList((item.value.expand((meal) => meal.foods.values).toList()));
          }
    calories.addAll(mukbangs.entries.map<DataPoint>((mukbang)=>DataPoint(timestamp: mukbang.key, value: mukbang.value.calories)));
    proteinTotalG.addAll(mukbangs.entries.map<DataPoint>((mukbang)=>DataPoint(timestamp: mukbang.key, value: mukbang.value.proteinG)));
    carbohydratesTotalG.addAll(mukbangs.entries.map<DataPoint>((mukbang)=>DataPoint(timestamp: mukbang.key, value: mukbang.value.carbohydratesTotalG)));
    fatTotalG.addAll(mukbangs.entries.map<DataPoint>((mukbang)=>DataPoint(timestamp: mukbang.key, value: mukbang.value.fatTotalG)));
      }
}