import 'package:flutter/material.dart';
import '../../model/food.dart';
import '../food_view.dart';

class NutritionRow extends Row{
  NutritionRow(label, value, measurement, {super.key}) : super(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Protein: $value $measurement'),
        Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,0),
            child: IconButton(
              onPressed: (){
              },
              icon:  const Icon(Icons.edit, size: 18),
            )
        ),
      ]
  );
}