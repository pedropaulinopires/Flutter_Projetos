import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth_provider.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.closeDrawer});

  final void Function() closeDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Seja bem vindo!'),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            selected: true,
            title: const Text('Loja'),
            onTap: () => closeDrawer(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add_card_rounded),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.orders);
              Future.delayed(
                  const Duration(milliseconds: 200), () => closeDrawer());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gerenciar produtos'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.products);
              Future.delayed(
                  const Duration(milliseconds: 200), () => closeDrawer());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
