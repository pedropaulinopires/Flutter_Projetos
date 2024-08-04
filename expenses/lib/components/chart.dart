import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this._recentTransactions, {super.key});

  final List<Transaction> _recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final data = DateTime.now().subtract(Duration(days: index));
      final diaSemana = DateFormat('dd-MM-yyyy').format(data);

      double valorTotal = 0;

      _recentTransactions
          .where((x) {
            return DateFormat('dd-MM-yyyy').format(x.date) == diaSemana;
          })
          .toList()
          .forEach((x) => valorTotal += x.value);

      return {
        'day': DateFormat('EEEE').format(data)[0],
        'value': valorTotal,
      };
    }).toList();
  }

  double get valueTotalWeek{
    return groupedTransactions.fold(0 ,(sum, ele) {
      return sum + (ele['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 15),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: groupedTransactions.reversed.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: e['day'].toString(),
                valor: e['value'] as double,
                valorPercentual: ((e['value'] ?? 0 )as double) / valueTotalWeek,
              ),
            );
          }).toList()),
    );
  }
}
