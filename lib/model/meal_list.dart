import 'meal.dart';
import '../Service/firestore_service.dart';

class MealList {
  FirestoreService firestore = FirestoreService();
  List<Meal> meals = [];

  Map<DateTime, List<Meal>> get mealsByDay {
    Map<DateTime,List<Meal>> out = {};
    for(Meal meal in meals){
      if(out[meal.day] != null){
        out[meal.day]!.add(meal);
      }else{
        out[meal.day] = [meal];
      }
    }
    return out;
  }

  Future<void> fetch() async {
    meals = await firestore.getMealsFromUser();
  }
}