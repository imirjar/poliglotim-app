import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CircleButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      onHover: (hover) => setState(() => _isHovered = hover),
      style: ElevatedButton.styleFrom(
        // backgroundColor: Theme.of(context).colorScheme.secondary,
        overlayColor: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.all(35),
        shape: const CircleBorder(),
        elevation: _isHovered ? 2 : 0,
      ),
      child: Icon(
        widget.icon,
        color: const Color.fromARGB(221, 166, 166, 166),
        // color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}