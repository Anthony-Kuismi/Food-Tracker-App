import 'package:flutter/material.dart';
import '../model/daily.dart';

class DailyViewModel extends ChangeNotifier {
  final Daily _model;
  bool isLoading = false;

  DailyViewModel(timestamp)
      : _model = Daily(timestamp??DateTime.now()) {
    init();
  }

  DateTime get timestamp => _model.timestamp;

  get data => _model.data;
  set timestamp(newValue) {
    _model.timestamp = newValue;
    notifyListeners();
  }

void nextDay() {
  timestamp = timestamp.add(Duration(days: 1));
  init();
}

void previousDay() {
  timestamp = timestamp.subtract(Duration(days: 1));
  init();
}
  get meals => _model.meals;


  Future<void> init() async {
    isLoading = true;
    await _model.init();
    isLoading = false;
    notifyListeners();
  }
}