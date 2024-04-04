import 'package:intl/intl.dart';

import '../Service/firestore_service.dart';

class HomePage {
  FirestoreService firestore = FirestoreService();

  String firstName = '';
  String lastName = '';
  int heightInInches = 0;
  double weightInPounds = 0;
  String birthDate = '';
  String gender = '';

  Future<void> fetchWaterEntry(String date) async {
    water = await FirestoreService().getWaterEntryForUser(date);
    goal = await FirestoreService().getWaterGoalForUser();
  }
}
