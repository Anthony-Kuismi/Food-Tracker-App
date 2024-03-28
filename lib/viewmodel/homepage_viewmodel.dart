import 'package:flutter/cupertino.dart';

import '../Service/FirestoreService.dart';
import '../Service/navigator.dart';
import '../model/homePage.dart';

class HomePageViewModel extends ChangeNotifier {
  late final NavigatorService navigatorService;
  var firestore = FirestoreService();

  //needs to be changed to store data in firestore
  double waterCups = 0.0;
  double waterCupsGoal = 8.0;

  double _waterPercentage = 0.0; // initial value

  double get waterPercentage => _waterPercentage;



  final HomePage _model = HomePage();


  Future<void> load() async {
    var data = await _model.fetch();
    // Do something with data
    notifyListeners();
  }

  void addWater() {
    waterCups++;
    updateWaterPercentage();
  }

  void removeWater() {
    waterCups--;
    updateWaterPercentage();
  }

  void updateWaterPercentage() {

    if (waterCups < 0) {
      waterCups = 0;
    } else if (waterCups > waterCupsGoal) {
      waterCups = waterCupsGoal;
    }

    _waterPercentage = waterCups / waterCupsGoal;

    notifyListeners();
  }

}