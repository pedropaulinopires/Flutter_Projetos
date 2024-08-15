import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/Order.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/providers/cart_provider.dart';

class OrderListProvider with ChangeNotifier {
  List<Order> _items;
  final String _token;
  final String _idUser;
  List<Order> get items => [..._items];

  int get itensCount => _items.length;

  static const _urlBase = 'https://treino-app-1234-default-rtdb.firebaseio.com';

  OrderListProvider(this._token, this._idUser, this._items);

  Future<void> addOrder(CartProvider cartProvider) async {
    final response = await http.post(
      Uri.parse('$_urlBase/order/$_idUser.json?auth=$_token'),
      body: jsonEncode({
        "total": cartProvider.totalAmount,
        "products": cartProvider.items.values.map((v) => v.toMap()).toList(),
        "date": DateTime.now().toIso8601String(),
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: id,
        total: cartProvider.totalAmount,
        products: cartProvider.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> loadProducs() async {
    final List<Order> items = [];
    final response =
        await http.get(Uri.parse('$_urlBase/order/$_idUser.json?auth=$_token'));
    if (response.body == 'null') return;
    final Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {
      final products = List<CartItem>.from(
        (value['products'] as List<dynamic>).map((productMap) => CartItem(
            id: productMap['id'],
            productId: productMap['productId'],
            title: productMap['title'],
            quantity: productMap['quantity'],
            price: productMap['price'])),
      );

      items.add(Order(
        id: key,
        total: value['total'] as double,
        products: products,
        date: DateTime.parse(value['date'] as String),
      ));
    });

    _items.clear();
    _items = items.reversed.toList();

    notifyListeners();
  }
}
