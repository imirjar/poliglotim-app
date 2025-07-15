import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:poliglotim/injection_container.dart' as di;
import 'package:poliglotim/presentation/viewmodels/course_viewmodel.dart';
import 'package:poliglotim/presentation/views/study/course/widgets/chapter_menu.dart';
import 'package:poliglotim/presentation/views/study/course/widgets/lesson_content.dart';

class CourseScreen extends StatefulWidget {
  final String courseId;

  const CourseScreen({super.key, required this.courseId});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final CourseViewModel _viewModel;
  bool _isMenuExpanded = true;

  @override
  void initState() {
    super.initState();
    _viewModel = di.getIt<CourseViewModel>();
    _viewModel.loadCourseData(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Row(
        children: [
          ChapterMenu(),
          Expanded(child: _buildMainContent()),
        ],
    );
  }

  Widget _buildMainContent() {
    return Consumer<CourseViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading && viewModel.chapters.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null) {
          return Center(child: Text('Error: ${viewModel.error}'));
        }

        return Column(
          children: [
            // if (viewModel.chapters.isNotEmpty) 
            //   const LessonContent(),
            if (viewModel.lessonContent != null) 
              Expanded(child: LessonContent()),
          ],
        );
      },
    );
  }
}