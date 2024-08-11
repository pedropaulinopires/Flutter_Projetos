import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/providers/product_list_provider.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

    void showAlert(BuildContext context, CoolAlertType type, String title, String? message) {
      CoolAlert.show(
        title: title,
        context: context,
        type: type,
        backgroundColor: Colors.purple,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.productForm)
                    .then((result) {
                  if (result == 'save') {
                    showAlert(context,CoolAlertType.success,
                        "Produto salvo com sucesso !", null);
                  }
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<ProductListProvider>(
          builder: (ctxB, provider, child) {
            final products = provider.items();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, index) => Column(
                children: [
                  ProductItem(
                    product: products[index],
                    showAlert: ( CoolAlertType type, String title, String? message) => showAlert(context, type, title, message),
                  ),
                  const Divider()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
