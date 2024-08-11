import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/order_list_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final itemsCart = cartProvider.items.values.toList();
    final orderListProvider = Provider.of<OrderListProvider>(context, listen: false);

    void _comprar(BuildContext context) async {
      setState(() => _isLoading = true);
      await orderListProvider.addOrder(cartProvider);
      setState(() => _isLoading = false);
      cartProvider.clear();
       CoolAlert.show(
        title: "Pedido finalizado com sucesso!",
        context: context,
        type: CoolAlertType.success,
        backgroundColor: Colors.purple,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child:
                      Consumer<CartProvider>(builder: (ctx, provider, widget) {
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
                                  onPressed: () => _comprar(context),
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
