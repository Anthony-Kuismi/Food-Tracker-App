import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/settings_view.dart';
import 'package:food_tracker_app/viewmodel/charts_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'component/navbar.dart';

class ChartsView extends StatelessWidget {
  late ChartsViewModel chartsViewModel;

  @override
  Widget build(BuildContext context) {
    chartsViewModel = Provider.of<ChartsViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          title: const Text(
            'Nutrition Data Over Time',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
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
          ],
        ),
        bottomNavigationBar:
            const NavBar(key: Key('navBar'), currentPage: 'ChartsView'),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: ChartListNutritionSparkLineDaily(
              viewModel: chartsViewModel,
            ),
          ),
        ));
  }
}

class ChartSparkLine extends StatelessWidget {
  ChartsViewModel viewModel;

  ChartSparkLine({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SfSparkLineChart(
        data: viewModel.data,
      ),
    ));
  }
}

class ChartListNutritionSparkLineDaily extends StatelessWidget {
  final ChartsViewModel viewModel;

  const ChartListNutritionSparkLineDaily({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.dataSets.length,
      itemBuilder: (context, index) {
        var data = viewModel.dataSets[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Card(
            elevation: 1, 
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    8) 
                ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              
              child: SizedBox(
                height: 10,
                child: SfSparkLineChart(
                  width: 2,
                  data: data,
                  axisLineWidth: 2,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
