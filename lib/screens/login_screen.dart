// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import '../api/auth_api.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  double elevation = 0;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final user = await AuthApi().login(
        _usernameController.text,
        _passwordController.text,
      );
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Неверные данные')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0E5EC), Color(0xFFF0F0F3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color:const Color.fromARGB(255, 228, 232, 237),
                  gradient: const LinearGradient(colors:[Color.fromARGB(255, 228, 232, 237), Color.fromARGB(255, 228, 232, 237)]),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6, -6),
                      blurRadius: 16.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(6, 6),
                      blurRadius: 16.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Вход",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Имя пользователя',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFE0E5EC),
                        ),
                        validator: (value) => value!.isEmpty ? 'Введите имя пользователя' : null,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Пароль',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFE0E5EC),
                        ),
                        obscureText: true,
                        validator: (value) => value!.isEmpty ? 'Введите пароль' : null,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _login,
                        onHover: (value)=> {
                          elevation = 2
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 228, 232, 237),
                          overlayColor: Color.fromARGB(255, 255, 255, 255),
                          shadowColor: Color(0xFFE0E5EC),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: elevation,
                        ),
                        child: Text(
                          "Войти",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}