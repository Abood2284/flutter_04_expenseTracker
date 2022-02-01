// Responsible for for updating the UI through stateful widget
// it only calls the build method on that part of the UI which data has changed nd need to be re-painted
// It also has a private method which creates a new Transaction method and calls setState with adding the new Transaction in the List<Transaction>

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now()),
  ];

  void _addTx(String txTitle, double txAmount) {
    // This function creates a new object from Transaction model and updates the state using setState.
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          NewTransaction(_addTx), 
          TransactionList(_userTransactions)]);
  }
}
