import 'package:poliglotim/data/api/auth_api.dart';

class AuthRepository {
  final AuthApi apiClient;

  AuthRepository(this.apiClient);

  Future<String> login(String username, String password) async{
    try {
      return await apiClient.login(username, password);
    } catch (e) {
      throw Exception("Ошибка декодирования JSON: $e");
    }
  }
}