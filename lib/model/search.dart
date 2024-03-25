import 'dart:core';
import 'meal.dart';

class Search {
  String query = '';
  Meal data = Meal(json:{'title': 'Food Search', 'id':'id', 'items':[], 'timestamp': DateTime.now().millisecondsSinceEpoch});
  Meal customFoodData = Meal()
  List<String> get searchResults{
    return data.titles;
  }
}