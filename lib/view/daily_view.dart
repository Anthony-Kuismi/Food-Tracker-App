import 'package:flutter/material.dart';
import 'package:food_tracker_app/service/navigator_service.dart';
import 'package:food_tracker_app/model/home_page.dart';
import 'package:food_tracker_app/view/component/add_meal_button.dart';
import 'package:food_tracker_app/view/component/daily_notes.dart';
import 'package:food_tracker_app/view/meal_view.dart';
import 'package:food_tracker_app/view/settings_view.dart';
import 'package:food_tracker_app/viewmodel/homepage_viewmodel.dart';
import 'package:food_tracker_app/viewmodel/meal_list_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../model/meal.dart';
import '../viewmodel/daily_viewmodel.dart';
import 'component/macro_pie_chart.dart';

class DailyView extends StatefulWidget {
  DateTime timestamp;
  bool get isToday=>timestamp.millisecondsSinceEpoch==DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).millisecondsSinceEpoch;

  final HomePageViewModel homePageViewModel;

  DailyView({required timestamp, required this.homePageViewModel})
      : timestamp = DateTime(timestamp.year, timestamp.month, timestamp.day);

  @override
  State<StatefulWidget> createState() => DailyViewState(
      timestamp: timestamp, homePageViewModel: homePageViewModel);
}

class DailyViewState extends State<DailyView> with WidgetsBindingObserver {
  DateTime timestamp;
  bool needsRebuildChart = true;
  HomePageViewModel homePageViewModel;
  late DailyViewModel viewModel =
      Provider.of<DailyViewModel>(context, listen: true);
  late MealListViewModel mealListViewModel =
      Provider.of<MealListViewModel>(context, listen: false);

  get data => Meal.fromFoodList((mealListViewModel.mealsByDay[timestamp] ?? [])
      .expand((meal) => meal.foods.values)
      .toList());
  late Consumer<DailyViewModel> pieChart;

  DailyViewState({required this.timestamp, required this.homePageViewModel})
      : pieChart =
            Consumer<DailyViewModel>(builder: (context, viewModel, child) {
          return MacroPieChart(
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.tertiary,
            homePageViewModel.calories,
            homePageViewModel.proteinG,
            homePageViewModel.carbohydratesTotalG,
            homePageViewModel.fatTotalG,
          );
        });

  get macroPieChart {
    return Consumer<DailyViewModel>(builder: (context, viewModel, child) {
      return MacroPieChart(
        Theme.of(context).colorScheme.primaryContainer,
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.tertiary,
        data.calories,
        data.proteinG,
        data.carbohydratesTotalG,
        data.fatTotalG,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    init();
    needsRebuildChart = true;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (viewModel.timestamp != timestamp) {
      viewModel.timestamp = timestamp;
      await mealListViewModel.load();
      await viewModel.init();
    }
    init(forceUpdate: false);
  }

  void updateMacroPieChart() async {
    if (needsRebuildChart) {
      setState(() {
        pieChart = this.macroPieChart;
        needsRebuildChart = false;
      });
      if (timestamp.millisecondsSinceEpoch -
              homePageViewModel.date.millisecondsSinceEpoch ==
          0) {
        homePageViewModel.updateData(data);
      }
    }
  }

  void init({bool forceUpdate = false}) async {
    needsRebuildChart = true;
    homePageViewModel.fetchDailyData();
  }

  @override
  Widget build(BuildContext context) {
    DailyViewModel viewModel = Provider.of<DailyViewModel>(context);
    final mealListViewModel =
        Provider.of<MealListViewModel>(context, listen: true);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      updateMacroPieChart();
    });
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          needsRebuildChart = true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daily Log',
              style: TextStyle(color: Colors.black)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: const Icon(Icons.person, color: Colors.white, size: 25),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsView(
                                username: '',
                              )));
                    },
                    iconSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: FutureProvider(
          create: (BuildContext context) async {
            initState();
          },
          builder: (context, snapshot) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            viewModel = Provider.of<DailyViewModel>(context);
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: () {
                            timestamp = DateTime(timestamp.year, timestamp.month,
                                timestamp.day -1);
                            viewModel.previousDay();
                          },
                        ),
                      ),
                      Text(
                        DateFormat('EEEE, MM-dd-yy').format(viewModel.timestamp),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: () {
                            timestamp = DateTime(timestamp.year, timestamp.month,
                                timestamp.day + 1);
                            viewModel.nextDay();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                pieChart,
                Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                ExpansionTile(title: Text('Meals'), children: [
                  ...List.generate(
                      (mealListViewModel.mealsByDay[timestamp] ?? []).length,
                      (index) {
                    final meal =
                        (mealListViewModel.mealsByDay[timestamp] ?? [])[index];
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: MacroPieChart(
                                Theme.of(context).colorScheme.primaryContainer,
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.tertiary,
                                meal.calories,
                                meal.proteinG,
                                meal.carbohydratesTotalG,
                                meal.fatTotalG,
                                chartRadius: 50,
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValues: false),
                                legendOptions:
                                    const LegendOptions(showLegends: false),
                                centerText: '',
                                ringStrokeWidth: 8,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(meal.title),
                                  Text(meal.timestampString),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        mealListViewModel.editMeal(meal);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MealView(currentMeal: meal)));
                      },
                    );
                  })
                ]),
                DailyNotes(viewModel: homePageViewModel, color: Colors.transparent,timestamp: viewModel.timestamp,isToday: false,),
              ],
            );
          },
          initialData: null,
        ),
        floatingActionButton: AddMealToListButton(timestamp: viewModel.timestamp),
      ),
    );
  }
}
