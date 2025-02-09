import 'package:poliglotim/models/user.dart';

// lib/api/auth_api.dart
class AuthApi {
  Future<User?> login(String username, String password) async {
    // Mock авторизация
    await Future.delayed(Duration(seconds: 2)); // Имитация задержки сети
    if (username == "user" && password == "password") {
      return User(id: "1", username: username, email: "user@example.com");
    }
    return null;
  }
}