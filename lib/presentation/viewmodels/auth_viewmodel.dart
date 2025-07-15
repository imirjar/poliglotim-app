import 'package:flutter/foundation.dart';
import 'package:poliglotim/data/local/token_storage.dart';


class AuthViewModel with ChangeNotifier {
  final LocalDataSource _localStorage;
  
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;

  // AuthViewModel({required AuthLocalDataSource localDataSource})
  //     : _localDataSource = localDataSource;
  AuthViewModel(this._localStorage);

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final token = await _localStorage.getCachedToken();
      _isAuthenticated = token != null;
      await Future.delayed(const Duration(milliseconds: 4500));
    } catch (e) {
      _error = e.toString();
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Здесь должна быть логика входа через API
      // Предположим, что мы получили токен
      const mockToken = 'your.jwt.token';
      
      await _localStorage.cacheToken(mockToken);
      _isAuthenticated = true;
    } catch (e) {
      _error = e.toString();
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