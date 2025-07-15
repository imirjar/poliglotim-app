import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle circleButtonStyle(bool isHovered) => ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 254, 254, 254),
        overlayColor: Colors.white,
        padding: const EdgeInsets.all(35),
        shape: const CircleBorder(),
        elevation: isHovered ? 2 : 0,
      );
}