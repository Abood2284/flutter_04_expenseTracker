// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/child.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personel Expense',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        // * refer to this Meta-Data using [style: Theme.of(context).textTheme.headline6]
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: AppBarTheme(
            // * Will set all your screens AppBar title with this meta-Data
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Weekly Groceries',
    //     amount: 16.53,
    //     date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    // for (var i = 0; i < _userTransactions.length; i++) {
    //   if (_userTransactions[i]
    //       .date
    //       .isAfter(DateTime.now().subtract(Duration(days: 7)))) {
    //     return _userTransactions;
    //   }
    // }

    return _userTransactions.where((tx) { // if func return true the data will be stored in the newly returned list
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList(); 
  }

  /*
   * @param txTitle
   */
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

  void _addNewTransactionModalSheet(BuildContext modalContext) {
    showModalBottomSheet(
        context: modalContext,
        builder: (_) {
          // it will return ctx which we dont need so we use _ to show other dev we dont need the returned ctx
          return GestureDetector(
              onTap: () {},
              child: NewTransaction(_addTx),
              behavior: HitTestBehavior.opaque);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Personel Expense'),
          actions: [
            IconButton(
                onPressed: () => _addNewTransactionModalSheet(context),
                icon: Icon(
                  Icons.add, // Choosing the right button
                  color: Colors.amberAccent,
                ))
          ],
        ),
        body: SingleChildScrollView(
          // To make list scrollable
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Chart(_recentTransactions),
                TransactionList(_userTransactions)
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _addNewTransactionModalSheet(context),
        ));
  }
}
