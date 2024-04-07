import 'package:flutter/cupertino.dart';
import 'package:food_tracker_app/model/settings.dart';
import 'package:intl/intl.dart';

import '../Service/firestore_service.dart';
import '../Service/navigator_service.dart';

class SettingsViewModel extends ChangeNotifier {
  late final NavigatorService navigatorService;

  var firestore = FirestoreService();

  


  final Settings _model = Settings();
  String get firstName => _model.firstName;
  String get lastName => _model.lastName;
  int get heightInInches => _model.heightInInches;
  double get weightInPounds => _model.weightInPounds;
  String get birthDate => _model.birthDate;
  String get gender => _model.gender;

  


  Future<void> load() async {
    await _model.fetchSettings();
    notifyListeners();
  }

  String getFirstName() {
    return _model.firstName;
  }

  String getLastName() {
    return _model.lastName;
  }

  int getHeightInInches() {
    return _model.heightInInches;
  }

  double getWeightInPounds() {
    return _model.weightInPounds;
  }

  String getBirthDate() {
    return _model.birthDate;
  }

  String getGender() {
    return _model.gender;
  }



}
