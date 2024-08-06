import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
