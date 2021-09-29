import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:shop/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryTime;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    print('isAuth:${token != null}');
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
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'token': this._token,
        'userId': this._userId,
        'expiryTime': this._expiryTime!.toIso8601String()
      });
      prefs.setString('auth', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('auth')) {
      return false;
    }
    final auth = prefs.getString('auth');
    final userData = jsonDecode(auth!);
    final expiryTime = DateTime.parse(userData['expiryTime']);
    if (expiryTime.isBefore(DateTime.now())) {
      return false;
    }
    this._token = userData['token'];
    this._userId = userData['userId'];
    this._expiryTime = expiryTime;
    print('auth login success');
    autoLogout();
    notifyListeners();
    return true;
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

  Future<void> logout() async {
    print('logout');
    this._token = null;
    this._userId = null;
    this._expiryTime = null;
    if (this._authTimer != null) {
      this._authTimer!.cancel();
      this._authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void autoLogout() {
    if (this._authTimer != null) {
      this._authTimer!.cancel();
    }
    final seconds = this._expiryTime!.difference(DateTime.now()).inSeconds;
    this._authTimer = Timer(Duration(seconds: seconds), logout);
  }
}
