// ignore_for_file: prefer_const_constructors

// ! Reutrns Card Widget that have 2 TextField and 1 Flat button for user to add new transaction

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  /// * This file has 2 class to be precise this is Widget class and the below one is called state class
  /// * To get pass information from widget class to state class FLutter establishes  a connection and that can be accesed using widget. in state class
  final Function addTxn;

  NewTransaction(this.addTxn);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;   // ! If code hits return the code below will not be executed
    }
// ? Connection was established by flutter and now we can use the information from the widget class in our state class
    widget.addTxn(
      enteredTitle,
      enteredAmount,
    ); // Because _addTx expects amount to be a double

    // ? built in flutter possibilities to pop the topmost screen [the transaction section]. we will look deep in further section
    Navigator.of(context).pop();
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
              // onChanged: (val) {
              //   titleInput = val;
              // },
              controller: titleController,   // * Controller reads every user Key Strokes in UI
              onSubmitted: (_) =>     // * On submitted is triggered when user hits enter in the  UI keyboard
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
                  decimal: true), // * IOS supports this type of approach
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
