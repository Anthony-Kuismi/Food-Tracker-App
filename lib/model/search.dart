import 'dart:core';
import 'meal.dart';

class Search {
  String query = '';
  Meal data = Meal(name:'Food Search',json:{'items':[], 'timestamp': Meal.dateFormat.format(DateTime.now())});
  List<String> get searchResults{
    return data.titles;
  }
}