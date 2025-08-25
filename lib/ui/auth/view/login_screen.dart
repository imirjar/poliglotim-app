import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:poliglotim/ui/auth/view_models/login_viewmodel.dart';
import 'package:poliglotim/ui/core/ui/elements/buttons/circle_button.dart';
import 'package:poliglotim/ui/core/ui/elements/inputs/simple_input_field.dart';
// import 'package:poliglotim/ui/core/ui/style/neomorph_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // widget.viewModel.login.addListener(listener)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: const[
              BoxShadow(
                color: Colors.white30,
                offset: Offset(-4, -4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: Colors.black38,
                offset: Offset(4, 4),
                blurRadius: 12,
              ),
            ]
          ),
          width: 400,
          height: 450,
          padding: const EdgeInsets.all(24),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: ()=>context.go("/"),
                  child: SvgPicture.asset(
                      "assets/images/poliglotim_white.svg",
                      height: 100,
                      width: 100,
                    ),
                ),
                const SizedBox(height: 40),
                SimpleInputField(
                  label: 'Имя пользователя',
                  controller: _usernameController,
                  validator: (v) => v!.isEmpty ? 'Введите имя пользователя' : null,
                ),
                const SizedBox(height: 16),
                SimpleInputField(
                  label: 'Пароль',
                  obscureText: true,
                  controller: _passwordController,
                  validator: (v) => v!.isEmpty ? 'Введите пароль' : null,
                ),
                const SizedBox(height: 24),
                CircleButton(
                  onPressed: () => { widget.viewModel.login.execute((_usernameController.value.text, _usernameController.value.text))},
                  icon: Icons.arrow_upward_outlined,
                ),
                // Container(
                //   child: Text(_viewModel.error.toString()),
                // )
              ],
            ),
          )
        ),
      ),
    );
  }

  // Widget _buildLoginForm() {
  //   return Form(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         SvgPicture.asset(
  //           "assets/images/poliglotim_login.svg",
  //           height: 100,
  //           width: 100,
  //         ),
  //         const SizedBox(height: 40),
  //         CustomTextField(
  //           label: 'Имя пользователя',
  //           controller: _usernameController,
  //           validator: (v) => v!.isEmpty ? 'Введите имя пользователя' : null,
  //         ),
  //         const SizedBox(height: 16),
  //         CustomTextField(
  //           label: 'Пароль',
  //           obscureText: true,
  //           controller: _passwordController,
  //           validator: (v) => v!.isEmpty ? 'Введите пароль' : null,
  //         ),
  //         const SizedBox(height: 24),
  //         CustomCircleButton(
  //           onPressed: () => { widget.viewModel.login.execute((_usernameController.value.text, _usernameController.value.text))},
  //           icon: Icons.arrow_upward_outlined,
  //         ),
  //         // Container(
  //         //   child: Text(_viewModel.error.toString()),
  //         // )
  //       ],
  //     ),
  //   );
  // }
}
