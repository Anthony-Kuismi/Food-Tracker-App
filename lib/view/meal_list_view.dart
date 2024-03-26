import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/navigator.dart';
import '../viewmodel/meal_list_viewmodel.dart';
import 'component/navbar.dart';

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
                      title: Text(meal.title),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(meal.timestampString),

                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => viewModel.removeMeal(meal),
                      ),
                      onTap: () {
                        viewModel.editMeal(meal);
                        Provider.of<NavigatorService>(context, listen: false).push('SearchView');
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
          Provider.of<NavigatorService>(context, listen: false).push('SearchView');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const NavBar(key: Key('customNavBar')),
    );
  }
}
