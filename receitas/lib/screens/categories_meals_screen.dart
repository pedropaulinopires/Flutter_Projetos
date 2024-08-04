import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas/components/meal_item.dart';
import 'package:receitas/models/category.dart';
import 'package:receitas/provider/meal_list_provider.dart';

class CategoriesMealsScreen extends StatelessWidget {
  const CategoriesMealsScreen({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealListProvider>(context);
    final mealsCategory = provider
        .getAvaliableMeals()
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: mealsCategory.length,
          itemBuilder: (ctx, index) {
            return MealItem(meal: mealsCategory[index]);
          },
        ),
      ),
    );
  }
}
