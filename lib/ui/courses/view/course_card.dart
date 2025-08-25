import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/routing/router.dart';

class CourseCard extends StatelessWidget{
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go("/course/${course.id}"),
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
          // width: 100,
          // height: 50,
          padding: const EdgeInsets.all(24.0),
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'PonomarUnicode',
                    ),
                    children: _buildTitleWithRedLetters(course.name),
                  ),
                ),
              ),
              if (course.description.isNotEmpty) 
                Text(
                  course.description.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'PonomarUnicode',
                    fontSize: 16,
                    // color: Colors.black87,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
    );
  }



  List<TextSpan> _buildTitleWithRedLetters(String text) {
    final words = text.toUpperCase().split(' ');
    final spans = <TextSpan>[];

    for (var word in words) {
      if (word.isEmpty) continue;
      
      // Добавляем пробел перед словом (кроме первого)
      if (spans.isNotEmpty) {
        spans.add(const TextSpan(text: ' '));
      }

      // Первая буква красная, остальные черные
      spans.add(TextSpan(
        text: word.substring(0, 1),
        style: const TextStyle(
          color: Colors.red,
          fontSize: 34, // Первая буква немного больше
        ),
      ));
      
      if (word.length > 1) {
        spans.add(TextSpan(text: word.substring(1)));
      }
    }

    return spans;
  }


  // void _navigateToCourse(BuildContext context, Course course) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CourseScreen(courseId: course.id),
  //     ),
  //   );
  // }

}

// @override
  // Widget build(BuildContext context) {
  //   final bool isCircle = shape == BoxShape.circle;

  //   // Рассчитываем тени на основе направления источника света
  //   final List<BoxShadow> shadows = customShadows ??
  //     [
  //       const BoxShadow(
  //         color: Colors.white30,
  //         offset: Offset(-4, -4),
  //         blurRadius: 8,
  //       ),
  //       const BoxShadow(
  //         color: Colors.black38,
  //         offset: Offset(4, 4),
  //         blurRadius: 12,
  //       ),
  //     ];

  //   return Container(
  //     width: width,
  //     height: height,
  //     margin: margin,
  //     alignment: alignment,
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).scaffoldBackgroundColor,
  //       shape: shape,
  //       borderRadius: isCircle ? null : borderRadius,
  //       boxShadow: shadows,
  //     ),
  //     child: ClipRRect(
  //       // borderRadius: isCircle ? null : borderRadius,
  //       child: Padding(
  //         padding: padding,
  //         child: child,
  //       ),
  //     ),
  //   );
  // }