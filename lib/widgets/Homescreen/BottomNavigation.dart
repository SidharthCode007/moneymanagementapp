import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Constants/colors.dart';
import 'package:moneymanagementapp/Screens/HomeScreen.dart';

class MoneyManagementBottomNavigator extends StatelessWidget {
  const MoneyManagementBottomNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeMain.selectedIndex,
      builder: (BuildContext ctx, int updatedIndex, _) {
        return BottomNavigationBar(
          currentIndex: updatedIndex,
          selectedFontSize: 16,
          unselectedFontSize: 12,
          fixedColor: teal2,
          onTap: (NewIndex) {
            HomeMain.selectedIndex.value = NewIndex;
            //print(NewIndex);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.currency_rupee_sharp,
                ),
                label: 'Transactions'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Category')
          ],
        );
      },
    );
  }
}
