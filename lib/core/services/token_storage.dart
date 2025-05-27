// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
 
  final _prefs = SharedPreferences.getInstance();

  Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString('auth_token');
  }

  Future<void> saveToken(String token) async {
    final prefs = await _prefs;
    await prefs.setString('auth_token', token);
  }

  Future<void> deleteToken() async {
    final prefs = await _prefs;
    await prefs.setString('auth_token', "");
  }
// }
//   Future<void> deleteToken() async {
//     await _storage.delete(key: 'auth_token');
//   }
}