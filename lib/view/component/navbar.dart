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
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            spreadRadius: 5.0,
            blurRadius: 20.0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.menu_book, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              navigatorService.pushReplace('MealListView');
            },
            iconSize: 30,
          ),
          IconButton(
            icon: Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              navigatorService.pushReplace('MyHomePage');
            },
            iconSize: 30,
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary),
            onPressed:(){navigatorService.pushReplace('SettingsView');},
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
