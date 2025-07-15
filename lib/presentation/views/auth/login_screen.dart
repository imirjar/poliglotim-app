import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poliglotim/core/widgets/custom_button.dart';
import 'package:poliglotim/core/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Фон теперь берется из темы автоматически
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-6, -6),
                    blurRadius: 16,
                  ),
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    offset: const Offset(6, 6),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: const LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    // Логика авторизации
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
          CustomTextField(
            label: 'Имя пользователя',
            controller: _usernameController,
            validator: (v) => v!.isEmpty ? 'Введите имя пользователя' : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Пароль',
            obscureText: true,
            controller: _passwordController,
            validator: (v) => v!.isEmpty ? 'Введите пароль' : null,
          ),
          const SizedBox(height: 24),
          CustomCircleButton(
            onPressed: _submit,
            icon: Icons.arrow_upward_outlined,
          ),
        ],
      ),
    );
  }
}