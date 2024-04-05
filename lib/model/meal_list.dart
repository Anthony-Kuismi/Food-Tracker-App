import 'meal.dart';
import '../Service/firestore_service.dart';

class MealList {
  FirestoreService firestore = FirestoreService();
  List<Meal> meals = [];

  Future<void> fetch() async {
    meals = await firestore.getMealsFromUser();
  }
}
