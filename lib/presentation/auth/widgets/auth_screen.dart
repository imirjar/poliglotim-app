import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../view_model/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginViewModel viewModel;

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
                  color: const Color.fromARGB(255, 228, 232, 237),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 228, 232, 237),
                      Color.fromARGB(255, 228, 232, 237),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6, -6),
                      blurRadius: 16.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      // color: Colors.black.withOpacity(0.2),
                      color: Colors.black.withValues(alpha: 0.2),
                      offset: const Offset(6, 6),
                      blurRadius: 16.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/images/poliglotim_login.svg",
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        showCursor: false,
                        controller: viewModel.usernameController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(0, 33, 149, 243),
                            ),
                            gapPadding: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(0, 66, 65, 65),
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Имя пользователя',
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 123, 123, 123),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Введите имя пользователя' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        showCursor: false,
                        controller: viewModel.passwordController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(0, 33, 149, 243),
                            ),
                            gapPadding: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(0, 66, 65, 65),
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Пароль',
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 123, 123, 123),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Введите пароль' : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.toggleButtonState();
                          viewModel.login(context);
                        },
                        onHover: (value) {
                          viewModel.setButtonElevation(value ? 2 : 0);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.isPressed
                              ? const Color.fromARGB(255, 171, 174, 177)
                              : const Color.fromARGB(255, 228, 232, 237),
                          overlayColor: const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.all(35.0),
                          shape: const CircleBorder(),
                          elevation: viewModel.buttonElevation,
                        ),
                        child: const Icon(
                          Icons.arrow_upward_outlined,
                          color: Color.fromARGB(221, 166, 166, 166),
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