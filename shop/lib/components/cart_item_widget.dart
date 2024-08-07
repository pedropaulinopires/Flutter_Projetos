import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cartItem});
  final CartItem cartItem;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartProvider.removeItem(cartItem);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Tem certeza'),
              content: const Text('Você deseja remover o produto do carrinho?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Não')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Sim'))
              ],
            );
          },
        );
      },
      background: Container(
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        margin: const EdgeInsets.only(bottom: 15, right: 15),
        alignment: Alignment.centerRight,
        child: const SizedBox(
          width: 70,
          child: Icon(
            color: Colors.white,
            size: 40,
            Icons.delete,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
        child: ListTile(
          title: Text(cartItem.title),
          subtitle: Text(
              'Valor total: R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2).replaceAll('.', ',')}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }
}
