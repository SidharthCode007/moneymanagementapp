import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagementapp/Constants/TextStyles.dart';
import 'package:moneymanagementapp/Constants/colors.dart';
import 'package:moneymanagementapp/DB_Functions/TransactionFunction.dart';
import 'package:moneymanagementapp/DB_Model/categoryDBModel.dart';
import 'package:moneymanagementapp/DB_Model/transaction_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key});
  @override
  Widget build(BuildContext context) {
    TransFunctions.instance.RefreshUI();
    return ValueListenableBuilder(
        valueListenable: TransFunctions.instance.transactionNotifier,
        builder:
            (BuildContext ctx, List<Transactionmodel> newLists, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                final transaction = newLists[index];
                return Slidable(
                  key: Key(transaction.id!),
                  startActionPane:
                      ActionPane(motion: ScrollMotion(), children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(8),
                      padding: EdgeInsets.all(5),
                      backgroundColor: Colors.red,
                      onPressed: (ctx) {
                        TransFunctions.instance
                            .deleteTransaction(transaction.id!);
                      },
                      icon: Icons.delete,
                      label: 'Delete',
                    )
                  ]),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: transaction.type == CategoryType.income
                            ? teal2
                            : expense,
                        radius: 50,
                        child: Text(
                          parsedate(transaction.date),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        "Rs. ${transaction.amount}",
                        style: textsub2,
                      ),
                      subtitle: Text(
                        transaction.purpose,
                        style: textsub3,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: newLists.length);
        });
  }

  String parsedate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitdate = _date.split(' ');
    return '${_splitdate.first}\n${_splitdate.last}';
  }
}
