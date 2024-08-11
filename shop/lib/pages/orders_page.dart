import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/providers/order_list_provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderListProvider>(context, listen: false)
        .loadProducs()
        .then((v) {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Consumer<OrderListProvider>(
                builder: (context, value, child) {
                  return RefreshIndicator(
                    onRefresh: () =>
                        Provider.of<OrderListProvider>(context, listen: false)
                            .loadProducs(),
                    child: ListView.builder(
                      itemCount: value.items.length,
                      itemBuilder: (context, index) =>
                          OrderItem(order: value.items[index]),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
