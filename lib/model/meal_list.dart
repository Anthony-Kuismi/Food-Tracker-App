import 'meal.dart';
import '../Service/FirestoreService.dart';

class MealList {
  FirestoreService firestore = FirestoreService();
  List<Meal> meals = [];
  Future<void> fetch() async{
    meals = await firestore.getMealsFromUser('Default User');
  }
}