import 'package:logging/logging.dart';
import 'package:poliglotim/data/services/local/mocks/user_mock.dart';
import 'package:poliglotim/data/services/local/storages/token_storage.dart';
import 'package:poliglotim/domain/models/user.dart';

import '../../../utils/result.dart';
import 'user_repository.dart';

class UserRepositoryLocal extends UserRepository {
  UserRepositoryLocal({
    required UserAPIMock userApiClient,
    required SharedPreferencesService sharedPreferencesService,
  }) : _authApiClient = userApiClient,
       _sharedPreferencesService = sharedPreferencesService;

  final UserAPIMock _authApiClient;
  final SharedPreferencesService _sharedPreferencesService;

  bool? _isAuthenticated;
  String? _authToken;
  final _log = Logger('AuthRepositoryRemote');

  /// Fetch token from shared preferences
  Future<void> _fetch() async {
    final result = await _sharedPreferencesService.fetchToken();
    switch (result) {
      case Ok<String?>():
        _authToken = result.value;
        _isAuthenticated = result.value != null;
      case Error<String?>():
        _log.severe(
          'Failed to fech Token from SharedPreferences',
          result.error,
        );
    }
  }

  @override
  Future<bool> get isAuthenticated async {
    // Status is cached
    if (_isAuthenticated != null) {
      return _isAuthenticated!;
    }
    // No status cached, fetch from storage
    await _fetch();
    return _isAuthenticated ?? false;
  }

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = _authApiClient.login(
       email:email, 
       password:password
      );
      switch (result) {
        case Ok():
          _log.info('User logged int');
          // Set auth status
          _isAuthenticated = true;
          _authToken = result;
          // Store in Shared preferences
          return await _sharedPreferencesService.saveToken(result);
        default:
          _log.warning('Error logging in');
          // return Result.error(error);
          throw(Error);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> logout() async {
    _log.info('User logged out');
    try {
      // Clear stored auth token
      final result = await _sharedPreferencesService.saveToken(null);
      if (result is Error<void>) {
        _log.severe('Failed to clear stored auth token');
      }

      // Clear token in ApiClient
      _authToken = null;

      // Clear authenticated status
      _isAuthenticated = false;
      return result;
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<User>> getUserData() async {
    try {
      final User result = _authApiClient.getUserData();
      return Result.ok(result);
    } finally {
      notifyListeners();
    }
  }

  // String? _authHeaderProvider() =>
  //     _authToken != null ? 'Bearer $_authToken' : null;

  
}