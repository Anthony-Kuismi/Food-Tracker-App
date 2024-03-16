import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/searchmodel.dart';
import 'package:food_tracker_app/model/meal.dart';
import 'package:food_tracker_app/viewmodel/meal_viewmodel.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchModel _searchModel = SearchModel();

  Future<List<String>> getSearchResults(String query) {
    return _searchModel.getSearchResults(query);
  }

  Map<String, bool> getChecklistMap(List<String> results){
    return _searchModel.getChecklistMap(results);
  }

  void updateSelectedFoods(Map<String, bool> checklist){
    _searchModel.updateSelectedFoods(checklist);
  }

  void sendSelectedFoods(){
    MealListViewModel().addMeal(Meal(name:'foobar',foods:_searchModel.selectedFoods.join(', ')));
    // _searchModel.sendSelectedFoods();
  }
}