// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
/// * To get Access to DateFormatter in Dart
import 'package:intl/intl.dart'; 

import '../models/chartDetails.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<ChartDetails> get groupedTransactionValues {
    return List.generate(7, (index) {

      // ? Can we Convert this to List.map() to get it more concise ?

      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum =
          0.0; // set as 0 because Dart dont allow Assigning Values to Nullable
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return ChartDetails(
          weekDayName: DateFormat.E().format(weekDay).substring(0, 1), amount: totalSum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
          children: groupedTransactionValues.map((data) {
        return Text('${data.weekDayName} : ${data.amount}');
      }).toList()),
    );
  }
}
