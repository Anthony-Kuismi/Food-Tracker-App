import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MacroPieChart extends PieChart {
  MacroPieChart(
      double cals,
      double protein,
      double carbs,
      double fats, {
        super.key,
        Map<String, double>? dataMap,
        List<Color>? colorList,
        ChartType? chartType,
        double? chartRadius,
        String? centerText,
        ChartValuesOptions? chartValuesOptions,
        LegendOptions? legendOptions,
      }) : super(
    dataMap: dataMap ?? {
      'Protein': protein * 4,
      'Carbohydrates': carbs * 4,
      'Fats': fats * 9,
    },
    colorList: colorList ?? [
      const Color.fromARGB(255, 241, 116, 120),
      const Color.fromARGB(255, 117, 188, 248),
      const Color.fromARGB(255, 254, 242, 125),
    ],
    chartType: chartType ?? ChartType.ring,
    chartRadius: chartRadius ?? 200,
    centerText: centerText ?? '$cals Cals',
    chartValuesOptions: chartValuesOptions ?? const ChartValuesOptions(
      showChartValues: true,
      showChartValueBackground: true,
      showChartValuesInPercentage: true,
      showChartValuesOutside: false,
      decimalPlaces: 1,
    ),
    legendOptions: legendOptions ?? const LegendOptions(
      legendPosition: LegendPosition.top,
      legendShape: BoxShape.rectangle,
      showLegendsInRow: true,
    ),
  );
}
