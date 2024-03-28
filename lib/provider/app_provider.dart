import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/food_selection.dart';
import '../service/navigator.dart';
import '../viewmodel/homepage_viewmodel.dart';
import '../viewmodel/meal_list_viewmodel.dart';
import '../viewmodel/search_viewmodel.dart';

class AppProvider extends StatelessWidget {
  final Widget child;
  final NavigatorService navigatorService;

  const AppProvider({super.key, required this.child, required this.navigatorService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NavigatorService>(create: (context) => navigatorService),
        ChangeNotifierProvider(create: (context) => FoodSelectionService()),
        ChangeNotifierProxyProvider2<FoodSelectionService, NavigatorService, MealListViewModel>(
          create: (context) => MealListViewModel(navigatorService, Provider.of<FoodSelectionService>(context, listen: false)),
          update: (context, foodSelectionService, navigatorService, previousViewModel) => MealListViewModel(navigatorService, foodSelectionService),
        ),
        ChangeNotifierProxyProvider2<FoodSelectionService, NavigatorService, SearchViewModel>(
          create: (context) => SearchViewModel(navigatorService, Provider.of<FoodSelectionService>(context, listen: false)),
          update: (context, foodSelectionService, navigatorService, previousViewModel) => SearchViewModel(navigatorService, foodSelectionService),
        ),
        ChangeNotifierProvider(
          create: (context) => HomePageViewModel(),
        ),
      ],
      child: child,
    );
  }
}
