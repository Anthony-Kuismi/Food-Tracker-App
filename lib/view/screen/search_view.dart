import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../service/navigator.dart';
import '../../service/food_selection.dart';
import '../../viewmodel/search_viewmodel.dart';
import '../../viewmodel/meal_viewmodel.dart';



class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Search'),
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
    return Consumer<FoodSelectionService>(
      builder: (context, foodSelectionService, child) {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: searchViewModel.searchResults.length,
            itemBuilder: (context, index) {
              final food = searchViewModel.searchResults[index];
              final isSelected = foodSelectionService.selections.contains(food);
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CheckboxListTile(
                  title: Text(
                    food,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  checkColor: Theme.of(context).colorScheme.onPrimary,
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
    return ElevatedButton.icon(
      onPressed: () {
        mealListViewModel.addMeal();
        searchViewModel.reset();
        foodSelectionService.reset();
        navigatorService.pushReplace('MealListView');
      },
      icon: const Icon(Icons.add, size: 18),
      label: const Text('Add Selected Foods'),
    );
  }
}