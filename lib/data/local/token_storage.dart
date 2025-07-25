import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _authTokenKey = 'auth_token';

  Future<void> cacheToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_authTokenKey, token);
    } catch (e) {
      print("STORAGE ERROR: $e");
    }
  }

  Future<String?> getCachedToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_authTokenKey);
    } catch (e) {
      print("STORAGE ERROR: $e");
      return null;
    }
  }

  Future<void> deleteCachedToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_authTokenKey);
    } catch (e) {
      print("STORAGE ERROR: $e");
    }
  }
}