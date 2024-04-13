import 'package:flutter/foundation.dart';

import '../model/charts.dart';

enum ChartsViewMode {
  DAILY,
  WEEKLY,
  MONTHLY
}

class ChartsViewModel extends ChangeNotifier {
  final _model = Charts();
  get data =>  _model.data;

  get dataSets => _model.datasets;
}