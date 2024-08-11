import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_list_provider.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.showAlert,
  });
  final Product product;
  final void Function(CoolAlertType type, String title, String? message)
      showAlert;

  Future<void> _editProduct(BuildContext context) async {
    final result = await Navigator.of(context)
        .pushNamed(AppRoutes.productForm, arguments: product);

    if (result == 'update') {
      showAlert(CoolAlertType.success, "Produto editado com sucesso !", null);
    }
  }

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
            onPressed: () => _editProduct(context),
            icon: const Icon(Icons.edit),
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Excluir produto'),
                      content: const Text(
                          'Você realmente deseja remover o produto?'),
                      actions: [
                        TextButton(
                          child: const Text('Não'),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                        TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Provider.of<ProductListProvider>(context,
                                    listen: false)
                                .deleteProduct(product)
                                .then((onValue) => showAlert(
                                    CoolAlertType.success,
                                    "Sucesso ao remover o produto !",
                                    null))
                                .catchError((onError) => showAlert(
                                    CoolAlertType.error,
                                    "Erro ao remover o produto !",
                                    null));
                          },
                        )
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
