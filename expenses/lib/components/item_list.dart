import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemList extends StatefulWidget {
  const ItemList({
    super.key,
    required this.e,
    required this.mediaQuery,
    required Function(String p1) removeTransaction,
  }) : _removeTransaction = removeTransaction;

  final Transaction e;
  final MediaQueryData mediaQuery;
  final Function(String p1) _removeTransaction;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final List<MaterialColor> listaCores = [
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.yellow
  ];

  final int indexCor = Random().nextInt(6);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: listaCores[indexCor],
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
                child: Text(
              'R\$${widget.e.value.toStringAsFixed(2).replaceAll('.', ',')}',
            )),
          ),
        ),
        title: Text(widget.e.description,
            style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(
          DateFormat('d MMM yy').format(widget.e.date),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: widget.mediaQuery.size.width > 480
            ? TextButton.icon(
                onPressed: () => widget._removeTransaction(widget.e.id),
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 190, 105, 99),
                ),
                label: Text(
                  'Excluir',
                  style: TextStyle(
                      fontSize: widget.mediaQuery.textScaler.scale(18),
                      color: Theme.of(context).colorScheme.error),
                ),
              )
            : IconButton(
                onPressed: () => widget._removeTransaction(widget.e.id),
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 190, 105, 99),
                ),
              ),
      ),
    );
  }
}
