import 'package:poliglotim/core/services/token_storage.dart';


class LocalDataSource {
  final TokenStorage _tokenStorage;

  LocalDataSource(this._tokenStorage);

  Future<void> cacheToken(String token) async {
    await _tokenStorage.saveToken(token);
  }

  Future<String?> getCachedToken() async {
    return await _tokenStorage.getToken();
  }

  Future<void> deleteCachedToken() async {
    await _tokenStorage.deleteToken();
  }
}