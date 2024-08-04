import 'package:expenses/components/item_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this._transactions, this._removeTransaction,
      {super.key});

  final List<Transaction> _transactions;
  final Function(String) _removeTransaction;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                  child: Text(
                    'Sem transações cadastradas!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset(
                    'assets\\images\\dolar.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : 
        
        ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              final e = _transactions[index];
              return ItemList(
                key: GlobalObjectKey(e.id),
                e: e,
                mediaQuery: mediaQuery,
                removeTransaction: _removeTransaction,
              );
            },
          );
  }
}
