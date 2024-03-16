import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/meal.dart';
import 'package:food_tracker_app/viewmodel/meal_viewmodel.dart';
import 'package:food_tracker_app/view/searchbar-view.dart';

class MealListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal List')),
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
                  icon: Icon(Icons.delete),
                  onPressed: () => viewModel.removeMeal(meal),
                ),
                onTap: () => _showEditDialog(context, viewModel, meal),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () { // Wrap the Navigator.push inside a function
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },

      ),
    );
  }
  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final foodsController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Meal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: foodsController,
              decoration: InputDecoration(labelText: 'Foods'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () {
              final name = nameController.text;
              final foods = foodsController.text;
              final meal = Meal(name: name, foods: foods);
              final viewModel =
              Provider.of<MealListViewModel>(context, listen: false);
              viewModel.addMeal(meal);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
  void _showEditDialog( //
      BuildContext context, MealListViewModel viewModel, Meal meal) {
    final nameController = TextEditingController(text: meal.name);
    final foodsController = TextEditingController(text: meal.foods);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Meal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: foodsController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Save'),
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