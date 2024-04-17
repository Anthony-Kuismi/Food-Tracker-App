import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/meal_view.dart';
import 'package:food_tracker_app/view/settings_view.dart';
import 'package:food_tracker_app/viewmodel/meal_list_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../viewmodel/daily_viewmodel.dart';
import 'component/macro_pie_chart.dart';

class DailyView extends StatelessWidget {
  DateTime timestamp;

  DailyView({required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DailyViewModel>(context);
    final mealListViewModel = Provider.of<MealListViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.timestamp != timestamp) {
        viewModel.timestamp = timestamp;
        viewModel.init();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Summary', style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: EdgeInsets.only(right: 10.0), // Add padding to the right
                child: IconButton(
                  icon: const Icon(Icons.person, color: Colors.white, size: 25),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsView(
                              username: '',
                            )));
                  },
                  iconSize: 30,
                ),
              ),
            ),
          ),
        ],

      ),
      body: FutureProvider(
        create: (BuildContext context) {
          return viewModel.init(); 
        },
        builder: (context, snapshot) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: () {
                        timestamp = timestamp.subtract(Duration(days: 1));
                        viewModel.previousDay();
                      },
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(viewModel.timestamp),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: () {
                        timestamp = timestamp.add(Duration(days: 1));
                        viewModel.nextDay();
                      },
                    ),
                  ],
                ),
              ),
              MacroPieChart(
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.tertiary,
                viewModel.data.calories,
                viewModel.data.proteinG,
                viewModel.data.carbohydratesTotalG,
                viewModel.data.fatTotalG,
              ),
              ...List.generate(viewModel.meals.length, (index) {
                final meal = viewModel.meals[index];
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: MacroPieChart(
                            Theme.of(context).colorScheme.primaryContainer,
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.tertiary,
                            meal.calories,
                            meal.proteinG,
                            meal.carbohydratesTotalG,
                            meal.fatTotalG,
                            chartRadius: 50,
                            chartValuesOptions: const ChartValuesOptions(showChartValues: false),
                            legendOptions: const LegendOptions(showLegends: false),
                            centerText: '',
                            ringStrokeWidth: 8,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(meal.title),
                              Text(meal.timestampString),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    mealListViewModel.editMeal(meal);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealView(currentMeal: meal)));
                  },
                );
              }),
            ],
          );
        },
        initialData: null, 
      ),
    );
  }
}
