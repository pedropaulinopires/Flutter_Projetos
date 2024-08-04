import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:receitas/components/meal_item.dart';
import 'package:receitas/provider/meal_list_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealListProvider>(context);
    final favorites = provider.getFavoritesMeal();

    return favorites.isEmpty
        ? const Center(
            child: Text(
            "Sem receitas favoritas !",
            style: TextStyle(fontSize: 22),
          ))
        : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (ctx, index) => MealItem(meal: favorites[index]),
          );
  }
}
