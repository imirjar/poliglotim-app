import 'package:get_it/get_it.dart';

import 'presentation/viewmodels/courses_viewmodel.dart';
import 'presentation/viewmodels/course_viewmodel.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';

import 'package:poliglotim/data/api/auth_api.dart';
import 'package:poliglotim/data/api/study_api.dart';
import 'package:poliglotim/data/local/token_storage.dart';

import 'package:poliglotim/domain/repositories/course_repository.dart';
import 'package:poliglotim/domain/repositories/auth_repository.dart';


final getIt = GetIt.instance;

Future<void> init() async {

  // Регистрируем API сервисы
  getIt.registerSingleton<AuthApi>(AuthApi());
  getIt.registerSingleton<StudyApi>(StudyApi());

  // Services
  // Local
  getIt.registerSingleton<TokenStorage>(TokenStorage());
  // API
  getIt.registerSingleton<CourseRepository>(CourseRepository(getIt()));
  getIt.registerSingleton<AuthRepository>(AuthRepository(getIt()));
  
  // ViewModels будут регистрироваться здесь
  getIt.registerSingleton<CourseViewModel>(CourseViewModel(getIt()));
  getIt.registerSingleton<CoursesViewModel>(CoursesViewModel(getIt()));
  getIt.registerSingleton<AuthViewModel>(AuthViewModel(getIt(),getIt()));


}

  