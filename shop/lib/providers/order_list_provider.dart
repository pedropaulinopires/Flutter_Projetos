import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/Order.dart';
import 'package:shop/providers/cart_provider.dart';

class OrderListProvider with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itensCount => _items.length;

  void addOrder(CartProvider cartProvider) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cartProvider.totalAmount,
        products: cartProvider.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
