// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//                         UserTransaction
//                             |returning column
//                            | holding
//           --------------------------------
//         |                                |
//    NewTransaction()              TransactionList(_userTransactions)
//           |                                   |
//         Card(                            Card(
//           TextField                        Row[
//           TextField                             Displaying List(Title nd amount)
//           FlatButton                           ]
//         )                                )
import 'package:flutter/material.dart';
import './widgets/user_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: SingleChildScrollView(   // To make list scrollable
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            width: double.infinity,
            child: Card(
              child: Text('Chart 1'),
              color: Colors.blue,
              elevation: 5,
            ),
          ),
          UserTransactions()
        ]),
      ),
    );
  }
}
