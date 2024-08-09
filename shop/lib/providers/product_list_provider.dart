import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductListProvider with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  bool _filterFavorites = false;
  static const _urlBase = 'https://treino-app-1234-default-rtdb.firebaseio.com';
  List<Product> items() => [..._items];

  List<Product> itemsGrid() {
    if (_filterFavorites) {
      return [..._items].where((x) => x.isFavorite).toList();
    }
    return [..._items];
  }

  void favoriteProduct(Product product) {
    _items
        .firstWhere(
          (element) => element.id == product.id,
        )
        .toggleFavorite();
    notifyListeners();
  }

  void filterFavorites() {
    _filterFavorites = true;
    notifyListeners();
  }

  void filterAll() {
    _filterFavorites = false;
    notifyListeners();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void saveProduct(Map<String, Object> data) {
    final hasId = data['id'] != null;

    var product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
      isFavorite: hasId ? data['isFavorite'] as bool : false,
    );

    if (hasId) {
      final index = _items.indexWhere((p) => p.id == data['id']);
      if (index >= 0) {
        _items[index] = product;
      }
      notifyListeners();
    } else {
      final future = http.post(
        Uri.parse('$_urlBase/products.json'),
        body: jsonEncode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": hasId ? product.isFavorite : false,
        }),
      );

      future.then((response) {
        final id = jsonDecode(response.body)['name'];
        product.id = id;
        _items.add(product);
        notifyListeners();
      });
    }
  }

  void deleteProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}
