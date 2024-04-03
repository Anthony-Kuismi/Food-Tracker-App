import 'package:flutter/material.dart';
import 'package:food_tracker_app/model/meal.dart';
import 'package:provider/provider.dart';
import '../Service/food_selection_service.dart';
import '../viewmodel/meal_list_viewmodel.dart';
import './component/marco_pie_chart.dart';

class MealView extends StatefulWidget {

  const MealView(
      {super.key});

  @override
  MealViewState createState() => MealViewState();
}

class MealViewState extends State<MealView> {
  @override
  Widget build(BuildContext context) {
    //final foodSelectionService = Provider.of<FoodSelectionService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Empty',
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
                      'Macronutrient Totals'),
                ),
                Text('Total Protein: 10g'),
                Text('Total Carbohydrates: 10g'),
                Text('Total Fats: 10g'),
                MacroPieChart(10, 10, 10, 10),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      'Other Nutrition'),
                ),
                Text('Total Saturated Fats: 10g'),
                Text('Total Fiber: 10g'),
                Text('Total Potassium: 10g'),
                Text('Total Sodium: 10g'),
                Text('Total Sugar: 10g'),
              ],
            ),
          )),
    );
  }
}
