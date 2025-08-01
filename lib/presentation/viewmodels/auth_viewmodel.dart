import 'package:flutter/foundation.dart';
import 'package:poliglotim/data/local/token_storage.dart';
import 'package:poliglotim/domain/repositories/auth_repository.dart';


class AuthViewModel with ChangeNotifier {
  final AuthRepository _repository;
  final TokenStorage _localStorage;
  
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? myToken;
  String? _error;


  AuthViewModel(this._repository, this._localStorage);

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Здесь должна быть логика входа через API
      myToken = await _repository.login(email, password);
      // Предположим, что мы получили токен
      // const mockToken = 'your.jwt.token';
      // print(" TOOOOKEEEEN $myToken");
      
      await _localStorage.cacheToken(myToken!);
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      print(" ERRRRRRORRRRR$e");
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _localStorage.deleteCachedToken();
      _isAuthenticated = false;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}