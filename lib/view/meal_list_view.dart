import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/component/macro_pie_chart.dart';
import 'package:food_tracker_app/view/search_view.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../model/meal.dart';
import '../viewmodel/meal_list_viewmodel.dart';
import 'component/navbar.dart';
import 'meal_view.dart';

class MealListView extends StatelessWidget {
  const MealListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MealListViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet Log', style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
        future: viewModel.load(),
        builder: (context, snapshot) {
          return Consumer<MealListViewModel>(
            builder: (context, viewModel, child) {
              return ListView.builder(
                itemCount: viewModel.meals.length,
                itemBuilder: (context, index) {
                  final meal = viewModel.meals[index];
                  return ListTile(
                    title: Row( 
                      children: [
                        SizedBox( 
                          width: 50,
                          height: 50,
                          child: MacroPieChart(
                            meal.calories,
                            meal.proteinG,
                            meal.carbohydratesTotalG,
                            meal.fatTotalG,
                            chartRadius: 50,
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValues: false,
                            ),
                            legendOptions: const LegendOptions(
                              showLegends: false,
                            ),
                            centerText: '',
                            ringStrokeWidth: 8
                          ),
                        ),
                        Padding( 
                          padding: const EdgeInsets.only(left: 8.0), 
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(meal.title),
                                Text(meal.timestampString),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => viewModel.removeMeal(meal),
                    ),
                    onTap: () {
                      viewModel.editMeal(meal);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MealView(currentMeal: meal),
                      ));
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                TextEditingController controller = TextEditingController();
                return AlertDialog(
                  title: const Text('Adding New Meal'),
                  content: TextField(
                    controller: controller,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Meal Name',
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        String mealName = controller.text;
                        if(mealName == ''){
                          mealName = 'Empty Name';
                        }
                        dynamic json = {
                          'title': mealName,
                          'id': const Uuid().v4(),
                          'timestamp': DateTime.now().millisecondsSinceEpoch,
                          'items': [],
                        };
                        Meal newMeal = Meal(json: json);
                        viewModel.addMealFromMeal(newMeal);
                        viewModel.editMeal(newMeal);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SearchView()));
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const NavBar(key: Key('customNavBar')),
    );
  }
}
