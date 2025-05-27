import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';
import '../services/token_storage.dart';

class DioClient {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  DioClient(this._tokenStorage)
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          receiveTimeout: ApiConstants.receiveTimeout,
          connectTimeout: ApiConstants.connectTimeout,
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _tokenStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Токен устарел, можно попробовать обновить
        }
        return handler.next(error);
      },
    ));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }
  }

  Dio get instance => _dio;
}