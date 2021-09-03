import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String image;
  bool isFavorite;
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
      this.isFavorite = false});
  toggleFavorite() {
    this.isFavorite = !this.isFavorite;
    notifyListeners();
  }
}
