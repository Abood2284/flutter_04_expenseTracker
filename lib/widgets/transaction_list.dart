/// * Displays the Transaction entered by the user through the ModalSheet
///
/// * Uses if-else condition in the body
/// * Used ListView.builder to create scrollable ListViews

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty

        /// * LayoutBuilder takes a mandatorty argument called the builder:
        ///
        /// * which then also takes a function and return us the context, and the constraint(which we want here)
        /// * now contraints are the height & widht metadata that layoutBuilder has from its parent
        /// * and now we can assign height dynamically based on the metaData
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No tranasctions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png'))
              ],
            );
          })
        : ListView.builder(
            // ! 🛑 ListView default takes infinite space, Iniitalize height to parent carefully
            // * Gives the context[we dont need] also give the index of the current element at pos
            itemBuilder: (_context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 7, horizontal: 4),
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                              child: Text('\$${transactions[index].amount}'))),
                      radius: 30),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  // * 🚀 I want to show button with icon with some more metadata if user devivce widht is greater than 400
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete),
                          textColor: Theme.of(context).errorColor,
                          label: Text('Delete'),
                        )
                      : IconButton(
                          onPressed: () => deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
