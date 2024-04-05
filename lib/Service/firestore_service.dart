import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../model/food.dart';
import '../model/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/water.dart';

class FirestoreService {
  Future<void> addMealToUser(Map<String, dynamic> meal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final foodEntries =
        FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(meal['id']).set(meal);
  }

  Future<List<Meal>> getMealsFromUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    List<Meal> mealList = [];
    final foodEntries = FirebaseFirestore.instance
        .collection('Users/$username/Food Entries')
        .orderBy('timestamp', descending: true);
    final foodEntriesSnapshot = await foodEntries.get();
    final foodEntriesDocuments = foodEntriesSnapshot.docs;
    for (var foodEntry in foodEntriesDocuments) {
      mealList.add(Meal(json: foodEntry.data()));
    }
    return mealList;
  }

  Future<void> removeMealFromUser(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    final foodEntries =
        FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(id).delete();
  }

  Future<void> updateMealForUser(String id, Meal newMeal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final foodEntries =
        FirebaseFirestore.instance.collection('Users/$username/Food Entries');
    foodEntries.doc(id).update(newMeal.toJson());
  }

  Future<void> addCustomFoodForUser(Food customFood) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final foodEntries =
        FirebaseFirestore.instance.collection('Users/$username/Custom Foods');
    foodEntries.doc(customFood.id).set(customFood.toJson());
  }

  Future<List<Food>> getCustomFoodsFromUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    List<Food> foodList = [];
    final foodEntries =
        FirebaseFirestore.instance.collection('Users/$username/Custom Foods');
    final foodEntriesSnapshot = await foodEntries.get();
    final foodEntriesDocuments = foodEntriesSnapshot.docs;
    for (var foodEntry in foodEntriesDocuments) {
      foodList.add(Food.fromJson(foodEntry.data()));
    }
    return foodList;
  }

  Future<void> updateWaterEntryFromUser(Water water) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final waterEntries =
        FirebaseFirestore.instance.collection('Users/$username/Water Entries');
    waterEntries.doc(water.date.toString()).update(water.toJson());
  }

  Future<void> addWaterEntryForUser(Water water) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final waterEntries =
        FirebaseFirestore.instance.collection('Users/$username/Water Entries');
    waterEntries.doc(water.date.toString()).set(water.toJson());
  }

  Future<Water> getWaterEntryForUser(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final waterEntries =
        FirebaseFirestore.instance.collection('Users/$username/Water Entries');
    final waterEntry = await waterEntries.doc(date.toString()).get();

    if (!waterEntry.exists) {
      addWaterEntryForUser(Water(date: date, amount: 0, timestamps: []));
      return Water(date: date, amount: 0, timestamps: []);
    } else {
      return Water.fromJson(waterEntry.data() ?? {});
    }
  }

  Future<void> setWaterGoalForUser(int goal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final waterGoal = FirebaseFirestore.instance.collection('Users');
    waterGoal.doc('$username').update({'Water Goal': goal});
  }

  Future<int> getWaterGoalForUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final waterGoal = FirebaseFirestore.instance.collection('Users');
    final waterGoalDoc = await waterGoal.doc('$username').get();
    return waterGoalDoc.data()!['Water Goal'];
  }

  Future<List<Map<String, String>>> getUsersFromFirestore() async {
    List<Map<String, String>> users = [];
    final firestoreUsers = FirebaseFirestore.instance.collection('Users');
    final usersSnapshot = await firestoreUsers.get();
    final usersDocuments = usersSnapshot.docs;
    for (var user in usersDocuments) {
      users.add({'username': user.id, 'password': user.get('Password')});
    }
    return users;
  }

  Future<int> getUserHeightInInches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final user = FirebaseFirestore.instance.collection('Users');
    final userDoc = await user.doc('$username').get();
    return userDoc.data()!['Height'];
  }

  Future<String> getUserBirthdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final user = FirebaseFirestore.instance.collection('Users');
    final userDoc = await user.doc('$username').get();
    return userDoc.data()!['Birthdate'];
  }

  Future<String> getUserFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final user = FirebaseFirestore.instance.collection('Users');
    final userDoc = await user.doc('$username').get();
    return userDoc.data()!['First Name'];
  }

  Future<String> getUserLastName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final user = FirebaseFirestore.instance.collection('Users');
    final userDoc = await user.doc('$username').get();
    return userDoc.data()!['Last Name'];
  }

  Future<double> getUserWeightInPounds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final user = FirebaseFirestore.instance.collection('Users');
    final userDoc = await user.doc('$username').get();
    return (userDoc.data()!['Weight'] as num).toDouble();
  }

  Future<String> getUserGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final user = FirebaseFirestore.instance.collection('Users');
    final userDoc = await user.doc('$username').get();
    return userDoc.data()!['Gender'];
  }



  Future<int> getMostRecentWaterForUser() async {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final waterEntries =
    FirebaseFirestore.instance.collection('Users/$username/Water Entries').orderBy('Date',descending: true);
    final waterEntry = await waterEntries.doc(date.toString()).get();
    if (waterEntry.exists) {
      return DateTime.fromMillisecondsSinceEpoch(Water.fromJson(waterEntry.data() ?? {}).timestamps.last);
    }else{
      return null;
    }

  }
}
