// ignore_for_file: prefer_const_constructors

// This Widget file Reutrns Card Widget that have 2 TextField and 1 Flat button for user to input new transaction

import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTxn;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTxn);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.deepOrange)),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.deepOrange)),
            ),
            FlatButton(
              onPressed: () {
                addTxn(
                    titleController.text,
                    double.parse(amountController.text)); // Because _addTx expects amount to be a double
              },
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
