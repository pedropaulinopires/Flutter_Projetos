import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lugares_legais/models/Place.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> getItems() => [..._items];

  int get itemsCount => _items.length;

  Place getItemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: null,
      image: image,
    );

    _items.add(newPlace);

    notifyListeners();
  }
}
