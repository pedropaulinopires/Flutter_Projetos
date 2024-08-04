import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/order_list_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final itemsCart = cartProvider.items.values.toList();
    final orderListProvider = Provider.of<OrderListProvider>(context, listen: false);

    void _comprar() {
      orderListProvider.addOrder(cartProvider);
      cartProvider.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<CartProvider>(builder: (ctx, provider, widget) {
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 15),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 19),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Chip(
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide.none),
                        label: Text(
                          'R\$ ${provider.totalAmount.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                        backgroundColor: Colors.purple,
                      ),
                      const Spacer(),
                      if (provider.totalAmount > 0)
                        TextButton(
                            onPressed: () => _comprar(),
                            child: const Text(
                              'COMPRAR',
                              style: TextStyle(fontSize: 15),
                            ))
                      else
                        const Text(
                          'Carrinho vazio!',
                          style: TextStyle(fontSize: 15),
                        )
                    ],
                  ),
                ),
              );
            }),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemsCart.length,
                itemBuilder: (ctx, index) =>
                    CartItemWidget(cartItem: itemsCart[index])),
          ),
        ],
      ),
    );
  }
}
