import 'package:go_router/go_router.dart';
import 'package:poliglotim/data/repositories/auth/auth_repository.dart';
import 'package:poliglotim/ui/auth/view/login_screen.dart';
import 'package:poliglotim/ui/auth/view_models/login_viewmodel.dart';
import 'package:poliglotim/ui/course/view/course_screen.dart';
import 'package:poliglotim/ui/course/view_models/course_viewmodel.dart';
import 'package:poliglotim/ui/courses/view/courses_screen.dart';
import 'package:poliglotim/ui/courses/view_models/courses_viewmodel.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  // redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        final viewModel = LoginViewModel(
          authRepository: context.read(),
        );
        return LoginScreen(viewModel: viewModel);
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = CoursesViewModel(
          courseRepository:  context.read(),
        );
        return CoursesScreen(viewModel: viewModel);
      },
    ),
   GoRoute(
  path: Routes.course,
  builder: (context, state) {
    final courseId = state.pathParameters['id']!; // Используйте pathParameters вместо params
    final viewModel = CourseViewModel(
      courseRepository: context.read(),
    );
    
    return CourseScreen(courseId: courseId, viewModel: viewModel);
  },
),
  ],
);

// From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
// Future<String?> _redirect(BuildContext context, GoRouterState state) async {
//   // if the user is not logged in, they need to login
//   final loggedIn = await context.read<AuthRepository>().isAuthenticated;
//   final loggingIn = state.matchedLocation == Routes.login;
//   if (!loggedIn) {
//     return Routes.login;
//   }

//   // if the user is logged in but still on the login page, send them to
//   // the home page
//   if (loggingIn) {
//     return Routes.home;
//   }

//   // no need to redirect at all
//   return null;
// }