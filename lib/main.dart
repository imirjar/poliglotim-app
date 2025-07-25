import 'package:flutter/material.dart';
import 'package:poliglotim/presentation/views/auth/login_screen.dart';
import 'package:poliglotim/presentation/views/study/courses/courses_screen.dart';
import 'package:poliglotim/presentation/views/study/course/course_screen.dart';
import 'package:poliglotim/core/theme/app_theme.dart';
import 'package:poliglotim/data/local/token_storage.dart';
import 'package:poliglotim/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course App',
      theme: AppTheme.lightTheme,
      home: const AuthChecker(),
      routes: {
        '/courses': (context) => const ProtectedRoute(child: CoursesScreen()),
        '/login': (context) => const LoginScreen(),
        '/course': (context) => ProtectedRoute(
              child: CourseScreen(
                courseId: ModalRoute.of(context)!.settings.arguments as String,
              ),
            ),
      },
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: di.getIt<TokenStorage>().getCachedToken(),
      builder: (context, snapshot) {
        // Показываем загрузку пока проверяем токен
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Если токен есть - показываем курсы, иначе - логин
        return snapshot.hasData 
            ? const CoursesScreen() 
            : const LoginScreen();
      },
    );
  }
}

class ProtectedRoute extends StatelessWidget {
  final Widget child;

  const ProtectedRoute({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: di.getIt<TokenStorage>().getCachedToken(),
      builder: (context, snapshot) {
        // Если токен проверяется - показываем загрузку
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Если токена нет - перенаправляем на логин
        if (!snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
          return const SizedBox.shrink();
        }

        // Если токен есть - показываем запрошенный экран
        return child;
      },
    );
  }
}