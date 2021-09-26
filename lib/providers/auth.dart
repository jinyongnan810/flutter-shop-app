import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryTime;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (this._token != null &&
        this._expiryTime != null &&
        this._expiryTime!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> authenticate(String email, String password, Uri uri) async {
    try {
      final signupResponse = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      // print(signupResponse.body);
      final authData = jsonDecode(signupResponse.body);
      if (authData['error'] != null) {
        throw HttpException(authData['error']['message']);
      }
      this._token = authData['idToken'];
      this._userId = authData['localId'];
      int? expiresIn = int.tryParse(authData['expiresIn']);
      this._expiryTime =
          DateTime.now().add(Duration(seconds: expiresIn ?? 3600));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    final uri = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${dotenv.env['FIREBASE_API_KEY']}");
    await authenticate(email, password, uri);
  }

  Future<void> signin(String email, String password) async {
    final uri = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${dotenv.env['FIREBASE_API_KEY']}");
    await authenticate(email, password, uri);
  }
}
