import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../viewmodel/daily_viewmodel.dart';
import 'component/macro_pie_chart.dart';

class DailyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DailyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Summary', style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureProvider(
        create: (BuildContext context) {
          viewModel.init();
          return null;
        },
        builder: (context, snapshot) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat('HH:mm MM-dd-yyyy').format(viewModel.timestamp),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              ...List.generate(viewModel.meals.length, (index) {
                final meal = viewModel.meals[index];
                return ListTile(
                  title: Row(
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
                          chartValuesOptions:
                          const ChartValuesOptions(
                              showChartValues: false),
                          legendOptions: const LegendOptions(
                              showLegends: false),
                          centerText: '',
                          ringStrokeWidth: 8,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(meal.title),
                            Text(meal.timestampString),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
        initialData: [],
      ),
    );
  }
}
