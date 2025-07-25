import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:poliglotim/presentation/viewmodels/auth_viewmodel.dart';
import 'package:poliglotim/presentation/views/ui/elements/custom_button.dart';
import 'package:poliglotim/presentation/views/ui/elements/custom_text_field.dart';
import 'package:poliglotim/injection_container.dart' as di;
import 'package:poliglotim/presentation/views/ui/neomorph_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthViewModel _viewModel;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = di.getIt<AuthViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NeumorphicContainer(
          width: 400,
          height: 450,
          padding: const EdgeInsets.all(24),
          child: _buildLoginForm()
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
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
            onPressed: () => {_viewModel.login(_usernameController.text, _usernameController.text)},
            icon: Icons.arrow_upward_outlined,
          ),
          // Container(
          //   child: Text(_viewModel.error.toString()),
          // )
        ],
      ),
    );
  }
}
