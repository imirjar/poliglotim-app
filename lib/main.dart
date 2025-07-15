import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:poliglotim/presentation/viewmodels/auth_viewmodel.dart';
import 'package:poliglotim/presentation/views/auth/login_screen.dart';
import 'package:poliglotim/presentation/views/study/courses/courses_screen.dart';
import 'package:poliglotim/presentation/views/study/course/course_screen.dart';
import 'package:poliglotim/presentation/views/splash_screen.dart';

import 'package:poliglotim/core/theme/app_theme.dart';
import 'package:poliglotim/core/widgets/gradient_background.dart';

import 'package:poliglotim/injection_container.dart' as di;
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // ← Важно!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Course App',
        theme: AppTheme.lightTheme,
        // home: const AuthWrapper(),
        // home: LoginScreen(),
        home: const GradientBackground(
          child: CoursesScreen(),
        ),
        routes: {
          '/courses': (context) => const CoursesScreen(),
          '/login': (context) => const LoginScreen(),
          '/course': (context) {
            final courseId = ModalRoute.of(context)!.settings.arguments as String;
            return CourseScreen(courseId: courseId);
          },
        },
        // debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    
    return authViewModel.isLoading
        ? const SplashScreen()
        : authViewModel.isAuthenticated
            ? const CoursesScreen()
            : const LoginScreen();
  }
}