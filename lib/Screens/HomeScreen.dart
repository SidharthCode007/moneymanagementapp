import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Constants/colors.dart';
import 'package:moneymanagementapp/Screens/Categoryscreen.dart';
import 'package:moneymanagementapp/Screens/TransactionsScreen.dart';
import 'package:moneymanagementapp/Screens/addTransactionsScreen.dart';
import 'package:moneymanagementapp/widgets/Homescreen/BottomNavigation.dart';
import 'package:moneymanagementapp/widgets/CategoryScreen/addCategoryPopup.dart';

class HomeMain extends StatelessWidget {
  HomeMain({super.key});

  static ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final _pages = [const TransactionScreen(), CategoryScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Manager'),
        centerTitle: true,
        backgroundColor: grayColor,
      ),
      bottomNavigationBar: const MoneyManagementBottomNavigator(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (BuildContext ctx, int updatedIndex, _) {
                return _pages[updatedIndex];
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: teal,
        onPressed: () {
          if (selectedIndex.value == 0) {
            print("Add Trans");
            Navigator.of(context).pushNamed(AddTransaction.routeName);
          } else {
            addCategoryPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
