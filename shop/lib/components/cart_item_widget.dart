import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/product_list_provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cartItem});
  final CartItem cartItem;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductListProvider>(context, listen: false)
        .items()
        .firstWhere((x) => x.id == cartItem.productId);

    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartProvider.removeItem(cartItem);
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text(
                'Valor total: R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2).replaceAll('.', ',')}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}
