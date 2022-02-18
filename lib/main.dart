// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/body_column.dart';
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
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Personel Expense',
            home: MyHomePage(),
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              brightness: Brightness.dark,
              primaryColor: CupertinoColors.systemOrange,
            ),
          )
        : MaterialApp(
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
// User will add the transactions
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

    /// * By default dart couldnt parse that appBar has a size method called PrefferedSize so we need to explicitly set AppBar
    /// * to say that this will have PrefferedSize method also for android we used as PrefferedSizeWidget at end of our appBar
    /// * & For IOS we use ObstructingPreferredSizeWidget when using appBAt for IOS,
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personel Expense'),
            trailing: Row(
              // * Will only take the size(width) as much his children needs
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () => _addNewTransactionModalSheet(context),
                    child: Icon(CupertinoIcons.add)),
              ],
            ),
          )
        : AppBar(
            title: Text('Personel Expense'),
            actions: [
              IconButton(
                  onPressed: () => _addNewTransactionModalSheet(context),
                  icon: Icon(
                    Icons.add,
                    color: Colors.amberAccent,
                  ))
            ],
          ) as PreferredSizeWidget;

    final isLandScape = mediaQuery.orientation == Orientation.landscape;

// 😆To avoid Duplication of code,
// !🛑 This variable is refferd multiple times in mulitple files
    final txList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

// !🟥 This is main body of our app stored in a variable so that we can render different widgets based on device paltform
    /// * SafeArea: It says that we respect the reserved size in IOS for notch and it then pushes our widget down so that everything is peoperly visible
    final bodyOfApp = SafeArea(
      child: SingleChildScrollView(
        // * Whole body is shifted to another file to make code consice
          child: BodyOfApp(
        appBar: appBar,
        isChanged: _isChanged,
        isLandScape: isLandScape,
        mediaQuery: mediaQuery,
        recentTransactions: _recentTransactions,
        txList: txList,
      )),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: bodyOfApp,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyOfApp,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _addNewTransactionModalSheet(context),
                  ));
  }
}
