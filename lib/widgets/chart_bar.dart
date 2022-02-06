import 'package:/flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar(
      {required this.label,
      required this.spendingAmount,
      required this.spendingPercentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '\$${spendingAmount.toStringAsFixed(0)}',
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox( // * Widget that sizes its child to a fraction of the total available space {Takes Value between 0 & 1}
                heightFactor: spendingPercentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
