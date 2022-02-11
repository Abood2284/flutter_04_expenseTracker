/// * Displays the Transaction entered by the user through the ModalSheet
///
/// * Uses if-else condition in the body

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
// TODO : Wrap container in FractionallySixedBox with height factor of 30%
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No tranasctions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png'))
              ],
            )
          : ListView.builder(
              // ! We defined it's parent(Container) height 300 becoz, ListView default takes infinite space resulting in no widgets rendered
              // * Gives the context[we dont need] also give the index of the current element at pos
              itemBuilder: (_context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 7, horizontal: 4),
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                        child: Padding(padding: EdgeInsets.all(5), child: FittedBox(child: Text('\$${transactions[index].amount}'))),
                        radius: 30),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle:
                        Text(DateFormat.yMMMd().format(transactions[index].date)),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
