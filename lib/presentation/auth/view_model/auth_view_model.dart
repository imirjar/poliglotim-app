import 'package:flutter/material.dart';
import '../../../data/services/auth_api.dart';

class LoginViewModel {
  LoginViewModel({
    required AuthApi authApi,
  }) : _authApi = authApi;

  final AuthApi _authApi;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPressed = false;
  double _buttonElevation = 0;

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  bool get isPressed => _isPressed;
  double get buttonElevation => _buttonElevation;

  Future<void> login(BuildContext context) async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите имя пользователя и пароль')),
      );
      return;
    }

    final user = await _authApi.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Неверные данные')),
      );
    }
  }

  void toggleButtonState() {
    _isPressed = !_isPressed;
  }

  void setButtonElevation(double elevation) {
    _buttonElevation = elevation;
  }

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
  }
}