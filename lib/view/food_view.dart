import 'package:flutter/material.dart';
import 'package:food_tracker_app/model/meal.dart';
import '../model/food.dart';
import './component/macro_pie_chart.dart';
import './component/nutrition_row.dart';

class FoodView extends StatefulWidget {
  final Food currentFood;
  final Meal currentMeal;

  const FoodView(
      {super.key, required this.currentFood, required this.currentMeal});

  @override
  FoodViewState createState() => FoodViewState();
}

class FoodViewState extends State<FoodView> {
  void updateMacroPieChart(MacroPieChart macroPieChart) {
    setState(() {
      macroPieChart = MacroPieChart(
          widget.currentFood.calories,
          widget.currentFood.proteinG,
          widget.currentFood.carbohydratesTotalG,
          widget.currentFood.fatTotalG);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentFood = widget.currentFood;
    MacroPieChart macroPieChart = MacroPieChart(
        currentFood.calories,
        currentFood.proteinG,
        currentFood.carbohydratesTotalG,
        currentFood.fatTotalG);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
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
              padding: EdgeInsets.all(13.0),
              child: Text(
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  'Macronutrients'),
            ),
            NutritionRow('Protein: ', currentFood.proteinG, 'g',
                setter: (newValue) {
                    currentFood.setProteinG = newValue;
                    updateMacroPieChart(macroPieChart);
                },
                currentMeal: widget.currentMeal),
            NutritionRow(
              'Carbohydrates: ',
              currentFood.carbohydratesTotalG,
              'g',
              setter: (newValue) {
                currentFood.setCarbohydratesTotalG = newValue;
                updateMacroPieChart(macroPieChart);
              },
              currentMeal: widget.currentMeal,
            ),
            NutritionRow(
              'Fats: ',
              currentFood.fatTotalG,
              'g',
              setter: (newValue) {
                currentFood.setFatTotalG = newValue;
                updateMacroPieChart(macroPieChart);
              },
              currentMeal: widget.currentMeal,
            ),
            macroPieChart,
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  'Other Nutrition'),
            ),
            NutritionRow(
              'Saturated Fat:',
              currentFood.fatSaturatedG,
              'g',
              setter: (newValue) {
                currentFood.setFatSaturatedG = newValue;
                updateMacroPieChart(macroPieChart);
              },
              currentMeal: widget.currentMeal,
            ),
            NutritionRow(
              'Fiber: ',
              currentFood.fiberG,
              'g',
              setter: (newValue) {
                currentFood.fiberG = newValue;
                updateMacroPieChart(macroPieChart);
              },
              currentMeal: widget.currentMeal,
            ),
            NutritionRow(
              'Potassium: ',
              currentFood.potassiumMG,
              'mg',
              setter: (newValue) {
                currentFood.potassiumMG = newValue;
                updateMacroPieChart(macroPieChart);
              },
              currentMeal: widget.currentMeal,
            ),
            NutritionRow(
              'Serving Size: ',
              currentFood.servingSizeG,
              'g',
              setter: (newValue) {
                currentFood.servingSizeG = newValue;
                updateMacroPieChart(macroPieChart);
              },
              currentMeal: widget.currentMeal,
            ),
            NutritionRow(
              'Sodium: ',
              currentFood.sodiumMG,
              'mg',
              setter: (newValue) {
                currentFood.sodiumMG = newValue;
                updateMacroPieChart(macroPieChart);
              },
              currentMeal: widget.currentMeal,
            ),
            NutritionRow(
              'Sugar: ',
              currentFood.sugarG,
              'g',
              setter: (newValue) {
                  currentFood.setSugarG = newValue;
                  updateMacroPieChart(macroPieChart);
              },
              currentMeal: widget.currentMeal,
            ),
          ],
        ),
      )),
    );
  }
}
