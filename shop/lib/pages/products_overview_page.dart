import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badge_item.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/product_list_provider.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterItems { favoties, all }

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductListProvider>(context);

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    void closeDrawer() {
      if (_scaffoldKey.currentState != null &&
          _scaffoldKey.currentState!.isDrawerOpen) {
        _scaffoldKey.currentState!.openEndDrawer();
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(closeDrawer: closeDrawer),
      appBar: AppBar(
        title: const Text('Minha loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                const PopupMenuItem(
                  value: FilterItems.favoties,
                  child: Text('Somente favoritos'),
                ),
                const PopupMenuItem(
                  value: FilterItems.all,
                  child: Text('Filtrar todos'),
                )
              ];
            },
            onSelected: (value) {
              if (value == FilterItems.all) {
                provider.filterAll();
              } else {
                provider.filterFavorites();
              }
            },
          ),
          Consumer<CartProvider>(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
            ),
            builder: (context, cart, child) {
              return BadgeItem(
                  value: cart.itemsCount.toString(),
                  visible: cart.itemsCount > 0,
                  child: child!);
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: ProductGrid(),
      ),
    );
  }
}
