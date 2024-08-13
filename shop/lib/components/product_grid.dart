import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_list_provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    Provider.of<ProductListProvider>(context, listen: false).loadPodcts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListProvider>(builder: (context, provider, child) {
      final List<Product> loadProducts = provider.itemsGrid();
      return loadProducts.isEmpty
          ? const Center(
              child: Text(
                'Sem produtos cadastrados!',
                style: TextStyle(fontSize: 19),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 150,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: loadProducts.length,
                itemBuilder: (ctx, index) =>
                    ProductGridItem(product: loadProducts[index]),
              ),
            );
    });
  }
}
