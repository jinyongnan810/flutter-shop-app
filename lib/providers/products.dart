import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get itemsFavorite {
    return _items.where((element) => element.isFavorite).toList();
  }

  int get itemCounts {
    return _items.length;
  }

  Future<void> loadProducts() async {
    final url = Uri.https(
        "flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app",
        '/products.json');
    final newProduct = await http.get(url);
    final Map<String, dynamic> res = jsonDecode(newProduct.body);
    final products = res.entries.map((entry) {
      final product = Product.fromJson(entry.value);
      product.id = entry.key;
      return product;
    }).toList();
    this._items = products;
    notifyListeners();
  }

  Future<void> saveProduct(Product product) async {
    final index = _items.indexWhere((element) => element.id == product.id);
    if (index == -1) {
      final url = Uri.https(
          "flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app",
          '/products.json');
      final newProduct = await http.post(url, body: jsonEncode(product));
      final res = jsonDecode(newProduct.body);
      print(res);
      product.id = res['name'];
      _items.add(product);
    } else {
      final url = Uri.https(
          "flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app",
          '/products/${product.id}.json');
      await http.patch(url, body: jsonEncode(product));
      _items.replaceRange(index, index + 1, [product]);
    }
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

  Product atIndex(int index) {
    return _items[index];
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https(
        "flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app",
        '/products/$id.json');
    final targetIndex = _items.indexWhere((element) => element.id == id);
    dynamic target = _items[targetIndex];
    _items.removeAt(targetIndex);
    http.delete(url).then((_) {
      target = null;
    }).catchError((_) {
      _items.insert(targetIndex, target);
      notifyListeners();
    });
    notifyListeners();
  }
}
