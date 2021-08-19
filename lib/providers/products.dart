import 'package:flutter/material.dart';
import 'product.dart';

List<Product> dummyProducts = [
  Product(
    id: 'p1',
    title: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    image:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
  Product(
    id: 'p2',
    title: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    image:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  ),
  Product(
    id: 'p3',
    title: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    image: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  ),
  Product(
    id: 'p4',
    title: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    image:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  ),
];

// difference between mixin(with) and inheritance(extends)
// the class with its inheritance class has logical relationship, like human and man
// while the class with its mixin has no such thing, and the class only uses the mixin for its utility properties
class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;
  List<Product> get items {
    return [..._items];
  }

  List<Product> get itemsFavorite {
    return _items.where((element) => element.isFavorite).toList();
  }

  // demo of making changes and notify all listeners
  void addProdcut(Product product) {
    _items.add(product);
    notifyListeners();
  }

  // // switch show favorites / show all
  // void switchShowFavorite(bool onlyFavorite) {
  //   this._showOnlyFavorites = onlyFavorite;
  //   notifyListeners();
  // }

  Product getSingleProduct(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
