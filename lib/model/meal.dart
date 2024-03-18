import 'food.dart';

class Meal {
  String name;
  Map<String,Food> foods;
  Meal({required this.name, required dynamic json})
      : foods = { for (var item in json['items']) item['id']: Food.fromJson(item) };

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


  void rename(String name) {
    this.name = name;
  }

  Meal.clone(Meal other)
      : name = other.name,
        foods = Map<String, Food>.from(other.foods);

  Meal operator +(Meal other) {
    var newMeal = Meal(name: this.name, json: {'items': []});
    newMeal.foods.addAll(this.foods);

    for (var food in other.foods.values) {
      newMeal.add(food);
    }
    return newMeal;
  }

  Meal operator -(Meal other) {
    var newMeal = Meal(name: this.name, json: {'items': []});
    newMeal.foods.addAll(this.foods);

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
      'name': name,
      'items': foodItemsJson,
    };
  }
}