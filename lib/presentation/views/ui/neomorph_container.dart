import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final Color color;
  final BorderRadius borderRadius;
  final Offset lightSource;
  final double intensity;
  final double blur;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final AlignmentGeometry alignment;
  final BoxShape shape;
  final List<BoxShadow>? customShadows;

  const NeumorphicContainer({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.color = const Color.fromARGB(255, 255, 255, 255),
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.lightSource = const Offset(-1, -1),
    this.intensity = 0.8,
    this.blur = 20.0,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.shape = BoxShape.rectangle,
    this.customShadows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isCircle = shape == BoxShape.circle;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Рассчитываем тени на основе направления источника света
    final List<BoxShadow> shadows = customShadows ??
        [
          // Тень "внешняя" (светлая)
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(intensity)
                : Colors.white.withOpacity(intensity),
            offset: Offset(-lightSource.dx * blur / 20, -lightSource.dy * blur / 20),
            blurRadius: blur,
            spreadRadius: 1,
          ),
          // Тень "внутренняя" (тёмная)
          BoxShadow(
            color: isDark
                ? Colors.grey.shade900.withOpacity(intensity)
                : Colors.grey.shade500.withOpacity(intensity),
            offset: Offset(lightSource.dx * blur / 20, lightSource.dy * blur / 20),
            blurRadius: blur,
            spreadRadius: 1,
          ),
        ];

    return Container(
      width: width,
      height: height,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        shape: shape,
        borderRadius: isCircle ? null : borderRadius,
        boxShadow: shadows,
      ),
      child: ClipRRect(
        // borderRadius: isCircle ? null : borderRadius,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}