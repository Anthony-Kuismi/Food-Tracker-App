import 'package:food_tracker_app/model/meal_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../service/navigator.dart';
import '../../service/food_selection.dart';
import '../../viewmodel/search_viewmodel.dart';
import '../../viewmodel/meal_list_viewmodel.dart';
import '../model/meal.dart';
import 'component/navbar.dart';
import 'custom_food_view.dart';
import 'food_view.dart';



class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add Foods to Your Diet',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(key: Key('customNavBar')),

    );
  }
}
