import 'package:flutter/material.dart';

import 'chart.dart';
import '../models/transaction.dart';

class HomeBody extends StatefulWidget {
  final Container txList;
  final List<Transaction> recentTransactions;
  final isLandScape;
  final PreferredSizeWidget appBar;
  final mediaQuery;
  bool isChanged;

  HomeBody({
    required this.txList,
    required this.isChanged,
    required this.recentTransactions,
    required this.isLandScape,
    required this.appBar,
    required this.mediaQuery,
  });

  @override
  _BodyOfAppState createState() => _BodyOfAppState();
}

class _BodyOfAppState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // * Show the switch only if the orientation is landscape, refer to variable bool isLandscape
          if (widget.isLandScape) 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show chart'),
                Switch(
                    value: widget.isChanged,
                    onChanged: (val) {
                      setState(() {
                        widget.isChanged = val;
                      });
                    }),
              ],
            ),
          // * If orientation is Portrait i want to see botht chart & txList
          if (!widget.isLandScape)
            // !🛑 Below code is not duplicated -> changes [ 0.7 -> 0.3 ]
            Container(
                height: (widget.mediaQuery.size.height -
                        widget.appBar.preferredSize.height -
                        widget.mediaQuery.padding.top) *
                    0.3,
                child: Chart(widget.recentTransactions)),
          if (!widget.isLandScape)
            widget.txList, // * reffering to the variable that holds the container in main.dart
          // * If orientation landscape show the turnary expression
          if (widget.isLandScape)
            widget.isChanged
                ? Container(
      
                    /// * 🟩 MediaQuery is a class that allows styling widgets according to the devivce user have
                    ///
                    /// * is used here to get the full height of the user's-device thought
                    /// * MediaQuery takes appBAr height and the top padding height in calculation
                    /// * we dont want to split height with appBAr right? so substracting these 2 values
                    /// * gets you the full height of the user-device screen. which now can render you widgets
                    height: (widget.mediaQuery.size.height -
                            widget.appBar.preferredSize.height -
                            widget.mediaQuery.padding.top) *
                        0.7,
                    child: Chart(widget.recentTransactions))
                : widget
                    .txList // * reffering to the variable that holds the container
        ]),
      ),
    );
  }
}
