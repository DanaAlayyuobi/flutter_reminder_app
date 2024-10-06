import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reminder_app/models/expense.dart';
import 'package:flutter_reminder_app/widgets/expences_list/expense_item.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({
    required this.onRemoveExpense,
    required this.expenses,
    super.key});

  final List<Expense> expenses;
  final void Function (Expense expense)onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder:(ctx,index)=>
            Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error,
                margin:EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal,
                )
              ),
              key: ValueKey(expenses[index]),
              onDismissed:(direction){
                onRemoveExpense(expenses[index]);
              } ,
              child: ExpenseItem(expenses[index]),)
    );
  }
}