import 'package:flutter/material.dart';
import '../models/product.dart';

// difference between mixin(with) and inheritance(extends)
// the class with its inheritance class has logical relationship, like human and man
// while the class with its mixin has no such thing, and the class only uses the mixin for its utility properties
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

  Product getSingleProduct(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
