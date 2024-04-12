import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/search_view.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../model/food.dart';
import '../service/firestore_service.dart';
import '../service/navigator_service.dart';

class CustomFoodView extends StatelessWidget {
  final Food? editingFood;

  const CustomFoodView({Key? key, this.editingFood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Food editingFood = this.editingFood ?? Food.fromJson({});

    return FoodForm(editingFood: editingFood);
  }
}

class FoodForm extends StatefulWidget {
  final Food editingFood;
  final FirestoreService firestore = FirestoreService();

  FoodForm({super.key, required this.editingFood});

  @override
  FoodFormState createState() => FoodFormState();
}

class FoodFormState extends State<FoodForm> {
  Food? editingFood;
  late TextEditingController _nameController;
  late TextEditingController _caloriesController;
  late TextEditingController _servingController;
  late TextEditingController _fatTotalController;
  late TextEditingController _fatSatController;
  late TextEditingController _proteinController;
  late TextEditingController _sodiumController;
  late TextEditingController _potassiumController;
  late TextEditingController _cholesterolController;
  late TextEditingController _carbsController;
  late TextEditingController _fiberController;
  late TextEditingController _sugarController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.editingFood.title);
    _caloriesController =
        TextEditingController(text: widget.editingFood.calories.toString());
    _proteinController =
        TextEditingController(text: widget.editingFood.proteinG.toString());
    _carbsController = TextEditingController(
        text: widget.editingFood.carbohydratesTotalG.toString());
    _servingController =
        TextEditingController(text: widget.editingFood.servingSizeG.toString());
    _fatTotalController =
        TextEditingController(text: widget.editingFood.fatTotalG.toString());
    _fatSatController = TextEditingController(
        text: widget.editingFood.fatSaturatedG.toString());
    _sodiumController =
        TextEditingController(text: widget.editingFood.sodiumMG.toString());
    _potassiumController =
        TextEditingController(text: widget.editingFood.potassiumMG.toString());
    _cholesterolController = TextEditingController(
        text: widget.editingFood.cholesterolMG.toString());
    _fiberController =
        TextEditingController(text: widget.editingFood.fiberG.toString());
    _sugarController =
        TextEditingController(text: widget.editingFood.sugarG.toString());
  }

  @override
  Widget build(BuildContext context) {
    final navigatorService =
        Provider.of<NavigatorService>(context, listen: false);
    editingFood = editingFood ?? Food.fromJson({});
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Custom Food'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name of Food'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _caloriesController,
                  decoration: const InputDecoration(labelText: 'Calories'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _proteinController,
                  decoration:
                      const InputDecoration(labelText: 'Protein (Grams)'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _carbsController,
                  decoration: const InputDecoration(labelText: 'Carbs (Grams)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _servingController,
                  decoration: const InputDecoration(labelText: 'Servings'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _fatTotalController,
                  decoration:
                      const InputDecoration(labelText: 'Total Fat (Grams)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _fatSatController,
                  decoration:
                      const InputDecoration(labelText: 'Saturated Fat (Grams)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _sodiumController,
                  decoration:
                      const InputDecoration(labelText: 'Sodium (Grams)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _cholesterolController,
                  decoration:
                      const InputDecoration(labelText: 'Cholesterol (Grams)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _potassiumController,
                  decoration:
                      const InputDecoration(labelText: 'Potassium (Grams)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _fiberController,
                  decoration: const InputDecoration(labelText: 'Fiber (Grams)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _sugarController,
                  decoration: const InputDecoration(labelText: 'Sugar (Grams)'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String name = _nameController.text;
                    double calories = double.parse(_caloriesController.text);
                    double servingSizeG = double.parse(_servingController.text);
                    double fatTotalG = double.parse(_fatTotalController.text);
                    double fatSaturatedG = double.parse(_fatSatController.text);
                    double proteinG = double.parse(_proteinController.text);
                    int sodiumMg = int.parse(_sodiumController.text);
                    int potassiumMg = int.parse(_potassiumController.text);
                    int cholesteralMg = int.parse(_cholesterolController.text);
                    double carbohydratesTotalG =
                        double.parse(_carbsController.text);
                    double fiberG = double.parse(_carbsController.text);
                    double sugarG = double.parse(_sugarController.text);

                    final Food updatedFood = Food(
                        title: name,
                        id: const Uuid().v4(),
                        name: name,
                        calories: calories,
                        servingSizeG: servingSizeG,
                        fatTotalG: fatTotalG,
                        fatSaturatedG: fatSaturatedG,
                        proteinG: proteinG,
                        sodiumMG: sodiumMg,
                        potassiumMG: potassiumMg,
                        cholesterolMG: cholesteralMg,
                        carbohydratesTotalG: carbohydratesTotalG,
                        fiberG: fiberG,
                        sugarG: sugarG,
                        custom: true);

                    await widget.firestore.addCustomFoodForUser(updatedFood);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SearchView(), // Replace MealView with CustomFoodView
                    ));
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _servingController.dispose();
    _fatTotalController.dispose();
    _fatSatController.dispose();
    _proteinController.dispose();
    _sodiumController.dispose();
    _potassiumController.dispose();
    _cholesterolController.dispose();
    _carbsController.dispose();
    _fiberController.dispose();
    _sugarController.dispose();
    super.dispose();
  }
}
