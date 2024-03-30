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
          chartRadius: 100,
          centerText: '$cals Cals',
          chartValuesOptions: ChartValuesOptions(
            showChartValues: false,
          ),
          centerTextStyle: TextStyle(
            color: Colors.white,
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
          ),

        )
  {

  }
}