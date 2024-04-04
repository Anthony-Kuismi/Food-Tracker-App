import 'package:intl/intl.dart';

class Water {
  String date;
  int amount;

  Water({required this.date, required this.amount});

  factory Water.fromJson(Map<String, dynamic> json) {
    return Water(
      date: json['date'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
      amount: json['amount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'amount': amount,
    };
  }
}
