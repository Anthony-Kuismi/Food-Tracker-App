import 'package:flutter/cupertino.dart';

import '../Service/FirestoreService.dart';
import '../Service/navigator.dart';
import '../model/homePage.dart';

class HomePageViewModel extends ChangeNotifier {
  late final NavigatorService navigatorService;
  var firestore = FirestoreService();

  double _waterPercentage = 0.5; // initial value

  double get waterPercentage => _waterPercentage;

  final homePage _model = homePage();


  Future<void> load() async {
    await _model.fetch();
    notifyListeners();
  }

  //needs to be changed to store data in firestore
  int waterCups = 0;
  void addWater() {
    waterCups++;
    updateWaterPercentage();
  }

  void removeWater() {
    waterCups--;
    updateWaterPercentage();
  }

  void updateWaterPercentage() {
    _waterPercentage += 0.1;
    if (_waterPercentage > 1) {
      _waterPercentage = 1;
    }
    notifyListeners();
  }

}