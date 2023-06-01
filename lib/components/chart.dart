// ignore_for_file: prefer_const_constructors

import 'package:despesas_pessoais/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      if (recentTransactions.length == 0)
        return {
          'day': '',
          'value': 0,
        };

      var lastWeekTransactions = recentTransactions.where((e) {
        var sameDay = e.date.day == weekDay.day;
        var sameMonth = e.date.month == weekDay.month;
        var sameYear = e.date.year == weekDay.year;

        return sameYear && sameMonth && sameDay;
      }).toList();

      for (var tr in lastWeekTransactions) {
        totalSum += tr.value;
      }

      var initialWeekDay = DateFormat.E().format(weekDay)[0];

      print(initialWeekDay);
      print(totalSum);
      return {
        'day': initialWeekDay,
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransaction.fold(
        0.0, (sum, tr) => sum + (tr['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction
              .map((tr) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: tr['day'].toString(),
                      value: tr['value'] as double,
                      percentage: (tr['value'] as double) / _weekTotalValue,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
