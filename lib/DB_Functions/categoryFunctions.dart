import 'package:flutter/widgets.dart';
import 'package:moneymanagementapp/DB_Model/categoryDBModel.dart';

abstract class CategoryFunctions {
  Future<List<CategoryModel>> getCategory();
  Future<void> addCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class Functions implements CategoryFunctions {
  Functions._internal();
  static Functions instance = Functions._internal();

  factory Functions() {
    return instance;
  }

  final List<CategoryModel> _transactions = [];
  final ValueNotifier<List<CategoryModel>> incomeNotifier = ValueNotifier([]);
  final ValueNotifier<List<CategoryModel>> expenseNotifier = ValueNotifier([]);
  @override
  Future<void> addCategory(CategoryModel value) async {
    _transactions.add(value);
    Functions().refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    return _transactions.toList();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategory();
    incomeNotifier.value.clear();
    expenseNotifier.value.clear();
    await Future.forEach(allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeNotifier.value.add(category);
        incomeNotifier.notifyListeners();
      } else {
        expenseNotifier.value.add(category);
        expenseNotifier.notifyListeners();
      }
    });
  }

  Future<void> deleteCategory(String categoryID) async {
    final categoryToDelete = _transactions.firstWhere(
      (category) => category.id == categoryID,
    );
    _transactions.remove(categoryToDelete);
    if (categoryToDelete.type == CategoryType.income) {
      incomeNotifier.value.removeWhere((category) => category.id == categoryID);
      expenseNotifier.value
          .removeWhere((category) => category.id == categoryID);
    }
    Functions.instance.refreshUI();
  }
}
