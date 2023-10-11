import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Constants/TextStyles.dart';
import 'package:moneymanagementapp/DB_Functions/categoryFunctions.dart';
import 'package:moneymanagementapp/DB_Model/categoryDBModel.dart';

class ExpensecategoryList extends StatelessWidget {
  const ExpensecategoryList({super.key});
  @override
  Widget build(BuildContext context) {
    Functions.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: Functions().expenseNotifier,
        builder:
            (BuildContext context, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final category = newList[index];
              return ListTile(
                leading: Text(
                  category.name,
                  style: textsub2,
                ),
                trailing: IconButton(
                    onPressed: () {
                      Functions.instance.deleteCategory(category.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 197, 26, 14),
                    )),
              );
            },
            separatorBuilder: (BuildContext, int) {
              return Divider();
            },
            itemCount: newList.length,
          );
        });
  }
}
