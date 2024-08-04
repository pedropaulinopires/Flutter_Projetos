import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductListProvider with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  bool _filterFavorites = false;

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
}
