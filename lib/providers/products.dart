import 'package:flutter/material.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;
  List<Product> get items {
    return [..._items];
  }

  // demo of making changes and notify all listeners
  void addProdcut(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
