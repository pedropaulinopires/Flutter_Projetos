import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
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

    print(response.body);
  }

  Future<void> singup(String email, String password) async {
    _authenticate(email, password, 'signUp');
  }

  Future<void> singin(String email, String password) async {
    _authenticate(email, password, 'signInWithPassword');
  }
}
