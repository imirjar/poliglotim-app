import 'package:flutter/material.dart';
import 'package:poliglotim/injection_container.dart' as di;
import 'package:poliglotim/presentation/viewmodels/courses_viewmodel.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/presentation/views/study/course/course_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final CoursesViewModel _viewModel = di.getIt<CoursesViewModel>();
  final double _screenPadding = 24.0;
  final double _cardSpacing = 16.0;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    await _viewModel.fetchCourses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_viewModel.error != null) {
      return Center(
        child: Text('Error: ${_viewModel.error}'),
      );
    }

    if (_viewModel.courses.isEmpty) {
      return const Center(child: Text('No courses available'));
    }

    return Padding(
      padding: EdgeInsets.all(_screenPadding),
      child: _buildCoursesGrid(),
    );
  }

  Widget _buildCoursesGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 800 
            ? 3 
            : constraints.maxWidth > 600 
                ? 2 
                : 1;
                
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          childAspectRatio: 1.1,
          mainAxisSpacing: _cardSpacing,
          crossAxisSpacing: _cardSpacing,
          padding: EdgeInsets.zero,
          children: _viewModel.courses.map((course) => 
            GestureDetector(
              onTap: () => _navigateToCourse(context, course),
              child: _buildCourseCard(course),
            ),
          ).toList(),
        );
      },
    );
  }

  void _navigateToCourse(BuildContext context, Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseScreen(courseId: course.id),
      ),
    );
    
    // Альтернативно через именованный роут:
    // Navigator.pushNamed(
    //   context,
    //   '/course',
    //   arguments: course.id,
    // );
  }

  Widget _buildCourseCard(Course course) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey.shade100],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
            height: 1.2,
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
}