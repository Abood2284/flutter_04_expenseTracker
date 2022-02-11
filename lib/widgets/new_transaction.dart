// ignore_for_file: prefer_const_constructors

/// * Reutrns Card Widget that have 2 TextField and 1 Flat button that displayes user userTransaction
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTxn;

  NewTransaction(this.addTxn);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

/// * Submits the data to be displayed in transaction
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; // ! Dont run below code if true
    }

    /// * To access variable of widget class in state class, use widget.variableName
    widget.addTxn(
      enteredTitle,
      enteredAmount,
    );

    // ? built in flutter possibilities to pop the topmost screen [the Modalsheet transaction section]. we will look deep in further section
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
              /*
               onChanged: (val) {
                 titleInput = val;
               }, 
               */
              /// * Reads every user Key Strokes in UI
              controller:
                  titleController,
              onSubmitted:
                  (_) =>
                      submitData(),
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.deepOrange)),
            ),
            TextField(
              controller: amountController,
              onSubmitted: (_) => submitData(),
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
