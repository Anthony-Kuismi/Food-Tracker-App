import 'package:flutter/material.dart';
import '../model/food.dart';

class FoodView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FoodForm(),
    );
  }
}

class FoodForm extends StatefulWidget{
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


  void initState() {
    _nameController = TextEditingController(text: widget.editingFood.title);
    _caloriesController = TextEditingController(text: widget.editingFood.title);
    _proteinController = TextEditingController(text: widget.editingFood.title);
    _carbsController = TextEditingController(text: widget.editingFood.title);
    _servingController = TextEditingController(text: widget.editingFood.title);
    _fatTotalController = TextEditingController(text: widget.editingFood.title);
    _fatSatController = TextEditingController(text: widget.editingFood.title);
    _sodiumController = TextEditingController(text: widget.editingFood.title);
    _potassiumController = TextEditingController(text: widget.editingFood.title);
    _cholesterolController = TextEditingController(text: widget.editingFood.title);
    _fiberController = TextEditingController(text: widget.editingFood.title);
    _sugarController = TextEditingController(text: widget.editingFood.title);





  }

  @override
  Widget build(BuildContext context){
    editingFood = editingFood ?? Food.fromJson({});
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Custom Food'),
      ),
      body: Padding(
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
              decoration: InputDecoration(labelText: 'Total (Grams)'),
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
              onPressed: () {
                // Handle saving the custom food item
                String name = _nameController.text;
                double calories = double.parse(_caloriesController.text);
                double protein = double.parse(_proteinController.text);
                double carbs = double.parse(_carbsController.text);

                // Do something with the data


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


              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
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