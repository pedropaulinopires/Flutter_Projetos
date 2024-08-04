import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/providers/order_list_provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderListProvider = Provider.of<OrderListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: orderListProvider.items.length,
          itemBuilder: (context, index) =>
              OrderItem(order: orderListProvider.items[index]),
        ),
      ),
    );
  }
}
