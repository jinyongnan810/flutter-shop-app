import 'dart:math';

import 'package:flutter/foundation.dart';

class CartItem {
  String id;
  String title;
  double price;
  int quantity;
  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.keys.fold(0,
        (previousValue, element) => previousValue += _items[element]!.quantity);
  }

  void add(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity += 1;
    } else {
      _items[id] = CartItem(
          id: Random().nextInt(1000000).toString(),
          title: title,
          price: price,
          quantity: 1);
    }
    notifyListeners();
  }
}
