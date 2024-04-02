import 'package:flutter/material.dart';
import '../model/food.dart';
import './component/marcoPieChart.dart';
import './component/nutritionRow.dart';

class FoodView extends StatefulWidget{
  final Meal currentMeal
  final Food currentFood;
  const FoodView({super.key, required this.currentFood});

  @override
  FoodViewState createState() => FoodViewState();
}

class FoodViewState extends State<FoodView>{
  @override
  Widget build(BuildContext context) {
    final currentFood = widget.currentFood;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.primary,
        title: Text(
          currentFood.name,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      'Macronutrients'
                  ),
                ),
                NutritionRow('Protein: ', currentFood.protein_g,'g'),
                NutritionRow('Carbohydrates: ', currentFood.carbohydrates_total_g, 'g'),
                NutritionRow('Fats: ', currentFood.fat_total_g, 'g'),
                MacroPieChart(currentFood.calories, currentFood.protein_g, currentFood.carbohydrates_total_g, currentFood.fat_total_g),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      'Other Nutrition'
                  ),
                ),
                NutritionRow('Saturated Fat:', currentFood.fat_saturated_g, 'g'),
                NutritionRow('Fiber: ', currentFood.fiber_g, 'g'),
                NutritionRow('Potassium: ', currentFood.potassium_mg, 'mg'),
                NutritionRow('Serving Size: ', currentFood.serving_size_g, 'g'),
                NutritionRow('Sodium: ',currentFood.sodium_mg, 'mg'),
                NutritionRow('Sugar: ',currentFood.fat_saturated_g, 'g'),
              ],
            ),
          )
      ),
    );
  }
}