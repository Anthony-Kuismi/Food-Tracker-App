import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../model/meal.dart';
import '../service/navigator_service.dart';
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MealView(currentMeal: meal,),
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
                        Navigator.of(context).pop();
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
