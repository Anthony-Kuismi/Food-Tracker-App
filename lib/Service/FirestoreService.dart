import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/meal.dart';

class FirestoreService {
  Future<void> addMealToUser(String username, Map<String, dynamic> meal) async{
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(meal.id).set(meal);
  }

  Future<List<Meal>> getMealsFromUser(String username) async{
    List<Meal> mealList = [];
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    final foodEntriesSnapshot = await foodEntries.get();
    final foodEntriesDocuments = foodEntriesSnapshot.docs;
    for(var foodEntry in foodEntriesDocuments){
      mealList.add(Meal(name: foodEntry.get('name'), json: foodEntry.data()));
    }
    return mealList;
  }

  Future<void> removeMealFromUser(String username, String id) async{
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    
  }
}
