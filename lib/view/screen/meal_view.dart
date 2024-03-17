import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/navigator.dart';
import '../../model/meal.dart';
import 'package:food_tracker_app/viewmodel/meal_viewmodel.dart';
import '../component/navbar.dart';


class MealListView extends StatelessWidget {
  const MealListView({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorService = Provider.of<NavigatorService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Food Log')),
      body: Consumer<MealListViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.meals.length,
            itemBuilder: (context, index) {
              final meal = viewModel.meals[index];
              return ListTile(
                title: Text(meal.name),
                subtitle: Text('Food Items: ${meal.foods}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => viewModel.removeMeal(meal),
                ),
                onTap: () => _showEditDialog(context, viewModel, meal),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          navigatorService.push('SearchView');
        },

      ),
      bottomNavigationBar: const NavBar(key: Key('customNavBar'),),
    );
  }
  void _showEditDialog(
      BuildContext context, MealListViewModel viewModel, Meal meal) {
    final nameController = TextEditingController(text: meal.name);
    final foodsController = TextEditingController(text: meal.foods);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Meal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: foodsController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              final name = nameController.text;
              final foods = foodsController.text;
              final oldMeal = meal;
              final newMeal = Meal(name: name, foods: foods);
              viewModel.updateMeal(oldMeal, newMeal);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}