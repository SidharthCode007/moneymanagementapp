import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Constants/TextStyles.dart';
import 'package:moneymanagementapp/Constants/colors.dart';
import 'package:moneymanagementapp/DB_Functions/categoryFunctions.dart';
import 'package:moneymanagementapp/DB_Model/categoryDBModel.dart';
import 'package:moneymanagementapp/DB_Model/transaction_model.dart';
import 'package:moneymanagementapp/DB_Functions/TransactionFunction.dart';

class AddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? categoryID;

  final _purposeController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grayColor,
        title: Text(
          "Add Transaction",
          style: textmain,
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                //Tye text field
                Column(
              children: [
                TextFormField(
                  controller: _purposeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: 'Purpose', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                //Amount text field
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Amount', border: OutlineInputBorder()),
                ),
                //Date selection
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextButton.icon(
                      onPressed: () async {
                        final _selectedDateTemp = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 60)),
                            lastDate: DateTime.now());
                        if (_selectedDateTemp == null) {
                          return;
                        } else {
                          print(_selectedDateTemp.toString());
                          setState(() {
                            _selectedDate = _selectedDateTemp;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.teal,
                      ),
                      label: Text(
                        _selectedDate == null
                            ? 'Date'
                            : _selectedDate.toString(),
                        style: TextStyle(fontSize: 14, color: teal),
                      )),
                ),
                //radio button income expense selectiion
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.income,
                            groupValue: _selectedCategoryType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategoryType = CategoryType.income;
                                categoryID = null;
                              });
                            }),
                        const Text('Income'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            activeColor: teal,
                            value: CategoryType.expense,
                            groupValue: _selectedCategoryType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategoryType = CategoryType.expense;
                                categoryID = null;
                              });
                            }),
                        Text('Expense'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    hint: const Text('Select category'),
                    value: categoryID,
                    items: (_selectedCategoryType == CategoryType.income
                            ? Functions().incomeNotifier
                            : Functions().expenseNotifier)
                        .value
                        .map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                        onTap: () {
                          _selectedCategoryModel = e;
                        },
                      );
                    }).toList(),
                    onChanged: (selectedvalue) {
                      setState(() {
                        categoryID = selectedvalue;
                      });
                    }),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: grayColor),
                    onPressed: () {
                      submitButtonClicked(context);
                    },
                    child: Text('SUBMIT'))
              ],
            )),
      ),
    );
  }

  Future<void> submitButtonClicked(BuildContext context) async {
    final _purpose = _purposeController.text;
    final _amount = _amountController.text;

    if (_purpose.isEmpty) {
      return;
    }
    if (_amount.isEmpty) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }

    final _parsedamount = double.tryParse(_amount);
    if (_parsedamount == null) {
      return;
    }

    final _model = Transactionmodel(
      purpose: _purpose,
      amount: _parsedamount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );
    await TransFunctions.instance.addTrans(_model);
    _amountController.clear();
    _purposeController.clear();
    Navigator.of(context).pop();
  }
}
