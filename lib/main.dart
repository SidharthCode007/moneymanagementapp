import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Screens/HomeScreen.dart';
import 'package:moneymanagementapp/Screens/addTransactionsScreen.dart';

void main() async {
  runApp(const MoneyManagement());
}

class MoneyManagement extends StatelessWidget {
  const MoneyManagement({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffb73e3e),
      ),
      home: HomeMain(),
      routes: {
        AddTransaction.routeName: (ctx) => AddTransaction(),
      },
    );
  }
}
