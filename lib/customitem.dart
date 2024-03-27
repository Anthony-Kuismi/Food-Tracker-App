import 'package:flutter/material.dart';
import '../model/food.dart';

class CustomFoodPage extends StatefulWidget {
  @override
  _CustomFoodPageState createState() => _CustomFoodPageState();
}

class _CustomFoodPageState extends State<CustomFoodPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

                String name = _nameController.text;
                double calories = double.parse(_caloriesController.text);
                double protein = double.parse(_proteinController.text);
                double carbs = double.parse(_carbsController.text);




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

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    super.dispose();
  }
}