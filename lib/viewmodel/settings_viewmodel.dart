import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/settings.dart';
import 'package:intl/intl.dart';

import '../Service/firestore_service.dart';
import '../Service/navigator_service.dart';

class SettingsViewModel extends ChangeNotifier {
  late final NavigatorService navigatorService;

  var firestore = FirestoreService();

  //needs to be changed to store data in firestore


  final Settings _model = Settings();
  String get firstName => _model.firstName;
  String get lastName => _model.lastName;
  int get heightInInches => _model.heightInInches;
  double get weightInPounds => _model.weightInPounds;
  String get birthDate => _model.birthDate;
  String get gender => _model.gender;

  //List<Meal> get meals => _model.meals;


  Future<void> load() async {
    await _model.fetchSettings();
    notifyListeners();
  }



}
