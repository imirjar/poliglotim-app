import 'package:flutter/material.dart';
import 'package:poliglotim/injection_container.dart' as di;
import 'package:poliglotim/presentation/viewmodels/courses_viewmodel.dart';
import 'package:poliglotim/presentation/views/study/courses/card.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late final CoursesViewModel _viewModel;
  final double _screenPadding = 64.0;
  final double _cardSpacing = 16.0;

  @override
  void initState() {
    super.initState();
    _viewModel = di.getIt<CoursesViewModel>();
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = 
        constraints.maxWidth > 1000 
            ? 4
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
          padding: EdgeInsets.all(_screenPadding),
          children: _viewModel.courses.map((course) => 
            CourseCard(course: course),
          ).toList(),
        );
      },
    );
  }

}