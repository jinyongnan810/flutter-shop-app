import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop/models/http_exception.dart';

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
  Future<void> toggleFavorite(String token) async {
    this.isFavorite = !this.isFavorite;
    final url = Uri.parse(
        "https://flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app/products/${this.id}.json?auth=${token}");
    notifyListeners();
    try {
      final res = await http.patch(url, body: jsonEncode(this));
      final authData = jsonDecode(res.body);
      if (authData['error'] != null) {
        throw HttpException(authData['error']['message']);
      }
    } catch (error) {
      this.isFavorite = !this.isFavorite;
      notifyListeners();
      throw error;
    }
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
