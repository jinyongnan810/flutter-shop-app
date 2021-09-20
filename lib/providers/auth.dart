import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryTime;
  String? _userId;

  Future<void> authenticate(String email, String password, Uri uri) async {
    final signupResponse = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    print(signupResponse.body);
    final authData = jsonDecode(signupResponse.body);
    this._token = authData['idToken'];
    this._userId = authData['localId'];
    this._expiryTime = DateTime.now().add(Duration(hours: 1));
  }

  Future<void> signup(String email, String password) async {
    final uri = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${dotenv.env['FIREBASE_API_KEY']}");
    try {
      authenticate(email, password, uri);
    } catch (error) {
      print(error);
    }
  }

  Future<void> signin(String email, String password) async {
    final uri = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${dotenv.env['FIREBASE_API_KEY']}");
    try {
      authenticate(email, password, uri);
    } catch (error) {
      print(error);
    }
  }
}