import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Constants/TextStyles.dart';
import 'package:moneymanagementapp/Constants/colors.dart';
import 'package:moneymanagementapp/DB_Functions/categoryFunctions.dart';
import 'package:moneymanagementapp/DB_Model/categoryDBModel.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);
final titleController = TextEditingController();
Future<void> addCategoryPopup(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Categoy'),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: 'Category Name', border: OutlineInputBorder()),
              ),
            ),
            const Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: grayColor),
                  onPressed: () {
                    addButtonClicked(ctx);
                  },
                  child: const Text('Add')),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder:
                (BuildContext context, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  activeColor: teal,
                  value: type,
                  groupValue: selectedCategoryNotifier.value,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      selectedCategoryNotifier.value = value;
                    }
                  });
            }),
        Text(title)
      ],
    );
  }
}

Future<void> addButtonClicked(BuildContext ctx) async {
  final _name = titleController.text;
  if (_name.isEmpty) {
    return;
  } else {
    final _type = selectedCategoryNotifier.value;
    final _model = CategoryModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: _name,
        type: _type);
    await Functions().addCategory(_model);
    titleController.clear();
    Navigator.of(ctx).pop();
  }
}
