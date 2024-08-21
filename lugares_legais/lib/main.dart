import 'package:flutter/material.dart';
import 'package:lugares_legais/provider/greate_places.dart';
import 'package:lugares_legais/screens/place_form_page.dart';
import 'package:lugares_legais/screens/places_list_page.dart';
import 'package:lugares_legais/utils/app_create_route.dart';
import 'package:lugares_legais/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => GreatePlaces())],
      child: MaterialApp(
        title: 'Lugares legais',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
                primary: Colors.blue, secondary: Colors.amber),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                color: Colors.blue,
                foregroundColor: Colors.white,
                titleTextStyle: TextStyle(fontSize: 24),
                toolbarHeight: 80)),
        initialRoute: AppRoutes.initial,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.initial) {
            return AppCreateRoute.createRoute(const PlacesListPage());
          } else if (settings.name == AppRoutes.placeForm) {
            return AppCreateRoute.createRoute(const PlaceFormPage());
          }

          return AppCreateRoute.createRoute(const PlacesListPage());
        },
      ),
    );
  }
}
