// import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/services/token_storage.dart';
// import 'core/services/dio_client.dart';

import 'presentation/viewmodels/courses_viewmodel.dart';
import 'presentation/viewmodels/course_viewmodel.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';

import 'package:poliglotim/data/api/auth_api.dart';
import 'package:poliglotim/data/api/study_api.dart';
import 'package:poliglotim/data/local/token_storage.dart';

import 'package:poliglotim/domain/repositories/course_repo.dart';


final getIt = GetIt.instance;

Future<void> init() async {

  // Регистрируем API сервисы
  getIt.registerSingleton<AuthApi>(AuthApi());
  getIt.registerSingleton<StudyApi>(StudyApi());

  // External
  // getIt.registerSingleton<Dio>(Dio());
  // getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
    // getIt.registerSingleton<StudyApi>(StudyApi());
    
  // Регистрируем сервисы
  getIt.registerSingleton<TokenStorage>(TokenStorage());
  // getIt.registerSingleton<DioClient>(DioClient(getIt()));
  getIt.registerSingleton<CourseRepository>(CourseRepository(getIt()));
  getIt.registerSingleton<LocalDataSource>(LocalDataSource(getIt()));
  
  // ViewModels будут регистрироваться здесь
  getIt.registerSingleton<CourseViewModel>(CourseViewModel(getIt()));
  getIt.registerSingleton<CoursesViewModel>(CoursesViewModel(getIt()));
  getIt.registerSingleton<AuthViewModel>(AuthViewModel(getIt()));


}

  