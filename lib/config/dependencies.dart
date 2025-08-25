import 'package:poliglotim/data/repositories/auth/auth_repository_remote.dart';
import 'package:poliglotim/data/repositories/courses/course_repository_local.dart';
import 'package:poliglotim/data/repositories/courses/course_repository_remote.dart';
import 'package:poliglotim/data/services/api/auth_api.dart';
import 'package:poliglotim/data/services/api/course_client.dart';
import 'package:poliglotim/data/services/api/study_api.dart';
import 'package:poliglotim/data/services/local/token_storage.dart';
import 'package:poliglotim/data/repositories/auth/auth_repository.dart';
import 'package:poliglotim/data/repositories/courses/course_repository.dart';
import 'package:poliglotim/data/services/local/courses_mock.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


// This dependency list uses repositories that connect to a remote server.
List<SingleChildWidget> get providersRemote {
  return [
    // Auth
    Provider(create: (context) => AuthApi()),
    Provider(create: (context) => StudyApi()),
    Provider(create: (context) => SharedPreferencesService()),
    ChangeNotifierProvider(
      create: (context) =>
        AuthRepositoryRemote(
          authApiClient: context.read(),
          sharedPreferencesService: context.read(),
        )
        as AuthRepository,
    ),

     // Course
    Provider(create: (context) => CourseClient()),
    Provider(
      create: (context) =>
        CourseRepositoryRemote(
          apiClient: context.read(),
        )
        as CourseRepository,
    ),
    
  ];
}

List<SingleChildWidget> get providersLocal {
  return [
    // Auth
    Provider(create: (context) => AuthApi()),
    Provider(create: (context) => StudyApi()),
    Provider(create: (context) => SharedPreferencesService()),
    // NOT LOCAL!
    ChangeNotifierProvider(
      create: (context) =>
        AuthRepositoryRemote(
          authApiClient: context.read(),
          sharedPreferencesService: context.read(),
        )
        as AuthRepository,
    ),

    // Course
    Provider(create: (context) => LocalDataService()),
    Provider(
      create: (context) =>
        CourseRepositoryLocal(
          localDataService: context.read(),
        )
        as CourseRepository,
    ),
    
    
  ];
}
