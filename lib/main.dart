import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/search_view.dart';
import 'package:food_tracker_app/viewmodel/search_viewmodel.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(),
      child: MaterialApp(
        title: 'Food Search Demo',
        home: SearchView(),
      ),
    );
  }
}