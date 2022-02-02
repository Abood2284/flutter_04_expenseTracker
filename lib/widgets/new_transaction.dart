// ignore_for_file: prefer_const_constructors

// This Widget file Reutrns Card Widget that have 2 TextField and 1 Flat button for user to input new transaction

import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTxn;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTxn);
  void submitData() {
    if (amountController.text.isEmpty || titleController.text.isEmpty) {
      return;  // after hitting return the code below will not be executed
    }
    addTxn(
        titleController.text,
        double.parse(amountController
            .text)); // Because _addTx expects amount to be a double
  }

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
              onSubmitted: (_) =>
                  submitData(), // So that when user press the enter on the keyboard the data gets submutted.
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.deepOrange)),
            ),
            TextField(
              controller: amountController,
              onSubmitted: (_) =>
                  submitData(), // Because onSubmitted gives us the String return, indeed i dont need it so we are showing that we are accepting the String but are not using it by sign _
              keyboardType: TextInputType.numberWithOptions(
                  decimal: true), // IOS supports this type of approach
              decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.deepOrange)),
            ),
            FlatButton(
              onPressed: submitData,
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
