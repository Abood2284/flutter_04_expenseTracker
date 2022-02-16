// ignore_for_file: prefer_const_constructors

/// * Reutrns Card Widget that have 2 TextField and 1 Flat button that displayes user userTransaction
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTxn;

  NewTransaction(this.addTxn);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _choosenDate;

  /// * Submits the data to be displayed in transaction
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _choosenDate == null) {
      return; // ! Dont run below code if true
    }

    /// * To access variable of widget class in state class, use widget.variableName
    widget.addTxn(enteredTitle, enteredAmount, _choosenDate);

    // ? built in flutter possibilities to pop the topmost screen [the Modalsheet transaction section]. we will look deep in further section
    Navigator.of(context).pop();
  }

  void _presentDatePickerOnScreen() {
    /// * Displayes the DatePicker screen which is built by Flutter
    /// * {returns} Future date value which we handle using {.then()} method
    /// * {.then()} method will be executed when showDatePicker returns us Future Value {exactly when user presses 'ok' or 'cancel' on the DatePicker screen}
    ///
    /// * @param{context} takes the context of the current file/class
    /// * @param{initialDate} date which will be selected when the user open the date picker
    /// * @param{firstDate} first date that can be choosen by the user
    /// * @param{lastDate} last date that can be choosen by the user
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      /// * Executes only if pickedDate is null
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _choosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          ///* Now our keyboard becomes a burden while entering the data
          ///* You will know once you hover over viewInsets that it displays the parts of the UI 
          ///* that is covered by the SYSTEM i.e: Keyboard
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
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
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.deepOrange)),
              ),
              TextField(
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true), // * IOS supports this type of approach
                decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(color: Colors.deepOrange)),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(_choosenDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_choosenDate!)}'),
                    SizedBox(
                      width: 30,
                    ),

                    /// * That will take all the width available after giving our Text Widget the space it needs
                    Expanded(
                      child: TextButton(
                        onPressed: _presentDatePickerOnScreen,
                        child: Text('Choose Date'),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
