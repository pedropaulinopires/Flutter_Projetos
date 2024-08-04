import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    required this.label,
    required this.valor,
    required this.valorPercentual,
    super.key,
  });

  final String label;
  final double valorPercentual;
  final double valor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(valor.toStringAsFixed(2))),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraint.maxHeight * 0.50,
              width: 12,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(153, 215, 215, 215),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                      heightFactor: valorPercentual.isNaN ? 0 : valorPercentual,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(label)),
            ),
          ],
        ),
      );
    });
  }
}
