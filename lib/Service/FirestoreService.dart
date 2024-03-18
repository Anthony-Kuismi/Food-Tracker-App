import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> addMealToUser(String username, Map<String, dynamic> meal) async{
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.add(meal);
  }
}
