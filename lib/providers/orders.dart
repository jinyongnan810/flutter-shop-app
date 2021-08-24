import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/cart.dart';

class OrderItemInfo {
  final String id;
  final double amount;
  final List<CartItemInfo> products;
  final DateTime dateTime;
  OrderItemInfo(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final List<OrderItemInfo> _orders = [];
  List<OrderItemInfo> get orders {
    return [..._orders];
  }

  OrderItemInfo get(int index) {
    return _orders[index];
  }

  void add(List<CartItemInfo> cartProducts, double total) {
    final OrderItemInfo newOrder = OrderItemInfo(
        id: Random().nextInt(100000).toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now());
    _orders.insert(0, newOrder);
    notifyListeners();
  }
}
