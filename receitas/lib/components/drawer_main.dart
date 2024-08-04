import 'package:flutter/material.dart';
import 'package:receitas/utils/app_routes.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  Widget _createItem(IconData icon, String label, Function() fn) {
    return ListTile(
      leading: Icon(
        icon,
        size: 35,
        color: Colors.white,
      ),
      title: Text(
        label,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
      ),
      onTap: fn,
      splashColor: Colors.amber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.pink,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 140,
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(bottom: 15, left: 15),
            child: const Text(
              'Vamos cozinhar?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _createItem(
                  Icons.restaurant,
                  'Refeição',
                  () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
                ),
                _createItem(
                  Icons.settings,
                  'Configurações',
                  () => Navigator.of(context).pushNamed(AppRoutes.SETTINGS),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
