import 'package:food_tracker_app/model/water.dart';
import 'package:intl/intl.dart';

import '../Service/FirestoreService.dart';

class HomePage {
  FirestoreService firestore = FirestoreService();

  Water water = Water(date: DateFormat('yyyy-MM-dd').format(DateTime.now()), amount: 0);

  Future<void> fetchWaterEntry(String date) async{
    water = await FirestoreService().getWaterEntryForUser(date);
  }
}