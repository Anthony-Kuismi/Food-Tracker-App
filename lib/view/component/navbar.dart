import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/navigator.dart';

class NavBar extends StatelessWidget {
  const NavBar({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigatorService navigatorService = Provider.of<NavigatorService>(context, listen: false);

    return Container(
      height: 50,
      color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: (){navigatorService.pushReplace('MealListView');},
          ),
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed:(){navigatorService.pushReplace('MyHomePage');},
          ),
        ],
      ),
    );
  }
}
