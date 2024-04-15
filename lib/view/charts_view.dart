import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_tracker_app/view/settings_view.dart';
import 'package:food_tracker_app/viewmodel/charts_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../model/charts.dart';
import 'component/navbar.dart';

class ChartsView extends StatelessWidget {
  late ChartsViewModel chartsViewModel;

  @override
  Widget build(BuildContext context) {
    chartsViewModel = Provider.of<ChartsViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primary,
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
                          builder: (context) =>
                              SettingsView(
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
            child: ChartsTabView(
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

class ChartsTabView extends StatefulWidget {
  ChartsViewModel viewModel;

  ChartsTabView({required this.viewModel});

  Future<void> _pickDate(BuildContext context, ChartsViewModel viewModel,
      bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? viewModel.start : viewModel.end,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      if (isStart) {
        await viewModel.updateStart(picked);
      } else {
        await viewModel.updateEnd(picked);
      }
    }
  }

  Widget buildSparkLineChart(BuildContext context, List<DataPoint> data) {
    return SfSparkLineChart.custom(
      dataCount: data.length,
      xValueMapper: (int index) => data[index].timestamp,
      yValueMapper: (int index) => data[index].value,
      plotBand: SparkChartPlotBand(
        start: 14,
        end: 28,
        color: Colors.red.withOpacity(0.2),
        borderColor: Colors.green,
        borderWidth: 2,
      ),
      labelDisplayMode: SparkChartLabelDisplayMode.last,
      trackball: SparkChartTrackball(
        activationMode: SparkChartActivationMode.tap,
        tooltipFormatter: (TooltipFormatterDetails details) => '${details
            .x}\n${details.y}',
      ),
      color: Theme
          .of(context)
          .colorScheme
          .secondary,
    );
  }

  @override
  State<StatefulWidget> createState() =>
      _ChartsTabViewState(viewModel: viewModel);
}

class _ChartsTabViewState extends State<ChartsTabView> with SingleTickerProviderStateMixin {
  ChartsViewModel viewModel;

  _ChartsTabViewState({required this.viewModel});

  get caloriesChart => SfSparkLineChart.custom(
    dataCount: viewModel.calories.length,
    xValueMapper: (int index) => viewModel.calories[index].timestamp,
    yValueMapper: (int index) => viewModel.calories[index].value,
    plotBand: SparkChartPlotBand(
      start: 14,
      end: 28,
      color: Colors.red.withOpacity(0.2),
      borderColor: Colors.green,
      borderWidth: 2,
    ),
    labelDisplayMode: SparkChartLabelDisplayMode.last,
    trackball: SparkChartTrackball(
      activationMode: SparkChartActivationMode.tap,
      tooltipFormatter: (TooltipFormatterDetails details) => '${details
          .x}\n${details.y}',
    ),
    color: Theme
        .of(context)
        .colorScheme
        .secondary,
  );

  get proteinTotalGChart => SfSparkLineChart.custom(
    dataCount: viewModel.proteinTotalG.length,
    xValueMapper: (int index) => viewModel.proteinTotalG[index].timestamp,
    yValueMapper: (int index) => viewModel.proteinTotalG[index].value,
    plotBand: SparkChartPlotBand(
      start: 14,
      end: 28,
      color: Colors.red.withOpacity(0.2),
      borderColor: Colors.green,
      borderWidth: 2,
    ),
    labelDisplayMode: SparkChartLabelDisplayMode.last,
    trackball: SparkChartTrackball(
      activationMode: SparkChartActivationMode.tap,
      tooltipFormatter: (TooltipFormatterDetails details) => '${details
          .x}\n${details.y}',
    ),
    color: Theme
        .of(context)
        .colorScheme
        .secondary,
  );

  get carbohydratesTotalGChart =>  SfSparkLineChart.custom(
    dataCount: viewModel.carbohydratesTotalG.length,
    xValueMapper: (int index) => viewModel.carbohydratesTotalG[index].timestamp,
    yValueMapper: (int index) => viewModel.carbohydratesTotalG[index].value,
    plotBand: SparkChartPlotBand(
      start: 14,
      end: 28,
      color: Colors.red.withOpacity(0.2),
      borderColor: Colors.green,
      borderWidth: 2,
    ),
    labelDisplayMode: SparkChartLabelDisplayMode.last,
    trackball: SparkChartTrackball(
      activationMode: SparkChartActivationMode.tap,
      tooltipFormatter: (TooltipFormatterDetails details) => '${details
          .x}\n${details.y}',
    ),
    color: Theme
        .of(context)
        .colorScheme
        .secondary,
  );

  get fatsTotalGChart => SfSparkLineChart.custom(
    dataCount: viewModel.fatsTotalG.length,
    xValueMapper: (int index) => viewModel.fatsTotalG[index].timestamp,
    yValueMapper: (int index) => viewModel.fatsTotalG[index].value,
    plotBand: SparkChartPlotBand(
      start: 14,
      end: 28,
      color: Colors.red.withOpacity(0.2),
      borderColor: Colors.green,
      borderWidth: 2,
    ),
    labelDisplayMode: SparkChartLabelDisplayMode.last,
    trackball: SparkChartTrackball(
      activationMode: SparkChartActivationMode.tap,
      tooltipFormatter: (TooltipFormatterDetails details) => '${details
          .x}\n${details.y}',
    ),
    color: Theme
        .of(context)
        .colorScheme
        .secondary,
  );

  @override
  Widget build(BuildContext context) {
    viewModel.tabController =
        TabController(length: viewModel.dataSets.length, vsync: this);

    return Column(
      children: [
        TabBar(
          controller: viewModel.tabController,
          isScrollable: true,
          tabs: viewModel.labels.map<Tab>((label) => Tab(text: label)).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () => widget._pickDate(context, viewModel, true),
              tooltip: 'Set Start Date',
            ),
            IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () => widget._pickDate(context, viewModel, false),
              tooltip: 'Set End Date',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: viewModel.tabController,
            children: [
              caloriesChart,
              proteinTotalGChart,
              carbohydratesTotalGChart,
              fatsTotalGChart
            ]
          ),
        ),
      ],
    );
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
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


