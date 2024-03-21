import 'dart:core';
import 'meal.dart';

class Search {
  String query = '';
  Meal data = Meal(name:'Food Search',json:{'items':[], 'id':'id'});
  List<String> get searchResults{
    return data.titles;
  }

}