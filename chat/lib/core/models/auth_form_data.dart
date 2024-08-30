import 'dart:io';

enum AuthMode { signup, login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.login;

  bool get isLogin => _mode == AuthMode.login;

  bool get isSignup => _mode == AuthMode.signup;

  void toggleMode() =>
      _mode = _mode == AuthMode.login ? AuthMode.signup : AuthMode.login;
}
