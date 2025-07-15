import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poliglotim/core/constants/api_constants.dart';
import 'package:poliglotim/core/errors/auth_exception.dart';

import 'package:poliglotim/domain/repositories/auth_repo.dart';

class AuthApi implements AuthApiService {
  static const String _loginEndpoint = "/login";
  static const String _baseUrl = ApiConstants.authEndpoint;

  @override
  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$_baseUrl$_loginEndpoint"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"login": username, "password": password}),
    );

    if (response.statusCode == 200) {
      try {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        final token = responseData["access_token"] as String?;
        if (token == null) throw AuthException("Токен не получен");
        return token;
      } catch (e) {
        throw AuthException("Ошибка декодирования JSON: $e");
      }
    } else {
      throw AuthException("Ошибка авторизации", response.statusCode);
    }
  }
}