import 'package:poliglotim/domain/models/user.dart';

// lib/api/auth_api.dart
class AuthApi {
  Future<User?> login(String username, String password) async {
    // Mock авторизация
    await Future.delayed(const Duration(seconds: 2)); // Имитация задержки сети
    if (username == "user" && password == "password") {
      return User(id: "1", username: username, email: "user@example.com");
    }
    return null;
  }
}

// // lib/api/auth_api.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/user.dart';

// class AuthApi {
//   static const String _baseUrl = "http://localhost:7070"; // Базовый URL API
//   static const String _loginEndpoint = "/login"; // Эндпоинт для авторизации

//   Future<User?> login(String username, String password) async {
//     try {
//       // Отправляем POST-запрос на сервер
//       final response = await http.post(
//         Uri.parse("$_baseUrl$_loginEndpoint"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "login": username,
//           "password": password,
//         }),
//       );

//       // Проверяем статус ответа
//       if (response.statusCode == 200) {
//         // Парсим ответ
//         final responseData = jsonDecode(response.body);
//         final token = responseData["token"]; // Получаем JWT-токен
//         String userString = utf8.decode(base64.decode(token));
//         print( userString);
//         final user = User(
//           id: """responseData["user"]["id"].toString()""",
//           username: """responseData["user"]["username"]""",
//           email: """responseData["user"]["email"]""",
//         );

//         // Сохраняем токен (например, в SharedPreferences)
//         await _saveToken(token);

//         return user;
//       } else {
//         // Обработка ошибок
//         print("Ошибка авторизации: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       // Обработка исключений
//       print("Ошибка: $e");
//       return null;
//     }
//   }

//   // Метод для сохранения токена (например, в SharedPreferences)
//   Future<void> _saveToken(String token) async {
//     // Здесь можно использовать SharedPreferences для сохранения токена
//     print("Токен сохранен: $token");
//   }
// }