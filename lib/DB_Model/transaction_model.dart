import 'package:moneymanagementapp/DB_Model/categoryDBModel.dart';

class Transactionmodel {
  final String purpose;
  final double amount;
  final DateTime date;
  final CategoryType type;
  final CategoryModel category;
  String? id;

  Transactionmodel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
