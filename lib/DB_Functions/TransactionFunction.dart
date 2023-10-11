import 'package:flutter/widgets.dart';
import 'package:moneymanagementapp/DB_Model/transaction_model.dart';

abstract class TransactionFunctions {
  Future<void> addTrans(Transactionmodel value);
  Future<List<Transactionmodel>> getAllTransaction();
  Future<void> deleteTransaction(String id);
}

class TransFunctions implements TransactionFunctions {
  TransFunctions._internal();
  static TransFunctions instance = TransFunctions._internal();

  factory TransFunctions() {
    return instance;
  }

  final List<Transactionmodel> _transactionsList = [];

  final ValueNotifier<List<Transactionmodel>> transactionNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTrans(Transactionmodel obj) async {
    _transactionsList.add(obj);
    TransFunctions.instance.RefreshUI();
  }

  Future<void> RefreshUI() async {
    final _allTransaction = await getAllTransaction();
    _allTransaction.sort((first, second) => second.date.compareTo(first.date));
    transactionNotifier.value.clear();
    transactionNotifier.value.addAll(_allTransaction);
    transactionNotifier.notifyListeners();
  }

  @override
  Future<List<Transactionmodel>> getAllTransaction() async {
    return _transactionsList.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final transactionToDelete = _transactionsList.firstWhere(
      (transaction) => transaction.id == id,
    );
    _transactionsList.remove(transactionToDelete);
    TransFunctions.instance.RefreshUI();
  }
}
