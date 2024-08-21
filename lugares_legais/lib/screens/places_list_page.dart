import 'package:flutter/material.dart';
import 'package:lugares_legais/utils/app_routes.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus lugares'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.placeForm),
              icon: const Icon(Icons.add))
        ],
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
