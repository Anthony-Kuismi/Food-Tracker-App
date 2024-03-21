import 'food.dart';
import 'package:intl/intl.dart';


class Meal {
  String title;
  Map<String,Food> foods;
  DateTime timestamp;
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  String get timestampString => dateFormat.format(timestamp);
  int get timestampInt => timestamp.millisecondsSinceEpoch;
  Meal({required dynamic json})
      : title = json['title'],
        timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
        foods = { for (var item in json['items']) item['id']: Food.fromJson(item) };

  void add(Food food){
    if(!foods.containsKey(food.id)) {
      foods[food.id] = food;
    }
  }

  void remove(Food food){
    foods.remove(food.id);
  }

  void update(dynamic json){
    foods = { for (var item in json['items']) item['id']: Food.fromJson(item) };
  }


  String get description{
    return foods.values.map((food)=>food.title).join(', ');
  }

  List<String> get titles {
    return foods.values.map((food)=>food.title).toList();
  }


  void rename(String title) {
    this.title = title;
  }

  Meal.clone(Meal other)
      : title = other.title,
        foods = Map<String, Food>.from(other.foods),
        timestamp = other.timestamp;

  Meal operator +(Meal other) {
    var newMeal = Meal(json: {'items': []});
    newMeal.foods.addAll(foods);

    for (var food in other.foods.values) {
      newMeal.add(food);
    }
    return newMeal;
  }

  Meal operator -(Meal other) {
    var newMeal = Meal(json: {'items': []});
    newMeal.foods.addAll(foods);

    for (var food in other.foods.values) {
      if (newMeal.foods.containsKey(food.id)) {
        newMeal.remove(food);
      }
    }

    return newMeal;
  }

  void addUniqueTitles(Meal b){
    Set<String> titles = this.titles.toSet();
    Iterable<Food> foods = b.foods.values;
    for (var food in foods){
      if(!titles.contains(food.title)){
        add(food);
      }
    }
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> foodItemsJson = foods.values.map((food) => food.toJson()).toList();
    return {
      'name': title,
      'timestamp' : timestampInt,
      'items': foodItemsJson,
    };
  }
}