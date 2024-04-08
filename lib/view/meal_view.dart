import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/search_view.dart';
import 'package:food_tracker_app/viewmodel/search_viewmodel.dart';
import 'package:provider/provider.dart';
import '../model/meal.dart';
import '../viewmodel/meal_list_viewmodel.dart';
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
    final viewModel = Provider.of<MealListViewModel>(context, listen: false);
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    final foodSelectionService = searchViewModel.foodSelectionService;
    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          searchViewModel.reset();
          foodSelectionService.reset();
        }
      },
      child:Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: const IconThemeData(color: Colors.black),
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
                Text('Total Protein: ${widget.currentMeal.proteinG}g'),
                Text(
                    'Total Carbohydrates: ${widget.currentMeal.carbohydratesTotalG}g'),
                Text('Total Fats: ${widget.currentMeal.fatTotalG}g'),
                MacroPieChart(
                    widget.currentMeal.calories,
                    widget.currentMeal.proteinG,
                    widget.currentMeal.carbohydratesTotalG,
                    widget.currentMeal.fatTotalG),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      'Other Nutrition'),
                ),
                Text('Total Saturated Fats: ${widget.currentMeal.fatSaturatedG}g'),
                Text('Total Fiber: ${widget.currentMeal.fiberG}g'),
                Text('Total Potassium: ${widget.currentMeal.potassiumMG}mg'),
                Text('Total Sodium: ${widget.currentMeal.sodiumMG}mg'),
                Text('Total Sugar: ${widget.currentMeal.sugarG}g'),
                ElevatedButton.icon(
                  onPressed: () {
                    viewModel.editMeal(widget.currentMeal);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SearchView(),
                    ));
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add/Edit Foods'),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
