import 'package:flutter/material.dart';
import '../model/food.dart';
import './component/marcoPieChart.dart';
import './component/nutritionRow.dart';

class FoodView extends StatefulWidget{
  final Food currentFood;
  const FoodView({super.key, required this.currentFood});

  @override
  FoodViewState createState() => FoodViewState();
}

class FoodViewState extends State<FoodView>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.primary,
        title: Text(
          widget.currentFood.name,
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
                NutritionRow('Protein: ', widget.currentFood.protein_g,'g'),
                NutritionRow('Carbohydrates: ', widget.currentFood.carbohydrates_total_g, 'g'),
                NutritionRow('Fats: ', widget.currentFood.fat_total_g, 'g'),
                MacroPieChart(widget.currentFood.calories, widget.currentFood.protein_g, widget.currentFood.carbohydrates_total_g, widget.currentFood.fat_total_g),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      'Other Nutrition'
                  ),
                ),
                NutritionRow('Saturated Fat:', widget.currentFood.fat_saturated_g, 'g'),
                NutritionRow('Fiber: ', widget.currentFood.fiber_g, 'g'),
                NutritionRow('Potassium: ', widget.currentFood.potassium_mg, 'mg'),
                NutritionRow('Serving Size: ', widget.currentFood.serving_size_g, 'g'),
                NutritionRow('Sodium: ',widget.currentFood.sodium_mg, 'mg'),
                NutritionRow('Sugar: ',widget.currentFood.fat_saturated_g, 'g'),
              ],
            ),
          )
      ),
    );
  }
}