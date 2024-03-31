import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/food.dart';
import '../model/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirestoreService {

  Future<void> addMealToUser(Map<String, dynamic> meal) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(meal['id']).set(meal);
  }

  Future<List<Meal>> getMealsFromUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
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

  Future<void> removeMealFromUser(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(id).delete();
  }

  Future<void> updateMealForUser(String id, Meal newMeal) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(id).update(newMeal.toJson());
  }

  Future<void> addCustomFoodForUser(Food customFood) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final foodEntries = FirebaseFirestore.instance.collection('Users/$username/Custom Foods');
    foodEntries.doc(customFood.id).set(customFood.toJson());
  }

  Future<List<Food>> getCustomFoodsFromUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
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
