import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas/provider/meal_list_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget _createSwitch(
      String title, String subTitle, bool value, Function(bool value) fn) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: (value) {
        fn(value);
      },
      activeColor: Colors.pink,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealListProvider>(context);
    final settingsApp = provider.settingsApp;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Configurações',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _createSwitch(
                'Sem glútem',
                'Só exibe refeições sem glútem',
                settingsApp.isGlutenFree,
                (value) => setState(() => settingsApp.isGlutenFree = value)),
            _createSwitch(
                'Sem lactose',
                'Só exibe refeições sem lactose',
                settingsApp.isLactoseFree,
                (value) => setState(() => settingsApp.isLactoseFree = value)),
            _createSwitch(
                'Vegana',
                'Só exibe refeições veganas',
                settingsApp.isVegan,
                (value) => setState(() => settingsApp.isVegan = value)),
            _createSwitch(
                'Vegetariana',
                'Só exibe refeições vegetarianas',
                settingsApp.isVegetarian,
                (value) => setState(() => settingsApp.isVegetarian = value))
          ],
        ),
      ),
    );
  }
}
