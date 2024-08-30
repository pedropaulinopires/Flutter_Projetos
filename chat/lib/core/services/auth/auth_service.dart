import 'dart:io';

import 'package:chat/components/chat_user.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';

abstract class AuthService {
  ChatUser? get getCurrentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );
  Future<void> login(
    String email,
    String password,
  );
  Future<void> logout();

  factory AuthService(){
    return AuthMockService();
  }
}
