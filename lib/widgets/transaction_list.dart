/// * Displays the Transaction entered by the user through the ModalSheet
///
/// * Uses if-else condition in the body
/// * Used ListView.builder to create scrollable ListViews

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

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
        : ListView(
            children: transactions
                .map(
                  (tx) => TransactionItem(key: ValueKey(tx.id),deleteTx: deleteTx, transaction: tx),
                )
                .toList());
                /// ! Because key have a bug with ListView.builder. though for long lists we suggest use ListView.builder, here it is exception as we need keys to cahnge bg color of our avatar in transaction item.
    // : ListView.builder(
    //     // ! 🛑 ListView default takes infinite space, Iniitalize height to parent carefully
    //     // * Gives the context[we dont need] also give the index of the current element at pos
    //     itemBuilder: (_context, index) {
    //       // Here our transaction_item needs only 1 transaction so we are only passing one transaction at our index
    //       return TransactionItem(key: ValueKey(transactions[index].id) ,transaction: transactions[index], deleteTx: deleteTx);
    //     },
    //     itemCount: transactions.length,
    //   );
  }
}
