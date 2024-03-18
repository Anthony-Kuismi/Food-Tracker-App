import 'package:flutter/cupertino.dart';

class FoodSelectionService extends ChangeNotifier {
  Set<String> _selections = {};
  dynamic data = {
    'items' : [],
  };
  Set<String> get selections => _selections;


  void addSelectedFood(String food) {
    selections.add(food);
  }

  void removeSelectedFood(String food) {
    selections.remove(food);
  }

  void reset(){
    _selections = {};
    data = {
      'items' : [],
    };
  }

  void toggleFoodSelection(String food) {
    if (_selections.contains(food)) {
      _selections.remove(food);
    } else {
      _selections.add(food);
    }
    notifyListeners();
  }
}
