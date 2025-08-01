import 'package:flutter/material.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/presentation/views/study/course/course_screen.dart';
import 'package:poliglotim/presentation/views/ui/neomorph_container.dart';

class CourseCard extends StatelessWidget{
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToCourse(context, course),
      child: NeumorphicContainer(
          // width: 100,
          // height: 50,
          padding: const EdgeInsets.all(26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCourseTitle(course.name),
              if (course.description.isNotEmpty) 
                _buildCourseDescription(course.description),
            ],
          ),
        ),
    );
  }

  
  Widget _buildCourseTitle(String title) {
    return Flexible(
      child: RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text: TextSpan(
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 34,
            // height: 1.2,
            color: Colors.black,
            fontFamily: 'PonomarUnicode',
          ),
          children: _buildTitleWithRedLetters(title),
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

  Widget _buildCourseDescription(String description) {
    return Flexible(
      
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          description.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'PonomarUnicode',
            fontSize: 16,
            color: Colors.black87,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void _navigateToCourse(BuildContext context, Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseScreen(courseId: course.id),
      ),
    );
  }

}