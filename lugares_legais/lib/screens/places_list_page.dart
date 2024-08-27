import 'package:flutter/material.dart';
import 'package:lugares_legais/provider/greate_places.dart';
import 'package:lugares_legais/utils/app_routes.dart';
import 'package:provider/provider.dart';

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
      body: FutureBuilder(
        future: Provider.of<GreatePlaces>(context).loadPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.error != null) {
            return const Center(
                child: Text(
              'Ocorreu um erro!',
              style: TextStyle(fontSize: 20),
            ));
          } else {
            return Consumer<GreatePlaces>(
              builder: (context, greatePlaces, child) {
                return greatePlaces.itemsCount <= 0
                    ? const Center(
                        child: Text(
                        'Sem lugares cadastrados !',
                        style: TextStyle(fontSize: 20),
                      ))
                    : ListView.builder(
                        itemCount: greatePlaces.itemsCount,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                                greatePlaces.getItemByIndex(index).image),
                          ),
                          title: Text(greatePlaces.getItemByIndex(index).title),
                        ),
                      );
              },
            );
          }
        },
      ),
    );
  }
}
