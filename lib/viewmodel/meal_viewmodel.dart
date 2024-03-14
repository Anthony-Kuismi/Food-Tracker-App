import 'package:flutter/material.dart';

import '../model/meal.dart';

class MealListViewModel extends ChangeNotifier {
  final List<Meal> _meals = [];

  List<Meal> get meals => _meals;

  void addMeal(Meal meal) {
    _meals.add(meal);
    notifyListeners();
  }

  void removeMeal(Meal meal) {
    _meals.remove(meal);
    notifyListeners();
  }

  void updateMeal(Meal oldMeal, Meal newMeal) {
    final index = _meals.indexOf(oldMeal);
    _meals[index] = newMeal;
    notifyListeners();
  }
}