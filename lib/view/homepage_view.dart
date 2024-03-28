import 'package:flutter/material.dart';
import 'package:food_tracker_app/service/navigator.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.primary,
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
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.5),
          children: <Widget>[
            waterContainer(context),
          ],
        ),
      ),
    );
  }
}

Container waterContainer(BuildContext context) {
  final viewModel = Provider.of<HomePageViewModel>(context, listen: false);


  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.black26,
    ),
    margin: const EdgeInsets.all(4),
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 10.0,
          percent: .5,
          center: Text("50%"),
          progressColor: Colors.orange,
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
              mini: true,
              onPressed: () {
                viewModel.addWater();
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.remove, size: 20, color: Colors.black),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: ClipOval(
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                // event here
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
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
      ],
    ),
  );
}
