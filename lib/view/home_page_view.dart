import 'package:flutter/material.dart';
import 'package:food_tracker_app/service/firestore_service.dart';
import 'package:food_tracker_app/service/navigator_service.dart';
import 'package:food_tracker_app/view/daily_view.dart';
import 'package:food_tracker_app/view/settings_view.dart';
import 'package:provider/provider.dart';
import 'component/daily_notes.dart';
import 'component/date_picker_button.dart';
import 'component/navbar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../viewmodel/homepage_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  HomePageViewModel viewModel;
  final NavigatorService navigatorService = NavigatorService();

  MyHomePage(
      {super.key,
      required this.title,
      required String username,
      required this.viewModel});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void refresh() {
    setState(() {});
  }

  late Future _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = widget.viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
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
      bottomNavigationBar:
          const NavBar(key: Key('navBar'), currentPage: 'MyHomePage'),
      body: FutureBuilder(
        future: _loadFuture,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 4.5),
                    children: <Widget>[
                      dailySummaryContainer(context, widget.viewModel),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.5),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: <Widget>[
                      waterContainer(context, widget.viewModel, refresh),
                      weightContainer(context, widget.viewModel, refresh),
                    ],
                  ),
                ),
                DailyNotes(viewModel: widget.viewModel,timestamp: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),),
              ],
            ),
          );
        },
      ),
    );
  }
}

GestureDetector weightContainer(
    BuildContext context, viewModel, Function refresh) {
  final FirestoreService firestoreService = FirestoreService();
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController controller = TextEditingController();
          return AlertDialog(
            title: const Text('Select Weekly Goal'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Enter how much weight you would like to gain/lose every week\n\nYou may not lose/gain more than two pounds a week.'),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter your goal',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  double? newValue = double.tryParse(controller.text);
                  if (newValue != null && newValue > 2) {
                    viewModel.setWeightGoal(2);
                  } else if (newValue != null && newValue < -2) {
                    viewModel.setWeightGoal(-2);
                  } else if (newValue != null) {
                    viewModel.setWeightGoal(newValue);
                  }
                  Navigator.of(context).pop();
                  refresh();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    },
    child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black45,
        ),
        margin: const EdgeInsets.all(4),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 10,
              child: Text(
                'Your Weight',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 35,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Goal:' + viewModel.weightGoal.toString() + ' lbs',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  heroTag: 'addButton',
                  mini: true,
                  shape: CircleBorder(),
                  onPressed: () {
                    TextEditingController controller = TextEditingController();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Enter Your Weight'),
                          content: TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter your weight',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                double? newValue =
                                    double.tryParse(controller.text);
                                if (newValue != null) {
                                  viewModel.setWeightInPounds(newValue);
                                  firestoreService.addUserWeightEntry(
                                      newValue, DateTime.now());
                                }
                                Navigator.of(context).pop();
                                refresh();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.scale, size: 20, color: Colors.black),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 15,
              child: Text(
                'Log Weight',
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: viewModel.weight.toStringAsFixed(1),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            TextSpan(
                              text: 'lbs',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: viewModel.lastWeightEntry
                                      .toStringAsFixed(1),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                TextSpan(
                                  text: 'lbs',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  '${viewModel.percentChange.toStringAsFixed(1)}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: (viewModel.weightGoal >= 0 &&
                                                viewModel.percentChange >= 0)
                                            ? Colors.green
                                            : (viewModel.weightGoal <= 0 &&
                                                    viewModel.percentChange <=
                                                        0)
                                                ? Colors.green
                                                : Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Icon(
                                  viewModel.percentChange > 0
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  color: (viewModel.weightGoal >= 0 &&
                                          viewModel.percentChange >= 0)
                                      ? Colors.green
                                      : (viewModel.weightGoal <= 0 &&
                                              viewModel.percentChange <= 0)
                                          ? Colors.green
                                          : Colors.red,
                                  size: 18,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
  );
}

GestureDetector waterContainer(
    BuildContext context, viewModel, Function refresh) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController controller = TextEditingController();
          return AlertDialog(
            title: const Text('Select Goal'),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your goal',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  int? newValue = int.tryParse(controller.text);
                  if (newValue != null) {
                    viewModel.setWaterGoal(newValue);
                  }
                  refresh();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black45,
      ),
      margin: const EdgeInsets.all(4),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: viewModel,
            builder: (context, _) {
              return CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 10.0,
                percent: viewModel.waterPercentage,
                center: Text(
                  '${viewModel.waterCups}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                progressColor: viewModel.waterPercentage < 0.5
                    ? Theme.of(context).colorScheme.tertiary
                    : viewModel.waterPercentage < 1.0
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primaryContainer,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 750,
              );
            },
          ),
          Positioned(
            top: 10,
            child: Text(
              'Water Intake',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              height: 40.0,
              width: 40.0,
              child: Material(
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.remove, size: 20, color: Colors.black),
                  onPressed: () {
                    viewModel.removeWater();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              height: 40.0,
              width: 40.0,
              child: Material(
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.add, size: 20, color: Colors.black),
                  onPressed: () {
                    viewModel.addWater();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Text(
              'One Cup',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 35,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Goal: ${viewModel.waterCupsGoal} Cups',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

InkWell dailySummaryContainer(
    BuildContext context, HomePageViewModel viewModel) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DailyView(
                    timestamp: DateTime.now(),
                    homePageViewModel: viewModel,
                  )));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black45,
      ),
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.only(right: 9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Text(
                      'Daily Summary',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Flexible(
                      child: DatePickerButton(
                    homePageViewModel: viewModel,
                  )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Text(
                        '${viewModel.calories.toStringAsFixed(0)}',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                    ),
                    LinearPercentIndicator(
                      width: 100,
                      lineHeight: 6.0,
                      percent: viewModel.caloriePercentage,
                      animation: true,
                      trailing:
                          new Text(viewModel.calorieGoal.toStringAsFixed(0)),
                      /*
                    REPLACE 'waterPercentage' WITH 'caloriesPercentage' IN THE LINES BELOW
                     */
                      progressColor: viewModel.caloriePercentage < 0.5
                          ? Theme.of(context).colorScheme.tertiary
                          : viewModel.caloriePercentage < 1.0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primaryContainer,
                      barRadius: Radius.circular(10),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Text(
                        'Calories',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 9),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Protein: ${viewModel.proteinG.toStringAsFixed(1)}g',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Carbs: ${viewModel.carbohydratesTotalG.toStringAsFixed(1)}g',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Fat: ${viewModel.fatTotalG.toStringAsFixed(1)}g',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}