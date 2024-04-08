import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      bottomNavigationBar: const NavBar(key: Key('navBar')),
      body: FutureBuilder(
        future: _loadFuture,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.5),
              children: <Widget>[
                waterContainer(context, widget.viewModel),
                DailySummary(viewModel: widget.viewModel!)
              ],
            ),
          );
        },
      ),
    );
  }
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
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                mini: true,
                heroTag: 'subtractButton',
                onPressed: () {
                  viewModel.removeWater();
                },
                child: const Icon(Icons.remove, size: 20, color: Colors.white),
                
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
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: const Icon(Icons.add, size: 20, color: Colors.white),
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
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Goal: ${viewModel.waterCupsGoal} Cups',
                style: Theme.of(context).textTheme.bodySmall,
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
  DailySummary({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black26,
      ),
      margin: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Daily Summary',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Total Calories: ${viewModel.calories}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Total Protein: ${viewModel.proteinG}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Total Carbs: ${viewModel.carbohydratesTotalG}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Total Fat: ${viewModel.fatTotalG}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      )
  );
  }
}
