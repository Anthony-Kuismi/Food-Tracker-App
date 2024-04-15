import 'package:intl/intl.dart';

class DataPoint {
  DateTime timestamp;

  String get timestampString =>
      DateFormat('HH:mm MM-dd-yyyy').format(timestamp);
  double value;

  DataPoint({required this.timestamp, required this.value});
}


class Charts {
  DateTime start;
  DateTime end;
  Charts({required this.start, required this.end});
  late List<DataPoint> calories;
  late List<DataPoint> proteinTotalG;
  late List<DataPoint> carbohydratesTotalG;
  late List<DataPoint> fatTotalG;
  final data = <double>[18, 24, 30, 14, 28];
  List<List<double>> datasets = [
    <double>[18, 24, 30, 14, 28],
    <double>[18, 24, 30, 14, 28],
    <double>[18, 24, 30, 14, 28],
    <double>[18, 24, 30, 14, 28],
    <double>[18, 24, 30, 14, 28],
  ];


  Future<void> init() async {
    await fetchData();
    print("Firestore called!!!");
  }

  Future<void> fetchData() async {

  }


}