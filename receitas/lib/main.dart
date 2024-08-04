import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas/models/category.dart';
import 'package:receitas/models/meal.dart';
import 'package:receitas/provider/meal_list_provider.dart';
import 'package:receitas/screens/categories_meals_screen.dart';
import 'package:receitas/screens/meal_detail_screen.dart';
import 'package:receitas/screens/settings_screen.dart';
import 'package:receitas/screens/tabs_screen.dart';
import 'package:receitas/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MealListProvider(),
      child: MaterialApp(
          title: 'Receitas',
          theme: ThemeData(
              fontFamily: 'Raleway',
              textTheme: ThemeData.light().textTheme.copyWith(
                    titleLarge: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoCondensed',
                        color: Colors.white),
                    titleMedium: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'RobotoCondensed'),
                  )),
          onGenerateRoute: (settings) {
            if (settings.name == AppRoutes.HOME) {
              return _createRoute(const TabsScreen());
            } else if (settings.name == AppRoutes.CATEGORIES_MEALS) {
              return _createRoute(CategoriesMealsScreen(
                category: settings.arguments as Category,
              ));
            } else if (settings.name == AppRoutes.MEAL_DETAIL) {
              return _createRoute(MealDetailScreen(
                meal: settings.arguments as Meal,
              ));
            } else if (settings.name == AppRoutes.SETTINGS) {
              return _createRoute(const SettingsScreen());
            }
            return _createRoute(const TabsScreen());
          }),
    );
  }
}
