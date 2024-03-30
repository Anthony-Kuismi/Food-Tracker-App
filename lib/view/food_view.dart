import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../model/food.dart';
import '../service/FirestoreService.dart';
import '../service/navigator.dart';
import './component/marcoPieChart.dart';

class FoodView extends StatefulWidget{
  final Food currentFood;
  const FoodView({super.key, required this.currentFood});

  @override
  FoodViewState createState() => FoodViewState();
}

class FoodViewState extends State<FoodView>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MacroPieChart(widget.currentFood.calories, widget.currentFood.protein_g, widget.currentFood.carbohydrates_total_g, widget.currentFood.fat_total_g),
        ],
      ),
    );
  }
}
