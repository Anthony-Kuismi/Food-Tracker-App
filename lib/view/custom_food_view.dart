import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../model/food.dart';
import '../service/FirestoreService.dart';
import '../service/navigator.dart';

class CustomFoodView extends StatelessWidget {
  final Food? editingFood;
  const CustomFoodView({Key? key, this.editingFood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Food editingFood = this.editingFood ?? Food.fromJson({});

    return MaterialApp(
      home: FoodForm(editingFood: editingFood),
    );
  }
}

class FoodForm extends StatefulWidget{

  final Food editingFood;
  final FirestoreService firestore = FirestoreService();

  FoodForm({Key? key, required this.editingFood});
  @override
  FoodFormState createState() => FoodFormState();
}

class FoodFormState extends State<FoodForm>{
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
    _caloriesController = TextEditingController(text: widget.editingFood.calories.toString());
    _proteinController = TextEditingController(text: widget.editingFood.protein_g.toString());
    _carbsController = TextEditingController(text: widget.editingFood.carbohydrates_total_g.toString());
    _servingController = TextEditingController(text: widget.editingFood.serving_size_g.toString());
    _fatTotalController = TextEditingController(text: widget.editingFood.fat_total_g.toString());
    _fatSatController = TextEditingController(text: widget.editingFood.fat_saturated_g.toString());
    _sodiumController = TextEditingController(text: widget.editingFood.sodium_mg.toString());
    _potassiumController = TextEditingController(text: widget.editingFood.potassium_mg.toString());
    _cholesterolController = TextEditingController(text: widget.editingFood.cholesterol_mg.toString());
    _fiberController = TextEditingController(text: widget.editingFood.fiber_g.toString());
    _sugarController = TextEditingController(text: widget.editingFood.sugar_g.toString());
  }

  @override
  Widget build(BuildContext context){

    editingFood = editingFood ?? Food.fromJson({});
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Custom Food'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name of Food'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _caloriesController,
                decoration: InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _proteinController,
                decoration: InputDecoration(labelText: 'Protein (Grams)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _carbsController,
                decoration: InputDecoration(labelText: 'Carbs (Grams)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _servingController,
                decoration: InputDecoration(labelText: 'Serivngs'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _fatTotalController,
                decoration: InputDecoration(labelText: 'Total Fat (Grams)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _fatSatController,
                decoration: InputDecoration(labelText: 'Saturated Fat (Grams)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _sodiumController,
                decoration: InputDecoration(labelText: 'Sodium (Grams)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _cholesterolController,
                decoration: InputDecoration(labelText: 'Cholesterol (Grams)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _potassiumController,
                decoration: InputDecoration(labelText: 'Potassium (Grams)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _fiberController,
                decoration: InputDecoration(labelText: 'Fiber (Grams)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _sugarController,
                decoration: InputDecoration(labelText: 'Suger (Grams)'),
                keyboardType: TextInputType.number,
              ),





              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {

                  String name = _nameController.text;
                  double calories = double.parse(_caloriesController.text);
                  double serving_size_g = double.parse(_servingController.text);
                  double fat_total_g = double.parse(_fatTotalController.text);
                  double fat_saturated_g = double.parse(_fatSatController.text);
                  double protein_g = double.parse(_proteinController.text);
                  int sodium_mg = int.parse(_sodiumController.text);
                  int potassium_mg = int.parse(_potassiumController.text);
                  int cholesteral_mg = int.parse(_cholesterolController.text);
                  double carbohydrates_total_g = double.parse(_carbsController.text);
                  double fiber_g = double.parse(_carbsController.text);
                  double sugar_g = double.parse(_sugarController.text);

                  final Food updatedFood = Food(title:'$name [Custom]',id:Uuid().v4(),name:name,calories:calories,serving_size_g: serving_size_g,fat_total_g: fat_total_g,fat_saturated_g: fat_saturated_g,protein_g: protein_g,sodium_mg: sodium_mg,potassium_mg: potassium_mg,cholesterol_mg: cholesteral_mg,carbohydrates_total_g: carbohydrates_total_g,fiber_g: fiber_g,sugar_g: sugar_g);


                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Food Saved'),
                        content: Text('The $name has been saved!'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );

                  _nameController.text = "";
                  _caloriesController.text = "";
                  _proteinController.text = "";
                  _servingController.text = "";
                  _fatTotalController.text = "";
                  _fatSatController.text = "";
                  _sodiumController.text = "";
                  _potassiumController.text = "";
                  _cholesterolController.text = "";
                  _carbsController.text = "";
                  _fiberController.text = "";
                  _sugarController.text = "";

                  await widget.firestore.addCustomFoodForUser('Default User',updatedFood);

                  Provider.of<NavigatorService>(context, listen: false).pushReplace('SearchView');

                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      )
    );
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