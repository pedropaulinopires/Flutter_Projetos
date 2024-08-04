import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas/components/category_item.dart';
import 'package:receitas/provider/meal_list_provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealListProvider>(context);
    final categoriesItens = provider
        .getCategories()
        .map((category) => CategoryItem(category: category))
        .toList();

    return SafeArea(
      child: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: categoriesItens,
      ),
    );
  }
}
