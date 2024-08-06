import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/providers/product_list_provider.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providerProducts = Provider.of<ProductListProvider>(context);
    final products = providerProducts.items();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
        actions: [IconButton(onPressed: () => Navigator.of(context).pushNamed(AppRoutes.productForm), icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) =>
              Column(
                children: [
                  ProductItem(product: products[index]),
                  const Divider()
                ],
              ),
        ),
      ),
    );
  }
}
