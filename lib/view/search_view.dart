import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../service/navigator.dart';
import '../../service/food_selection.dart';
import '../../viewmodel/search_viewmodel.dart';
import '../../viewmodel/meal_list_viewmodel.dart';
import '../model/meal.dart';



class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add Foods to Your Diet',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const Column(
        children: [
          SearchBar(),
          SearchResults(),
          AddMealButton(),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<SearchViewModel>(context,listen:false);
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (newQuery) => viewmodel.updateQuery(newQuery),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Add Foods',
        ),

      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context);
    final foods = searchViewModel.searchResults.foods.values.toList();
    return Consumer<FoodSelectionService>(
      builder: (context, foodSelectionService, child) {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final food = foods[index];
              final isSelected = foodSelectionService.isSelected(food);
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CheckboxListTile(
                  title: Text(
                    food.title,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  checkColor: Colors.black,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  value: isSelected,
                  onChanged: (bool? isSelected) {
                    searchViewModel.toggleSelection(isSelected, food);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class AddMealButton extends StatelessWidget {
  const AddMealButton({super.key});
  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context,listen:false);
    final mealListViewModel = Provider.of<MealListViewModel>(context,listen:false);
    final foodSelectionService = Provider.of<FoodSelectionService>(context,listen:false);
    final navigatorService = Provider.of<NavigatorService>(context,listen:false);
    return Container (
      margin: const EdgeInsets.all(16),
      child: ElevatedButton.icon(
      onPressed: () {
        if(foodSelectionService.mode == FoodSelectionMode.edit){
          Meal oldMeal = foodSelectionService.editingMeal as Meal;
          mealListViewModel.updateMeal(oldMeal,foodSelectionService.data);
        }else {
          mealListViewModel.addMeal(searchViewModel.name);
        }
        searchViewModel.reset();
        foodSelectionService.reset();
        navigatorService.pushReplace('MealListView');
      },
      icon: const Icon(Icons.add, size: 18),
      label: const Text('Add Selected Foods'),
      ),
    );
  }
}