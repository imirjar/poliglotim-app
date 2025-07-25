import 'package:flutter/material.dart';
import 'package:poliglotim/presentation/views/ui/elements/styles/button_styles.dart';

class CustomCircleButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomCircleButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<CustomCircleButton> createState() => _CustomCircleButtonState();
}

class _CustomCircleButtonState extends State<CustomCircleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      onHover: (hover) => setState(() => _isHovered = hover),
      style: ButtonStyles.circleButtonStyle(_isHovered),
      child: Icon(
        widget.icon,
        color: const Color.fromARGB(221, 166, 166, 166),
      ),
    );
  }
}