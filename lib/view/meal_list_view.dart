import 'package:flutter/material.dart';
import 'package:food_tracker_app/service/food_selection.dart';
import 'package:provider/provider.dart';
import '../service/navigator.dart';
import '../viewmodel/meal_list_viewmodel.dart';
import '../viewmodel/search_viewmodel.dart';
import 'component/navbar.dart';


class MealListView extends StatelessWidget {
  const MealListView({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorService = Provider.of<NavigatorService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diet Log',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<MealListViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.meals.length,
            itemBuilder: (context, index) {
              final meal = viewModel.meals[index];
              return ListTile(
                title: Text(meal.name),
                subtitle: Text('Food Items: ${meal.description}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => viewModel.removeMeal(meal),
                ),
                onTap:(){
                  viewModel.editMeal(meal);
                  navigatorService.push('SearchView');
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          navigatorService.push('SearchView');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const NavBar(key: Key('customNavBar'),),
    );
  }
}