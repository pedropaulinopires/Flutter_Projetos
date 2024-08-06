import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/product_list_provider.dart';
import 'package:shop/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductListProvider>(context);
    final providerCart = Provider.of<CartProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () => provider.favoriteProduct(product),
            icon: Icon(
              Icons.favorite,
              color: product.isFavorite ? Colors.red : Colors.white,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              providerCart.addItem(product);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Produto adicionado no carrinho!'),
                action: SnackBarAction(label: 'DESFAZER', onPressed: () {
                  providerCart.removeSingleItem(product.id);
                }),
              ));
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
        child: GestureDetector(
          child: Hero(
            tag: product.id,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.productDetail, arguments: product);
          },
        ),
      ),
    );
  }
}
