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
    // this.color = const Color.fromRGBO(255, 255, 255, 1),
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