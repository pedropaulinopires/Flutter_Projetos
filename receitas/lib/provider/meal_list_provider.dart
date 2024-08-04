import 'package:flutter/material.dart';
import 'package:receitas/data/dummy_data.dart';
import 'package:receitas/models/category.dart';
import 'package:receitas/models/meal.dart';
import 'package:receitas/models/settings.dart';

class MealListProvider with ChangeNotifier {
  final List<Meal> _meals = dummyMeals;
  final List<Category> _categories = dummyCategories;
  Settings settingsApp = Settings();
  final List<Meal> _favoritesMeal = [];

  List<Meal> getAvaliableMeals() => [
        ..._meals.where((meal) {
          bool filterGluten = settingsApp.isGlutenFree && !meal.isGlutenFree;
          bool filterLactose = settingsApp.isLactoseFree && !meal.isLactoseFree;
          bool filterVegan = settingsApp.isVegan && !meal.isVegan;
          bool filterVegetarian =
              settingsApp.isVegetarian && !meal.isVegetarian;
          return !filterGluten &&
              !filterLactose &&
              !filterVegan &&
              !filterVegetarian;
        })
      ];
  List<Meal> getFavoritesMeal() => [..._favoritesMeal];
  List<Category> getCategories() => [..._categories];

  void toggleFavorite(Meal meal) {
    _favoritesMeal.contains(meal)
        ? _favoritesMeal.remove(meal)
        : _favoritesMeal.add(meal);
    notifyListeners();
  }

  bool isFavorite(Meal meal) => _favoritesMeal.contains(meal);

}
