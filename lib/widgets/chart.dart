// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

/// * To get Access to DateFormatter in Dart
import 'package:intl/intl.dart';

import '../models/chartDetails.dart';
import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

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
          weekDayName: DateFormat.E().format(weekDay).substring(0, 1),
          amount: totalSum);
    });
  }

  double get totalSpendingForPercentage {
    /// * .fold() : Reduces a collection(List in this case) to a single value by iteratively combining each element of the collection with an existing value
    ///
    /// * Uses [initialValue] as the initial value,
    /// * then iterates through the elements and updates the value with
    /// * each element using the [combine] function
    /// * Also you need to return the new value which will be pass
    /// * in the funtion for adding with the next element
    return groupedTransactionValues.fold(0.0,
        (currentCalculatedValue, elementWeCurrentlyAreOn) {
      return currentCalculatedValue + elementWeCurrentlyAreOn.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
          children: groupedTransactionValues.map((data) {
        return ChartBar(
            label: data.weekDayName,
            spendingAmount: data.amount,
            spendingPercentageOfTotal: totalSpendingForPercentage == 0.0
                ? 0.0
                : (data.amount / totalSpendingForPercentage));
      }).toList()),
    );
  }
}
