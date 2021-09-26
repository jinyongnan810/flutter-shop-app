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
  Future<void> toggleFavorite(String token, String userId) async {
    this.isFavorite = !this.isFavorite;
    final url = Uri.parse(
        "https://flutter-learning-36b57-default-rtdb.asia-southeast1.firebasedatabase.app/favorites/${userId}/${this.id}.json?auth=${token}");
    notifyListeners();
    try {
      final res = await http.put(url, body: jsonEncode(this.isFavorite));
      final favoriteRes = jsonDecode(res.body);
      if ((favoriteRes is! bool) && favoriteRes['error'] != null) {
        throw HttpException(favoriteRes['error']['message']);
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
        isFavorite = false,
        id = '';

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
        'price': this.price,
        'image': this.image,
      };
}
