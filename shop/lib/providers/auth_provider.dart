import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';
import 'package:shop/exceptions/auth_exceptions.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _dateExpires;
  Timer? _timerLogout;

  bool get isAuth {
    final isValid = _dateExpires?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> _authenticate(
      String email, String password, String urlMiddle) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlMiddle?key=AIzaSyBB1XMePie9PwpGg0Pju0LDd-fP8fIT9DU';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));

    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthExceptions(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];
      _dateExpires =
          DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'])));

      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'userId': _userId,
        'dateExpires': _dateExpires!.toIso8601String(),
      });

      _autoLogout();
    }
    notifyListeners();
  }

  Future<void> singup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> singin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');

    if (userData.isEmpty) return;

    final dateExpires = DateTime.parse(userData['dateExpires']);
    if (dateExpires.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _dateExpires = dateExpires;

    _autoLogout();
    notifyListeners();
  }

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _dateExpires = null;
    _clearTimeLogout();
    Store.remove('userData').then((_) => notifyListeners());
  }

  void _clearTimeLogout() {
    _timerLogout?.cancel();
    _timerLogout = null;
  }

  void _autoLogout() {
    final seconds = _dateExpires?.difference(DateTime.now()).inSeconds;
    _timerLogout = Timer(Duration(seconds: seconds ?? 0), logout);
  }
}
