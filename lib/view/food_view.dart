import 'package:flutter/material.dart';
import 'package:food_tracker_app/model/meal.dart';
import '../model/food.dart';
import './component/marcoPieChart.dart';
import './component/nutritionRow.dart';

class FoodView extends StatefulWidget{
  final Food currentFood;
  final Meal currentMeal;
  const FoodView({super.key, required this.currentFood, required this.currentMeal});

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
                NutritionRow('Protein: ', currentFood.protein_g,'g',setter: (newValue)=> currentFood.setProteinG = newValue, currentMeal: widget.currentMeal),
                NutritionRow('Carbohydrates: ', currentFood.carbohydrates_total_g,'g',setter: (newValue)=> currentFood.setCarbohydratesTotalG = newValue, currentMeal: widget.currentMeal, ),
                NutritionRow('Fats: ', currentFood.fat_total_g,'g',setter: (newValue)=> currentFood.setFatTotalG = newValue, currentMeal: widget.currentMeal,),
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
                NutritionRow('Saturated Fat:', currentFood.fat_saturated_g, 'g',setter: (newValue)=> currentFood.setFatSaturatedG = newValue, currentMeal: widget.currentMeal, ),
                NutritionRow('Fiber: ', currentFood.fiber_g,'g',setter: (newValue)=> currentFood.fiber_g = newValue, currentMeal: widget.currentMeal,),
                NutritionRow('Potassium: ', currentFood.potassium_mg, 'mg',setter: (newValue)=> currentFood.potassium_mg = newValue, currentMeal: widget.currentMeal,),
                NutritionRow('Serving Size: ', currentFood.serving_size_g, 'g',setter: (newValue)=> currentFood.serving_size_g = newValue, currentMeal: widget.currentMeal,),
                NutritionRow('Sodium: ',currentFood.sodium_mg, 'mg',setter: (newValue)=> currentFood.sodium_mg = newValue, currentMeal: widget.currentMeal,),
                NutritionRow('Sugar: ',currentFood.sugar_g, 'g',setter: (newValue)=> currentFood.setSugarG = newValue, currentMeal: widget.currentMeal,),
              ],
            ),
          )
      ),
    );
  }
}