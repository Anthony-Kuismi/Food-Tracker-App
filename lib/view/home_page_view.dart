import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'component/navbar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../viewmodel/homepage_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required String username});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomePageViewModel>(context, listen: true);
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
        future: viewModel.load(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.5),
              children: <Widget>[
                waterContainer(context, viewModel),
              ],
            ),
          );
        },
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomePageViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        automaticallyImplyLeading: false,
        title: const Text(
          'Food Tracking: Hotdog Version',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(key: Key('navBar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // dailySummary(context, viewModel),
            SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: MediaQuery
                  .of(context)
                  .size
                  .width /
                  (MediaQuery
                      .of(context)
                      .size
                      .height / 1.5),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                waterContainer(context, viewModel),
                // Add more widgets as needed
              ],
            ),
          ],
        ),
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
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: ClipOval(
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    viewModel.addWater();
                  },
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .primaryContainer,
                  child: const Icon(Icons.add, size: 20, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              child: Text(
                'One Cup',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 35,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Goal: ${viewModel.waterCupsGoal} Cups',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Widget dailySummary(BuildContext context, HomePageViewModel viewModel) {
    // Calculate total values for all meals and custom food eaten that day
    double totalCalories = 0.0;
    double totalProtein = 0.0;
    double totalCarbs = 0.0;
    double totalFat = 0.0;

    // You need to replace this with your actual data retrieval logic
    // This is just a placeholder
    /*List<Food> mealsAndCustomFood = viewModel.getMealsAndCustomFood();

  for (Food food in mealsAndCustomFood) {
    totalCalories += food.calories;
    totalProtein += food.protein;
    totalCarbs += food.carbohydratesTotal;
    totalFat += food.fatTotal;
  }*/

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black26,
      ),
      margin: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                animationDuration: 750, // Set your desired animation duration
              );
            },
          ),
          SizedBox(height: 10),
          Text(
            'Total Calories: $totalCalories',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
          ),
          Text(
            'Total Protein: $totalProtein',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
          ),
          Text(
            'Total Carbs: $totalCarbs',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
          ),
          Text(
            'Total Fat: $totalFat',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
          ),
        ],
      ),
    );
  }*/
  // Widget dailySummary(BuildContext context, HomePageViewModel viewModel) {
  //   FirestoreService firestoreService = FirestoreService();
  //   return FutureBuilder(
  //     future: firestoreService.getMealsFromUser(),
  //     builder: (context, snapshot) {
  //       Map<String, double> summary = calculateDailySummary();
  //
  //       return Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: Colors.black26,
  //         ),
  //         margin: const EdgeInsets.all(4),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Text(
  //               'Daily Summary',
  //               style: Theme.of(context).textTheme.titleMedium,
  //               textAlign: TextAlign.center,
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               'Total Calories: ${summary['totalCalories']}',
  //               style: Theme.of(context).textTheme.bodyLarge,
  //             ),
  //             Text(
  //               'Total Protein: ${summary['totalProtein']}',
  //               style: Theme.of(context).textTheme.bodyLarge,
  //             ),
  //             Text(
  //               'Total Carbs: ${summary['totalCarbs']}',
  //               style: Theme.of(context).textTheme.bodyLarge,
  //             ),
  //             Text(
  //               'Total Fat: ${summary['totalFat']}',
  //               style: Theme.of(context).textTheme.bodyLarge,
  //             ),
  //           ],
          ),
        );
      },
    );
  }
}
