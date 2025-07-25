import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poliglotim/core/constants/api_constants.dart';

class AuthApi {
  final httpClient = http.Client();
  // static const String _loginEndpoint = "/login";
  static const String _baseUrl = ApiConstants.authEndpoint;

  // @override
  Future<String> login(String username, String password) async {
    final response = await httpClient.post(
      Uri.parse("$_baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"login": username, "password": password}),
    );

    if (response.statusCode == 200) {
      // return jsonDecode(response.body);
      try {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        final token = responseData["access_token"] as String?;
        if (token == null) throw Exception("Токен не получен");
        return token;
      } catch (e) {
        throw Exception("Ошибка декодирования JSON: $e");
      }
    } else {
      throw Exception("Ошибка авторизации $response.statusCode");
    }
  }
}