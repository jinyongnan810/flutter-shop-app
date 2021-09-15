import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shop/providers/cart.dart';

class OrderItemInfo {
  String id = "";
  double amount;
  List<CartItemInfo> products;
  DateTime dateTime;
  OrderItemInfo(
      {required this.amount, required this.products, required this.dateTime});
  OrderItemInfo.fromJson(Map<String, dynamic> json)
      : amount = json['amount'],
        dateTime = json['dateTime'],
        products = json['products'],
        id = '';

  Map<String, dynamic> toJson() => {
        'amount': this.amount,
        'products': this.products,
        'dateTime': this.dateTime.toIso8601String(),
      };
}

class Orders with ChangeNotifier {
  final List<OrderItemInfo> _orders = [];
  List<OrderItemInfo> get orders {
    return [..._orders];
  }

  OrderItemInfo get(int index) {
    return _orders[index];
  }

  Future<void> add(List<CartItemInfo> cartProducts, double total) async {
    final OrderItemInfo newOrder = OrderItemInfo(
        amount: total, products: cartProducts, dateTime: DateTime.now());
    final url = Uri.https(
        "flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app",
        '/orders.json');
    print(jsonEncode(cartProducts));
    print(jsonEncode(newOrder));
    final newProduct = await http.post(url, body: jsonEncode(newOrder));
    final res = jsonDecode(newProduct.body);
    newOrder.id = res['name'];
    _orders.insert(0, newOrder);
    notifyListeners();
  }
}
