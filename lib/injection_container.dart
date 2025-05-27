import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/services/token_storage.dart';
import 'core/services/dio_client.dart';

import 'data/datasources/remote/course_remote_ds.dart';
import 'data/repositories/course_repository.dart';

import 'domain/repositories/course_repo.dart';

import 'presentation/viewmodels/course_viewmodel.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // External
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  
  // Core
  getIt.registerSingleton<TokenStorage>(TokenStorage());
  getIt.registerSingleton<DioClient>(DioClient(getIt()));
  
  // Data sources
  getIt.registerSingleton<CourseRemoteDataSource>(
    CourseRemoteDataSource(getIt()),
  );
  
  // Repositories
  getIt.registerSingleton<CourseRepository>(
    CourseRepositoryImpl(getIt()),
  );
  
  // ViewModels будут регистрироваться здесь
  getIt.registerSingleton<CourseViewModel>(CourseViewModel(getIt()));
  // getIt.registerSingleton<AuthViewModel>(AuthViewModel());
}