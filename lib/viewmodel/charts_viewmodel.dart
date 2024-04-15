import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/charts.dart';

enum ChartsViewMode {
  DAILY,
  WEEKLY,
  MONTHLY
}

class ChartsViewModel extends ChangeNotifier {
  Charts _model;
  ChartsViewModel({required DateTime start, required DateTime end}):_model = Charts(start:start,end:end){
    _initializeChartsModel();
  }

  Future<void> _initializeChartsModel() async {
    await _model.init();
    notifyListeners();
  }

  get data =>  _model.data;

  get dataSets => _model.datasets;

  late TabController _tabController;
  get tabController=>_tabController;

  get calories => null;

  get proteinTotalG => null;

  get carbohydratesTotalG => null;

  get fatsTotalG => null;


  set tabController(newValue)=>_tabController=newValue;

  List<String> labels = ['Calories','Protein','Carbohydrates','Fat'];

  get start =>  _model.start;
  get end => _model.end;
  set start(newValue)=>_model.start = newValue;
  set end(newValue)=>_model.end = newValue;

  Future<void> updateStart(DateTime start) async {
    this.start=start;
    notifyListeners();
  }

  Future<void> updateEnd(DateTime end) async {
    this.end=end;
    notifyListeners();
  }
}