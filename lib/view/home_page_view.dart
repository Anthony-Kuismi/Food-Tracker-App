import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_tracker_app/service/local_notification_service.dart';
import 'component/navbar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../viewmodel/homepage_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required String username});

  HomePageViewModel viewModel = HomePageViewModel();
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _loadFuture = widget.viewModel.load();
  }

  late Future _loadFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: const Text(
          'Food Tracking: Hot dog Version',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(key: Key('navBar'), currentPage: 'MyHomePage'),
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
                      DailySummary(viewModel: widget.viewModel),
                    ],
                  ),

                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.5),
                    children: <Widget>[
                      waterContainer(context, widget.viewModel),
                      weightContainer(context, widget.viewModel),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

GestureDetector weightContainer(BuildContext context, viewModel) {
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
                Text('Enter how much weight you would like to gain/lose every week'),
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
                  int? newValue = int.tryParse(controller.text);
                  if (newValue != null) {
                    //viewModel.setWaterGoal(newValue);
                  }
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
        color: Colors.black26,
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
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: ClipOval(
                child: FloatingActionButton(
                  heroTag: 'addButton',
                  mini: true,
                  onPressed: () {
                    //viewModel.addWater();
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.scale, size: 20, color: Colors.black),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
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
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: 'lbs',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                                  text: viewModel.lastWeightEntry.toStringAsFixed(1),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'lbs',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                                  '5%',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
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
        )
    ),
  );
}

GestureDetector waterContainer(BuildContext context, viewModel) {
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
        color: Colors.black26,
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
                    ? Colors.red
                    : viewModel.waterPercentage < 1.0
                        ? Colors.orange
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
            child: ClipOval(
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                mini: true,
                heroTag: 'subtractButton',
                onPressed: () {
                  viewModel.removeWater();
                },
                child: const Icon(Icons.remove, size: 20, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: ClipOval(
              child: FloatingActionButton(
                heroTag: 'addButton',
                mini: true,
                onPressed: () {
                  viewModel.addWater();
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.add, size: 20, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class DailySummary extends StatelessWidget {
  HomePageViewModel viewModel;

  DailySummary({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black26,
      ),
      margin: const EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Daily Summary',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.left,
                      ),
                      const Icon(Icons.today),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${viewModel.calories.toStringAsFixed(1)}',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'Calories',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Protein: ${viewModel.proteinG.toStringAsFixed(1)}g',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
                          ),
                          Text(
                            'Carbs: ${viewModel.carbohydratesTotalG.toStringAsFixed(1)}g',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
                          ),
                          Text(
                            'Fat: ${viewModel.fatTotalG.toStringAsFixed(1)}g',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
        )

  );
  }
}
