import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lugares_legais/models/Place.dart';
import 'package:lugares_legais/utils/db_util.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> getItems() => [..._items];

  Future<void> loadPlaces() async {
    final List<Map<String, Object?>> dataList = await DbUtil.getData('Place');
    _items = dataList.map((item) {
      return Place(
        id: (item['Id'] as int).toString(),
        title: item['Title'] as String,
        image: File(item['Image'] as String),
        location: null,
      );
    }).toList();
  }

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

    DbUtil.insert(
        'Place', {'Title': newPlace.title, 'Image': newPlace.image.path});

    notifyListeners();
  }
}
