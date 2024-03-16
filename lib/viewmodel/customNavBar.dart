import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/meal_view.dart';
import 'package:food_tracker_app/view/searchbar-view.dart';
import 'package:food_tracker_app/main.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Align items evenly
        children: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MealListView()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: 'hotdog',)),
              );
            },
          ),
        ],
      ),
    );
  }
}
