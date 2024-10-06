import 'package:flutter/material.dart';
import 'package:flutter_reminder_app/widgets/chart/chart.dart';
import 'package:flutter_reminder_app/widgets/expences_list/expenses_list.dart';
import 'package:flutter_reminder_app/models/expense.dart';
import 'package:flutter_reminder_app/widgets/new_expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
  
}
class _ExpensesState extends State<Expenses>{
  final List<Expense>_registeredExpenses=[
    Expense(
        title: 'flutter',
        amount: 19.99,
        date: DateTime.now(),
        category: Category1.work
    ),
    Expense(
        title: 'cinema',
        amount: 15.98,
        date: DateTime.now(),
        category: Category1.leisure
    ),
  ];
  void _openAddExpenseOverlay(){
   showModalBottomSheet(
     isScrollControlled:true ,
       context: context,
       builder: (ctx)=> NewExpense(onAddExpence:_addExpense),
   );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);

    });
  }
  void _removeExpense(Expense expense){
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 3),
            content: Text('${expense.title} deleted'),
            action:SnackBarAction(
                label: 'Undo',
                onPressed: (){
                  setState(() {
                    _registeredExpenses.insert(expenseIndex, expense);
                  });
                }) ,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent=const Center(
        child:Text('No expenses found , start adding one',));
    if(_registeredExpenses.isNotEmpty){
      mainContent=ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,);
    }
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Tracker'),
        actions: [
          IconButton(
              onPressed:_openAddExpenseOverlay,
              icon: const Icon(Icons.add),),
        ],
      ),
      body:Column(
        children: [
          Chart(expenses: _registeredExpenses,) ,
          Expanded(
              child:mainContent
    ),
        ],
      ),
    );
  }
  
}