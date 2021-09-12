import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  toggleFavorite() async {
    this.isFavorite = !this.isFavorite;
    final url = Uri.https(
        "flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app",
        '/products/${this.id}.json');
    await http.patch(url, body: jsonEncode(this));
    notifyListeners();
  }

  Product.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        price = json['price'],
        image = json['image'],
        isFavorite = json['isFavorite'],
        id = '';

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
        'price': this.price,
        'image': this.image,
        'isFavorite': this.isFavorite
      };
}
