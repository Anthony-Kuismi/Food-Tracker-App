import 'package:food_tracker_app/model/meal_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../service/navigator.dart';
import '../../service/food_selection.dart';
import '../../viewmodel/search_viewmodel.dart';
import '../../viewmodel/meal_list_viewmodel.dart';
import '../model/meal.dart';
import 'custom_food_view.dart';
import 'food_view.dart';



class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: true);
    final mealListViewModel = Provider.of<MealListViewModel>(context, listen: true);
    final foodSelectionService = Provider.of<FoodSelectionService>(context, listen: true);
    final navigatorService = Provider.of<NavigatorService>(context, listen: false);
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
      body: Column(
        children: [
          SearchBar(viewmodel: searchViewModel),
          SearchResults(searchViewModel: searchViewModel, foodSelectionService: foodSelectionService),
          AddMealButton(searchViewModel: searchViewModel, mealListViewModel: mealListViewModel, foodSelectionService: foodSelectionService, navigatorService: navigatorService),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final SearchViewModel viewmodel;
  const SearchBar({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (newQuery) {
          viewmodel.updateQuery(newQuery);
        },
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
  final SearchViewModel searchViewModel;
  final FoodSelectionService foodSelectionService;
  const SearchResults({super.key, required this.searchViewModel, required this.foodSelectionService});
  @override
  Widget build(BuildContext context) {
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
                child: ListTile(
                  title: Text(
                    food.title,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.info),
                        color: Colors.black,
                        onPressed: () {

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoodView(currentFood: food,),
                          ));
                        },
                      ),
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: isSelected,
                        onChanged: (bool? newValue) {
                          searchViewModel.toggleSelection(newValue, food);
                        },
                        side: BorderSide(

                          color: Colors.grey,

                          width: 1.5,
                        ),
                      ),

                    ],
                  ),
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
  final SearchViewModel searchViewModel;
  final MealListViewModel mealListViewModel;
  final FoodSelectionService foodSelectionService;
  final NavigatorService navigatorService;
  const AddMealButton({super.key, required this.searchViewModel, required this.mealListViewModel, required this.foodSelectionService, required this.navigatorService});
  @override
  Widget build(BuildContext context) {
    return Container (
      margin: const EdgeInsets.all(16),
      child: ElevatedButton.icon(
      onPressed: () {
        if(foodSelectionService.mode == FoodSelectionMode.edit){
          Meal oldMeal = foodSelectionService.editingMeal as Meal;
          mealListViewModel.updateMeal(oldMeal,foodSelectionService.data);
        }else {
          mealListViewModel.addMeal(searchViewModel.query, searchViewModel.timestamp);
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