import 'package:intl/intl.dart';

class Weight {
  String date;
  double weight;

  Weight({required this.date, required this.weight});

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      date: json['date'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
      weight: json['amount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'weight': weight,
    };
  }

}