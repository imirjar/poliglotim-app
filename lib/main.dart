import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'core/services/token_storage.dart';
import 'data/datasources/local/auth_local_ds.dart';
import 'injection_container.dart' as di;
import 'presentation/viewmodels/auth_viewmodel.dart';
import 'presentation/views/auth/login_screen.dart';
import 'presentation/views/courses/course_list_screen.dart';
import 'presentation/views/splash_screen.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // ← Важно!
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(
            localDataSource: AuthLocalDataSource(di.getIt<TokenStorage>()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Course App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
        routes: {
          '/courses': (context) => const CourseListScreen(),
          '/login': (context) => const LoginScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    
    return authViewModel.isLoading
        ? const SplashScreen()
        : authViewModel.isAuthenticated
            ? const CourseListScreen()
            : const LoginScreen();
  }
}