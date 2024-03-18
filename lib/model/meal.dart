import 'food.dart';

class Meal {
  String name;
  String description;
  List<Food> foods;

  Meal({required this.name, required this.description, required dynamic json})
      : foods = (json['items'] as List)
      .map((item) => Food.fromJson(item))
      .toList();
}