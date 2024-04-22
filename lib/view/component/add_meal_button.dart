import 'package:flutter/material.dart';
import 'package:food_tracker_app/viewmodel/meal_list_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:food_tracker_app/view/search_view.dart';
import 'package:uuid/uuid.dart';

import '../../model/meal.dart';

class AddMealToListButton extends StatelessWidget {
  DateTime? timestamp;

  AddMealToListButton({Key? key, this.timestamp=null}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MealListViewModel>(context, listen: false);

    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: () => _showAddMealDialog(context, viewModel),
      child: const Icon(Icons.add),
    );
  }

  void _showAddMealDialog(BuildContext context, MealListViewModel viewModel) {
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
                if (mealName.isEmpty) {
                  mealName = 'Empty Name';
                }
                dynamic json = {
                  'title': mealName,
                  'id': const Uuid().v4(),
                  'timestamp': timestamp != null?timestamp!.millisecondsSinceEpoch:DateTime.now().millisecondsSinceEpoch,
                  'items': [],
                };
                Meal newMeal = Meal(json: json);
                viewModel.addMealFromMeal(newMeal);
                viewModel.editMeal(newMeal);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SearchView()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
