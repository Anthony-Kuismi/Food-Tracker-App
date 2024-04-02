import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/navigator_service.dart';

class NavBar extends StatelessWidget {
  const NavBar({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigatorService navigatorService =
        Provider.of<NavigatorService>(context, listen: false);

    return Container(
      height: 70,
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.menu_book, color: Colors.black),
            onPressed: () {
              navigatorService.pushReplace('MealListView');
            },
            iconSize: 40,
          ),
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black),
            onPressed: () {
              navigatorService.pushReplace('MyHomePage');
            },
            iconSize: 40,
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.black),
            onPressed: () {
              navigatorService.pushReplace('MyHomePage');
            },
            iconSize: 40,
          ),
        ],
      ),
    );
  }
}
