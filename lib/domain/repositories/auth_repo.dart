// В domain/repositories/
abstract class AuthApiService {
  Future<String> login(String username, String password);
}