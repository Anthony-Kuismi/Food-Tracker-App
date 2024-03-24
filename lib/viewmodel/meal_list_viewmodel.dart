import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../model/meal.dart';
import '../model/meal_list.dart';
import '../service/navigator.dart';
import '../service/food_selection.dart';
import '../service/FirestoreService.dart';

class MealListViewModel extends ChangeNotifier{
  final NavigatorService navigatorService;
  final FoodSelectionService foodSelectionService;
  MealListViewModel(this.navigatorService,this.foodSelectionService);
  final MealList _model = MealList();
  List<Meal> get meals => _model.meals;
  var firestore = FirestoreService();

  Future<void> load() async {
    await _model.fetch();
    notifyListeners();
  }

  void addMeal(String title, DateTime timestamp){
    Meal newMeal = foodSelectionService.data;
    // newMeal.rename(title);
    newMeal.entitle();
    newMeal.id = const Uuid().v4();
    newMeal.timestamp = timestamp;
    meals.add(newMeal);
    firestore.addMealToUser('Default User', newMeal.toJson());
    notifyListeners();
  }

  void removeMeal(Meal meal){
    firestore.removeMealFromUser('Default User', meal.id);
    meals.remove(meal);
    notifyListeners();
  }

  void updateMeal(Meal oldMeal, Meal newMeal) {
    newMeal.entitle();
    final index = meals.indexOf(oldMeal);
    meals[index] = newMeal;
    firestore.updateMealForUser('Default User', oldMeal.id, newMeal);
    notifyListeners();
  }

  void editMeal(Meal meal) {
    foodSelectionService.mode = FoodSelectionMode.edit;
    foodSelectionService.editingMeal = meal;
    foodSelectionService.update(meal);
  }
}