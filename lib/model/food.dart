import 'package:uuid/uuid.dart';

class Food {
  String title;
  String id;
  String name;
  double calories;
  double serving_size_g; //serving_size_g
  double fat_total_g; //fat_total_g
  double fat_saturated_g; //fat_saturated_g
  double protein_g; //protein_g
  int sodium_mg; //sodium_mg
  int potassium_mg; //potassium_mg
  int cholesterol_mg; //cholesterol_mg
  double carbohydrates_total_g; //carbohydrates_total_g
  double fiber_g; //fiber_g
  double sugar_g; //sugar_g

  Food({required this.title, required this.id, required this.name, required this.calories, required this.serving_size_g, required this.fat_total_g, required this.fat_saturated_g, required this.protein_g, required this.sodium_mg, required this.potassium_mg, required this.cholesterol_mg, required this.carbohydrates_total_g, required this.fiber_g, required this.sugar_g});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      title: json['title'] ?? 'New Food',
      id: json['id'] ?? Uuid().v4(),
      name: json['name'] ?? 'New Food',
      calories: json['calories']?.toDouble() ?? 0,
      serving_size_g: json['serving_size_g']?.toDouble() ?? 0.0,
      fat_total_g: json['fat_total_g']?.toDouble() ?? 0.0,
      fat_saturated_g: json['fat_saturated_g']?.toDouble() ?? 0.0,
      protein_g: json['protein_g']?.toDouble() ?? 0.0,
      sodium_mg: json['sodium_mg'] ?? 0,
      potassium_mg: json['potassium_mg'] ?? 0,
      cholesterol_mg: json['cholesterol_mg'] ?? 0,
      carbohydrates_total_g: json['carbohydrates_total_g']?.toDouble() ?? 0.0,
      fiber_g: json['fiber_g']?.toDouble() ?? 0.0,
      sugar_g: json['sugar_g']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'name': name,
      'calories': calories,
      'serving_size_g': serving_size_g,
      'fat_total_g': fat_total_g,
      'fat_saturated_g': fat_saturated_g,
      'protein_g': protein_g,
      'sodium_mg': sodium_mg,
      'potassium_mg': potassium_mg,
      'cholesterol_mg': cholesterol_mg,
      'carbohydrates_total_g': carbohydrates_total_g,
      'fiber_g': fiber_g,
      'sugar_g': sugar_g,
    };
  }

}