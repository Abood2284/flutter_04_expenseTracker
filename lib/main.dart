// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() {
  /// * Locking the device orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personel Expense',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',

        /// * Created Own textTheme to be used for headlines {Theme.of(context).textTheme.headline6}
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
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
    /* Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now()),
        */
  ];

  List<Transaction> get _recentTransactions {
    /// * if returns true data will be stored in the newly returned list
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  /// * Sets the state of the switch
  bool _isChanged = false;

  /// * Add new objects in TransactionList + Updates the State
  void _addTx(String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: selectedDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  /// * Generates a pop up Modal sheet Using current context
  void _addNewTransactionModalSheet(BuildContext modalContext) {
    /// * Pop ups the sheet with the help of builder
    showModalBottomSheet(
        context: modalContext,

        /// * Returned value is never needed. So marked _
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              child: NewTransaction(_addTx),
              behavior: HitTestBehavior.opaque);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      /// * removeWhere iterates over every element in List
      /// * and removes the element which matches the test condition
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🟦 TO avoid duplication of creation of MediaQuery object
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text('Personel Expense'),
      actions: [
        IconButton(
            onPressed: () => _addNewTransactionModalSheet(context),
            icon: Icon(
              Icons.add,
              color: Colors.amberAccent,
            ))
      ],
    );

    final isLandScape =
        mediaQuery.orientation == Orientation.landscape;

// 😆To avoid Duplication of code,
// !🛑 This variable is refferd multiple times only in this file
    final txList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // * Show the switch only if the orientation is landscape, refer to variable bool isLandscape
            if (isLandScape)
              Row(
                children: [
                  Text('Show chart'),
                  Switch(
                      value: _isChanged,
                      onChanged: (val) {
                        setState(() {
                          _isChanged = val;
                        });
                      }),
                ],
              ),
            // * If orientation is Portrait i want to see botht chart & txList
            if (!isLandScape)
              // !🛑 Below code is not duplicated -> changes [ 0.7 -> 0.3 ]
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!isLandScape)
              txList, // * reffering to the variable that holds the container
            // * If orientation landscape show the turnary expression
            if (isLandScape)
              _isChanged
                  ? Container(

                      /// * 🟩 MediaQuery is a class that allows styling widgets according to the devivce user have
                      ///
                      /// * is used here to get the full height of the user's-device thought
                      /// * MediaQuery takes appBAr height and the top padding height in calculation
                      /// * we dont want to split height with appBAr right? so substracting these 2 values
                      /// * gets you the full height of the user-device screen. which now can render you widgets
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions))
                  : txList // * reffering to the variable that holds the container
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _addNewTransactionModalSheet(context),
        ));
  }
}
