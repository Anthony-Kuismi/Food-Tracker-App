import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

class MacroPieChart extends PieChart{
  MacroPieChart(double cals, double protein, double carbs, double fats, {super.key}) :
        super(dataMap:
          {
            'Protein' : protein*4,
            'Carbohydrates' : carbs*4,
            'Fats' : fats*9,
          },
          chartType: ChartType.ring,
          chartRadius: 200,
          centerText: '$cals Cals',
          chartValuesOptions: const ChartValuesOptions(
            showChartValues: true,
            showChartValueBackground: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
          legendOptions: const LegendOptions(
            legendPosition: LegendPosition.top,
            legendShape: BoxShape.rectangle,
            showLegendsInRow: true,
          ),
        )
  {

  }
}