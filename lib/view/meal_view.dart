import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/search_view.dart';
import '../model/meal.dart';
import './component/macro_pie_chart.dart';

class MealView extends StatefulWidget {
  final Meal currentMeal;
  const MealView({super.key, required this.currentMeal});

  @override
  MealViewState createState() => MealViewState();
}

class MealViewState extends State<MealView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.currentMeal.title,
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
            ElevatedButton.icon(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchView(),
                  ));
                },
                icon: Icon(Icons.add),
                label: Text('Add/Edit Foods'),
            )
          ],
        ),
      )),
    );
  }
}
