import 'meal.dart';
import '../Service/FirestoreService.dart';

class MealList {
  FirestoreService firestore = FirestoreService();
  List<Meal> meals = [];
  MealList(){
    getMealsFromFirestore();
  }
  void getMealsFromFirestore() async{
    meals = await firestore.getMealsFromUser('Default User');
  }
}