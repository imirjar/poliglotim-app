import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _buttonState = _ButtonState.normal;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthViewModel auth) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _buttonState = _ButtonState.pressed);
    await auth.login(_usernameController.text, _passwordController.text);
    if (mounted) setState(() => _buttonState = _ButtonState.normal);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    return Scaffold(
      body: Container(
        decoration: _buildBackground(),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(24),
                decoration: _buildCardDecoration(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/images/poliglotim_login.svg",
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 40),
                      _buildUsernameField(),
                      const SizedBox(height: 16),
                      _buildPasswordField(),
                      const SizedBox(height: 24),
                      auth.isLoading 
                          ? const CircularProgressIndicator()
                          : _buildLoginButton(auth),
                      if (auth.error != null) _buildErrorText(auth),
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

  BoxDecoration _buildBackground() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0E5EC), Color(0xFFF0F0F3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );

  BoxDecoration _buildCardDecoration() => BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 228, 232, 237),
            Color.fromARGB(255, 228, 232, 237),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-6, -6),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(6, 6),
            blurRadius: 16,
          ),
        ],
      );

  TextFormField _buildUsernameField() => TextFormField(
        controller: _usernameController,
        decoration: _buildInputDecoration('Имя пользователя'),
        validator: (v) => v!.isEmpty ? 'Введите имя пользователя' : null,
      );

  TextFormField _buildPasswordField() => TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: _buildInputDecoration('Пароль'),
        validator: (v) => v!.isEmpty ? 'Введите пароль' : null,
      );

  InputDecoration _buildInputDecoration(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 123, 123, 123)),
        enabledBorder: _buildInputBorder(),
        focusedBorder: _buildInputBorder(),
      );

  OutlineInputBorder _buildInputBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color.fromARGB(0, 66, 65, 65), width: 2),
      );

  ElevatedButton _buildLoginButton(AuthViewModel auth) => ElevatedButton(
        onPressed: () => _submit(auth),
        onHover: (hover) => setState(() => _buttonState = 
            hover ? _ButtonState.hovered : _ButtonState.normal),
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonState.backgroundColor,
          overlayColor: Colors.white,
          padding: const EdgeInsets.all(35),
          shape: const CircleBorder(),
          elevation: _buttonState.elevation,
        ),
        child: const Icon(
          Icons.arrow_upward_outlined,
          color: Color.fromARGB(221, 166, 166, 166),
        ),
      );

  Widget _buildErrorText(AuthViewModel auth) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          auth.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
}

enum _ButtonState { normal, hovered, pressed }

extension on _ButtonState {
  Color get backgroundColor {
    switch (this) {
      case _ButtonState.pressed:
        return const Color.fromARGB(255, 171, 174, 177);
      default:
        return const Color.fromARGB(255, 228, 232, 237);
    }
  }

  double get elevation => this == _ButtonState.hovered ? 2 : 0;
}