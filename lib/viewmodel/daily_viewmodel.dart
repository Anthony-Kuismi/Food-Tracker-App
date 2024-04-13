import 'package:flutter/material.dart';
import '../model/daily.dart';

class DailyViewModel extends ChangeNotifier {
  final Daily _model;

  DailyViewModel(timestamp)
      : _model = Daily(timestamp??DateTime.now()) {
    init();
  }

  DateTime get timestamp => _model.timestamp;


  Future<void> init() async {
    await _model.init();
    notifyListeners();
  }
}