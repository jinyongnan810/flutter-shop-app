import 'dart:math';

import 'package:flutter/foundation.dart';

class CartItemInfo {
  String id;
  String productId;
  String title;
  double price;
  int quantity;
  CartItemInfo(
      {required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.quantity});
  CartItemInfo.fromJson(Map<String, dynamic> json)
      : productId = json['productId'],
        title = json['title'],
        price = json['price'],
        quantity = json['quantity'],
        id = '';

  Map<String, dynamic> toJson() => {
        'productId': this.productId,
        'title': this.title,
        'price': this.price,
        'quantity': this.quantity,
      };
}

class Cart with ChangeNotifier {
  Map<String, CartItemInfo> _items = {};

  Map<String, CartItemInfo> get items {
    return {..._items};
  }

  List<CartItemInfo> get itemsList {
    return _items.values.toList();
  }

  CartItemInfo? get(id) {
    if (_items.containsKey(id)) {
      return _items[id]!;
    }
    return null;
  }

  int productQuantity(id) {
    if (_items.containsKey(id)) {
      return _items[id]!.quantity;
    }
    return 0;
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
          productId: id,
          title: title,
          price: price,
          quantity: 1);
    }
    notifyListeners();
  }

  void undoAdd(String id) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity -= 1;
      if (_items[id]!.quantity == 0) {
        _items.remove(id);
      }
      notifyListeners();
    }
  }

  void remove(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
