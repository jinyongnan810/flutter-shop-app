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
        dateTime = DateTime.parse(json['dateTime']),
        products = (json['products'] as List<dynamic>)
            .map((e) => CartItemInfo.fromJson(e))
            .toList(),
        id = '';

  Map<String, dynamic> toJson() => {
        'amount': this.amount,
        'products': this.products,
        'dateTime': this.dateTime.toIso8601String(),
      };
}

class Orders with ChangeNotifier {
  List<OrderItemInfo> _orders = [];
  String _authToken;
  String _userId;

  Orders(this._authToken, this._userId, this._orders);

  List<OrderItemInfo> get orders {
    return [..._orders];
  }

  OrderItemInfo get(int index) {
    return _orders[index];
  }

  Future<void> load() async {
    final url = Uri.parse(
        "https://flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app/orders/${this._userId}.json?auth=${this._authToken}");
    final ordersRes = await http.get(url);
    if (jsonDecode(ordersRes.body) == null) {
      return;
    }
    final Map<String, dynamic> res = jsonDecode(ordersRes.body);
    final orders = res.entries.map((entry) {
      final order = OrderItemInfo.fromJson(entry.value);
      order.id = entry.key;
      return order;
    }).toList();
    this._orders = orders;
    notifyListeners();
  }

  Future<void> add(List<CartItemInfo> cartProducts, double total) async {
    final OrderItemInfo newOrder = OrderItemInfo(
        amount: total, products: cartProducts, dateTime: DateTime.now());
    final url = Uri.parse(
        "https://flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app/orders/${this._userId}.json?auth=${this._authToken}");
    final newProduct = await http.post(url, body: jsonEncode(newOrder));
    final res = jsonDecode(newProduct.body);
    newOrder.id = res['name'];
    _orders.insert(0, newOrder);
    notifyListeners();
  }
}
