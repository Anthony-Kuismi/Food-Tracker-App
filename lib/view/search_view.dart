import 'package:food_tracker_app/view/settings_view.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../service/navigator_service.dart';
import '../../service/food_selection_service.dart';
import '../../viewmodel/search_viewmodel.dart';
import '../../viewmodel/meal_list_viewmodel.dart';
import '../model/meal.dart';
import 'component/macro_pie_chart.dart';
import 'custom_food_view.dart';
import 'food_view.dart';
import 'meal_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: true);
    final mealListViewModel =
        Provider.of<MealListViewModel>(context, listen: true);
    final foodSelectionService =
        Provider.of<FoodSelectionService>(context, listen: true);
    final navigatorService =
        Provider.of<NavigatorService>(context, listen: false);

    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) searchViewModel.reset();
        foodSelectionService.update(foodSelectionService.editingMeal!);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Add Foods to Meal',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
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
                  padding: EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon:
                        const Icon(Icons.person, color: Colors.white, size: 25),
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
        body: Column(
          children: [
            SearchBar(viewmodel: searchViewModel),
            SearchResults(
              searchViewModel: searchViewModel,
              foodSelectionService: foodSelectionService,
              navigatorService: navigatorService,
            ),
            AddMealButton(
                searchViewModel: searchViewModel,
                mealListViewModel: mealListViewModel,
                foodSelectionService: foodSelectionService,
                navigatorService: navigatorService),
          ],
        ),
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
          hintText: 'one apple, 1/4 cup almonds',
        ),
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  final SearchViewModel searchViewModel;
  final FoodSelectionService foodSelectionService;
  final NavigatorService navigatorService;

  const SearchResults({
    super.key,
    required this.searchViewModel,
    required this.foodSelectionService,
    required this.navigatorService
  });

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
              bool plural = food.title[food.title.length-1]=='s';
              var quantity = plural ? 'two' : 'one';
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface, 
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Theme.of(context).dividerColor) 
                ),
                child: ListTile(
                  title: Text(
                    food.title,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color), 
                  ),
                  subtitle: (food.custom == true
                      ? Text('[Custom]', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)) 
                      : food.servingSizeG == 100
                      ? Text('Did you mean:\n"$quantity ${food.title}"? "12oz of ${food.title}${plural?'':'s'}?"', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.italic))
                      : null),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoodView(
                                currentFood: food,
                                currentMeal: foodSelectionService.editingMeal!),
                          ));
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: MacroPieChart(
                            Theme.of(context).colorScheme.primaryContainer,
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.tertiary,
                            food.calories,
                            food.proteinG,
                            food.carbohydratesTotalG,
                            food.fatTotalG,
                            chartRadius: 50,
                            chartValuesOptions:
                            const ChartValuesOptions(showChartValues: false),
                            legendOptions: const LegendOptions(showLegends: false),
                            centerText: '',
                            ringStrokeWidth: 8,
                          ),
                        ),
                      ),
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: isSelected,
                        onChanged: (bool? newValue) {
                          searchViewModel.toggleSelection(newValue, food);
                        },
                        side: BorderSide(
                          color: Theme.of(context).dividerColor,
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

  const AddMealButton(
      {super.key,
      required this.searchViewModel,
      required this.mealListViewModel,
      required this.foodSelectionService,
      required this.navigatorService});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MealView(
                    currentMeal: foodSelectionService.editingMeal!,
                  ),
                ));
                if (foodSelectionService.mode == FoodSelectionMode.edit) {
                  Meal oldMeal = foodSelectionService.editingMeal as Meal;
                  mealListViewModel.updateMeal(
                      oldMeal, foodSelectionService.data);
                } else {
                  mealListViewModel.addMeal(
                      searchViewModel.query, searchViewModel.timestamp);
                }
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Update Meal'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CustomFoodView(
                    foodSelectionService: foodSelectionService,
                  ),
                ));
              },
              icon: const Icon(Icons.dashboard_customize, size: 18),
              label: const Text('Add Custom Food'),
            ),
          ],
        ));
  }
}
