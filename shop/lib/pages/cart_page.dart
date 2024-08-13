import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/order_list_provider.dart';
import 'package:shop/utils/app_show_message.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isLoading = false;

  void _comprar(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final orderListProvider =
        Provider.of<OrderListProvider>(context, listen: false);

    setState(() => _isLoading = true);
    await orderListProvider.addOrder(cartProvider);
    setState(() => _isLoading = false);
    cartProvider.clear();

    AppShowMessage.showAlert(
        context, CoolAlertType.success, "Pedido finalizado com sucesso!", null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<CartProvider>(
              builder: (ctx, cartProvider, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
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
                                  'R\$ ${cartProvider.totalAmount.toStringAsFixed(2).replaceAll('.', ',')}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                backgroundColor: Colors.purple,
                              ),
                              const Spacer(),
                              if (cartProvider.totalAmount > 0)
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
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartProvider.itemsCount,
                          itemBuilder: (ctx, index) => CartItemWidget(
                              cartItem:
                                  cartProvider.items.values.toList()[index])),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
