import 'package:intl/intl.dart';

class Water {
  String date;
  int amount;
  List<int> timestamps;

  Water({required this.date, required this.amount, required this.timestamps});

  factory Water.fromJson(Map<String, dynamic> json) {
    return Water(
      date: json['date'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
      amount: json['amount'] ?? 0,
      timestamps: json['timestamps'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'amount': amount,
      'timestamps' : timestamps
    };
  }
}
