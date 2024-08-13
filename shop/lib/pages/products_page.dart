import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/providers/product_list_provider.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/app_show_message.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

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
                    AppShowMessage.showAlert(context, CoolAlertType.success,
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
                    showAlert: (CoolAlertType type, String title,
                            String? message) =>
                        AppShowMessage.showAlert(context, type, title, message),
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
