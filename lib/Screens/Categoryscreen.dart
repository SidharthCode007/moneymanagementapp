import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Constants/colors.dart';
import 'package:moneymanagementapp/DB_Functions/categoryFunctions.dart';
import 'package:moneymanagementapp/widgets/CategoryScreen/ExpenseList.dart';
import 'package:moneymanagementapp/widgets/CategoryScreen/IncomeList.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  //Functions functions = Functions.instance;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    Functions().refreshUI();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            indicatorColor: grayColor,
            unselectedLabelColor: customTextColor,
            labelColor: textColorblack,
            tabs: const [
              Tab(text: 'INCOME'),
              Tab(
                text: 'EXPENSE',
              )
            ]),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: const [IncomecategoryList(), ExpensecategoryList()]),
        )
      ],
    );
  }
}
