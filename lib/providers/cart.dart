import 'dart:math';

import 'package:flutter/foundation.dart';

class CartItemInfo {
  String id;
  String title;
  double price;
  int quantity;
  CartItemInfo(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItemInfo> _items = {};

  Map<String, CartItemInfo> get items {
    return {..._items};
  }

  CartItemInfo? get(id) {
    if (_items.containsKey(id)) {
      return _items[id]!;
    }
    return null;
  }

  int get productCount {
    return _items.length;
  }

  int get itemCount {
    return _items.keys.fold(
        0, (previousValue, key) => previousValue += _items[key]!.quantity);
  }

  List<String> get keys {
    return _items.keys.toList();
  }

  double get total {
    return _items.keys.fold(
        0,
        (previousValue, key) =>
            previousValue += _items[key]!.price * _items[key]!.quantity);
  }

  void add(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity += 1;
    } else {
      _items[id] = CartItemInfo(
          id: Random().nextInt(1000000).toString(),
          title: title,
          price: price,
          quantity: 1);
    }
    notifyListeners();
  }

  void remove(String id) {
    _items.remove(id);
    notifyListeners();
  }
}
