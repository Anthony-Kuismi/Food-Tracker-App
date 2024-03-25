import 'package:flutter/material.dart';
import '../model/food.dart';

class FoodView extends StatelessWidget{
  FoodView({super.key});
  Food? editingFood;
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle saving the custom food item
                String name = _nameController.text;
                double calories = double.parse(_caloriesController.text);
                double protein = double.parse(_proteinController.text);
                double carbs = double.parse(_carbsController.text);

                // Do something with the data4


                _nameController.text = "";
                _caloriesController.text = "";
                _proteinController.text = "";
                _carbsController.text = "";

              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}