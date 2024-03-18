
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
      title: json['title'],
      id: json['id'],
      name: json['name'],
      calories: json['calories'].toDouble(),
      serving_size_g: json['serving_size_g'].toDouble(),
      fat_total_g: json['fat_total_g'].toDouble(),
      fat_saturated_g: json['fat_saturated_g'].toDouble(),
      protein_g: json['protein_g'].toDouble(),
      sodium_mg: json['sodium_mg'],
      potassium_mg: json['potassium_mg'],
      cholesterol_mg: json['cholesterol_mg'],
      carbohydrates_total_g: json['carbohydrates_total_g'].toDouble(),
      fiber_g: json['fiber_g'].toDouble(),
      sugar_g: json['sugar_g'].toDouble(),
    );
  }
}