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
  ChartsViewModel chartsViewModel;
  ChartsView({required this.chartsViewModel});

  @override
  Widget build(BuildContext context) {
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
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0), // Add padding to the right
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
        const NavBar(key: Key('navBar'), currentPage: 'ChartsView'),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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

  Widget buildSparkLineChart(BuildContext context, List<DataPoint> data) {
    return SfSparkLineChart.custom(
      dataCount: data.length,
      xValueMapper: (int index) => DateFormat('MM dd yy').format(data[index].timestamp),
      yValueMapper: (int index) => data[index].value,
      plotBand: SparkChartPlotBand(
        start: 14,
        end: 28,
        color: Colors.red.withOpacity(0.2),
        borderColor: Colors.green,
        borderWidth: 2,
      ),
      labelDisplayMode: SparkChartLabelDisplayMode.none,
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

class _ChartsTabViewState extends State<ChartsTabView> with TickerProviderStateMixin {
  ChartsViewModel viewModel;
  late TabController tabController;
  late TabController dateController;
  late TabBarView charts;

  _ChartsTabViewState({required this.viewModel});


  get caloriesChart {
    if (viewModel.isLoading){
      return Text("Loading!");
    }else{
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        child: Column(
          children: [
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 250,
                  child: SfSparkLineChart.custom(
                    axisLineWidth: 0,
                    dataCount: viewModel.calories.length,
                    xValueMapper: (int index) => DateFormat('MM dd yy').format(viewModel.calories[index].timestamp),
                    yValueMapper: (int index) => viewModel.calories[index].value,
                    labelDisplayMode: SparkChartLabelDisplayMode.none,
                    trackball: SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap,
                      tooltipFormatter: (TooltipFormatterDetails details) => '${details
                          .x}\n${details.y}',
                    ),
                    color: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  get proteinTotalGChart {
    if(viewModel.isLoading){
      return Text("Loading!");
    }else{
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 4.0),
        child: Column(
          children: [
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: SizedBox(
                  height: 250,
                  child: SfSparkLineChart.custom(
                    dataCount: viewModel.proteinTotalG != null
                        ? viewModel.proteinTotalG.length
                        : 0,
                    xValueMapper: (int index) => DateFormat('MM dd yy').format(viewModel.proteinTotalG[index].timestamp),
                    yValueMapper: (int index) => viewModel.proteinTotalG[index].value,
                    plotBand: SparkChartPlotBand(
                      start: 14,
                      end: 28,
                      color: Colors.red.withOpacity(0.2),
                      borderColor: Colors.green,
                      borderWidth: 2,
                    ),
                    labelDisplayMode: SparkChartLabelDisplayMode.none,
                    trackball: SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap,
                      tooltipFormatter: (TooltipFormatterDetails details) =>
                          '${details.x}\n${details.y}',
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  get carbohydratesTotalGChart{
    if (viewModel.isLoading){
      return Text("Loading!");
    }else{
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical:4.0),
        child: Column(
          children: [
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: SizedBox(
                  height: 250,
                  child: SfSparkLineChart.custom(
                    dataCount: viewModel.carbohydratesTotalG.length,
                    xValueMapper: (int index) => DateFormat('MM dd yy').format(viewModel.carbohydratesTotalG[index].timestamp),
                    yValueMapper: (int index) => viewModel.carbohydratesTotalG[index].value,
                    plotBand: SparkChartPlotBand(
                      start: 14,
                      end: 28,
                      color: Colors.red.withOpacity(0.2),
                      borderColor: Colors.green,
                      borderWidth: 2,
                    ),
                    labelDisplayMode: SparkChartLabelDisplayMode.none,
                    trackball: SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap,
                      tooltipFormatter: (TooltipFormatterDetails details) => '${details
                          .x}\n${details.y}',
                    ),
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  get fatsTotalGChart {
    if(viewModel.isLoading){
      return Text("Loading!");
    }else{
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical:4.0),
        child: Column(
          children: [
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: SizedBox(
                  height: 250,
                  child: SfSparkLineChart.custom(
                    dataCount: viewModel.fatTotalG != null? viewModel.fatTotalG.length : 0,
                    xValueMapper: (int index) => DateFormat('MM dd yy').format(viewModel.fatTotalG[index].timestamp),
                    yValueMapper: (int index) => viewModel.fatTotalG[index].value,
                    plotBand: SparkChartPlotBand(
                      start: 14,
                      end: 28,
                      color: Colors.red.withOpacity(0.2),
                      borderColor: Colors.green,
                      borderWidth: 2,
                    ),
                    labelDisplayMode: SparkChartLabelDisplayMode.none,
                    trackball: SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap,
                      tooltipFormatter: (TooltipFormatterDetails details) => '${details
                          .x}\n${details.y}',
                    ),
                    color: Theme
                        .of(context)
                        .colorScheme
                        .tertiary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  Future<void> _pickStartDate(BuildContext context, ChartsViewModel viewModel,
      String selectedOption, int modifier) async {
    switch (selectedOption) {
      case '1w':
        await viewModel.updateStart(DateTime.now().subtract(Duration(days: 7 * (modifier + 1))));
        break;
      case '4w':
        await viewModel.updateStart(DateTime.now().subtract(Duration(days: 28 * (modifier + 1))));
        break;
      case '3m':
        await viewModel.updateStart(DateTime.now().subtract(Duration(days: 90 * (modifier + 1))));
        break;
      case '1y':
        await viewModel.updateStart(DateTime.now().subtract(Duration(days: 365 * (modifier + 1))));
        break;
    }
    print('Start Date: ${viewModel.start}');
  }

  Future<void> _pickEndDate(BuildContext context, ChartsViewModel viewModel,
      String selectedOption, int modifier) async {
    switch (selectedOption) {
      case '1w':
        await viewModel.updateEnd(DateTime.now().subtract(Duration(days: 7 * modifier)));
        break;
      case '4w':
        await viewModel.updateEnd(DateTime.now().subtract(Duration(days: 28 * modifier)));
        break;
      case '3m':
        await viewModel.updateEnd(DateTime.now().subtract(Duration(days: 90 * modifier)));
        break;
      case '1y':
        await viewModel.updateEnd(DateTime.now().subtract(Duration(days: 365 * modifier)));
        break;
    }
    print('End Date: ${viewModel.end}');
  }

  String selectedOption = '1w';
  int modifier = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: viewModel.labels.length, vsync: this);
    dateController = TabController(length: viewModel.periods.length, vsync: this);

    dateController.addListener(() {
      if (!dateController.indexIsChanging) {
        modifier = 0;
        int selectedIndex = dateController.index;
         selectedOption = viewModel.periods[selectedIndex];
        _pickStartDate(context, viewModel, selectedOption, modifier);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    updateCharts();
    return FutureProvider(
      create: (BuildContext context) { return viewModel.initializeChartsModel(); },
      initialData: null,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 2 / 3,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: dateController,
                isScrollable: false,
                indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
                dividerColor: Colors.transparent,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Colors.grey,
                tabs: viewModel.periods.map<Tab>((periods) => Tab(text: periods)).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: IconButton(
                  icon: Icon(Icons.arrow_left, color: Colors.white),
                  onPressed: () {
                    modifier++;
                    _pickStartDate(context, viewModel, selectedOption, modifier);
                    _pickEndDate(context, viewModel, selectedOption, modifier);
                  },
                ),
              ),
              Text(
                '${viewModel.start.month}/${viewModel.start.day}/${viewModel.start.year} - ${viewModel.end.month}/${viewModel.end.day}/${viewModel.end.year}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: IconButton(
                  icon: Icon(Icons.arrow_right, color: Colors.white),
                  onPressed: () {
                    if (modifier > 0) {
                      modifier--;
                    }
                    _pickEndDate(context, viewModel, selectedOption, modifier);
                    _pickStartDate(context, viewModel, selectedOption, modifier);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Container(
            child: charts,
            height: 270,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 6 / 7,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: tabController,
                isScrollable: false,
                indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
                dividerColor: Colors.transparent,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Colors.grey,
                tabs: viewModel.labels.map<Tab>((labels) => Tab(text: labels)).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }



  @override
  void dispose(){
    tabController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void updateCharts() {
    setState(() {
      charts =  TabBarView(
          controller: tabController,
          children: [
            caloriesChart,
            proteinTotalGChart,
            carbohydratesTotalGChart,
            fatsTotalGChart,
          ]
      );
    });
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


