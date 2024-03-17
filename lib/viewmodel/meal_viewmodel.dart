import 'package:flutter/material.dart';
import '../model/meal.dart';
import '../service/navigator.dart';
import '../service/food_selection.dart';


class MealListViewModel extends ChangeNotifier {
  final NavigatorService navigatorService;
  final FoodSelectionService foodSelectionService;
  MealListViewModel(this.navigatorService,this.foodSelectionService);
  final MealList _model = MealList();
  List<Meal> get meals => _model.meals;



  void addMeal(){
    Meal newMeal = Meal(name: 'Foodbar', foods: foodSelectionService.selections.join(', '));
    meals.add(newMeal);
    navigatorService.push('MealListView');
    notifyListeners();
  }

  void removeMeal(Meal meal) {
    meals.remove(meal);
    notifyListeners();
  }

  void updateMeal(Meal oldMeal, Meal newMeal) {
    final index = meals.indexOf(oldMeal);
    meals[index] = newMeal;
    notifyListeners();
  }
}