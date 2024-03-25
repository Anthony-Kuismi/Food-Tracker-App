import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/food.dart';
import '../model/meal.dart';

class FirestoreService {
  Future<void> addMealToUser(String username, Map<String, dynamic> meal) async{
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(meal['id']).set(meal);
  }

  Future<List<Meal>> getMealsFromUser(String username) async{
    List<Meal> mealList = [];
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries')
      .orderBy('timestamp',descending: true);
    final foodEntriesSnapshot = await foodEntries.get();
    final foodEntriesDocuments = foodEntriesSnapshot.docs;
    for(var foodEntry in foodEntriesDocuments){
      mealList.add(Meal(json: foodEntry.data()));
    }
    return mealList;
  }

  Future<void> removeMealFromUser(String username, String id) async{
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(id).delete();
  }

  Future<void> updateMealForUser(String username, String id, Meal newMeal) async{
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(id).update(newMeal.toJson());
  }

  Future<void> addCustomFoodForUser(String username, Food customFood) async{
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Custom Foods');
    print(customFood.id);
    print(customFood.toJson());
    foodEntries.doc(customFood.id).set(customFood.toJson());
  }

  Future<List<Food>> getCustomFoodsFromUser(String username) async{
    List<Food> foodList = [];
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Custom Foods');
    final foodEntriesSnapshot = await foodEntries.get();
    final foodEntriesDocuments = foodEntriesSnapshot.docs;
    for(var foodEntry in foodEntriesDocuments){
      foodList.add(Food.fromJson(foodEntry.data()));
    }
    return foodList;
  }
}
