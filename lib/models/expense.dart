import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter=DateFormat.yMd();
const uuid = Uuid ();

enum Category1{food,travel,leisure,work}
const categoryIcons={
  Category1.food:Icons.lunch_dining,
  Category1.travel:Icons.flight_takeoff,
  Category1.leisure:Icons.movie,
  Category1.work:Icons.work,
};
class Expense{
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category
     }):id=uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category1 category;

  String get formatedData{
    return formatter.format(date);
  }
}
class ExpenseBucket{
  const ExpenseBucket({required this.category,required this.expenses});
  ExpenseBucket.forCategory(
      List<Expense>allExpenses,this.category)
      :expenses=allExpenses.where(
      (expense)=>expense.category==category).toList()

  ;
  final Category1 category;
  final List<Expense>expenses;
  double get totalExpenses{
    double sum=0;
    for(final expense in expenses)
      sum+=expense.amount;
    return sum;
  }
}