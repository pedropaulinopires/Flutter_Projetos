import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';

class ProductListProvider with ChangeNotifier {
  final List<Product> _items = [];
  bool _filterFavorites = false;
  static const _urlBase = 'https://treino-app-1234-default-rtdb.firebaseio.com';
  List<Product> items() => [..._items];

  List<Product> itemsGrid() {
    if (_filterFavorites) {
      return [..._items].where((x) => x.isFavorite).toList();
    }
    return [..._items];
  }

  Future<void> favoriteProduct(Product product) async {
    _items
        .firstWhere(
          (element) => element.id == product.id,
        )
        .toggleFavorite();
    notifyListeners();
    
    final response = await http.patch(
        Uri.parse('$_urlBase/products/${product.id}.json'),
        body: jsonEncode({"isFavorite": product.isFavorite}));

    if (response.statusCode >= 400) {
      _items
          .firstWhere(
            (element) => element.id == product.id,
          )
          .toggleFavorite();
      throw Exception('Erro ao adicionar no favorito!');
    }
  }

  Future<void> loadPodcts() async {
    _items.clear();
    final response = await http.get(Uri.parse('$_urlBase/products.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {
      _items.add(Product(
          id: key,
          title: value['title'] as String,
          description: value['description'] as String,
          price: value['price'] as double,
          imageUrl: value['imageUrl'] as String,
          isFavorite: value['isFavorite'] as bool));
      notifyListeners();
    });
  }

  void filterFavorites() {
    _filterFavorites = true;
    notifyListeners();
  }

  void filterAll() {
    _filterFavorites = false;
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) async {
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
      return updateProduct(product, data);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_urlBase/products.json'),
      body: jsonEncode({
        "title": product.title,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
      }),
    );

    final id = jsonDecode(response.body)['name'];

    product.id = id;
    _items.add(product);
    notifyListeners();
  }

  Future<void> updateProduct(Product product, Map<String, Object> data) async {
    final index = _items.indexWhere((p) => p.id == data['id']);

    final response = await http.patch(
      Uri.parse('$_urlBase/products/${product.id}.json'),
      body: jsonEncode({
        "title": product.title,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
      }),
    );
    if (index >= 0) {
      _items[index] = product;
    }
    notifyListeners();
  }

  Future<void> deleteProduct(Product product) async {
    final index = _items.indexOf(product);
    _items.remove(product);
    notifyListeners();

    final response =
        await http.delete(Uri.parse('$_urlBase/products/${product.id}.json'));

    if (response.statusCode >= 400) {
      _items.insert(index, product);
      notifyListeners();
      throw Exception('Erro ao excluir');
    }
  }
}
