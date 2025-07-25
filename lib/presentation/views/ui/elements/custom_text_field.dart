import 'package:flutter/material.dart';
import 'package:poliglotim/presentation/views/ui/elements/styles/input_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputStyles.inputDecoration(label),
      validator: validator,
    );
  }
}