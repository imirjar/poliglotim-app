import 'package:logging/logging.dart';


import 'package:poliglotim/data/repositories/auth/auth_repository.dart';
import '../../../../utils/command.dart';
import '../../../../utils/result.dart';


class LoginViewModel {
  // LoginViewModel(this._repository, this._localStorage);

  LoginViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    login = Command1<void, (String email, String password)>(_login);
  }
  final AuthRepository _authRepository;
  final _log = Logger('LoginViewModel');

  late Command1 login;

  Future<Result<void>> _login((String, String) credentials) async {
    final (email, password) = credentials;
    final result = await _authRepository.login(
      email: email,
      password: password,
    );
    if (result is Error<void>) {
      _log.warning('Login failed! ${result.error}');
    }
    return result;
  }

  // final AuthRepository _repository;
  // final TokenStorage _localStorage;
  
  // bool _isAuthenticated = false;
  // bool _isLoading = false;
  // String? myToken;
  // String? _error;


  

  // bool get isAuthenticated => _isAuthenticated;
  // bool get isLoading => _isLoading;
  // String? get error => _error;

  // Future<void> login(String email, String password) async {
  //   _isLoading = true;
  //   notifyListeners();
    
  //   try {
  //     // Здесь должна быть логика входа через API
  //     myToken = await _repository.login(email, password);
  //     // Предположим, что мы получили токен
  //     // const mockToken = 'your.jwt.token';
  //     // print(" TOOOOKEEEEN $myToken");
      
  //     await _localStorage.cacheToken(myToken!);
  //     _isAuthenticated = true;
  //     notifyListeners();
  //   } catch (e) {
  //     _error = e.toString();
  //     _isAuthenticated = false;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> logout() async {
  //   _isLoading = true;
  //   notifyListeners();
    
  //   try {
  //     await _localStorage.deleteCachedToken();
  //     _isAuthenticated = false;
  //   } catch (e) {
  //     _error = e.toString();
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}