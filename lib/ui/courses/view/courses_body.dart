import 'package:flutter/material.dart';
import 'package:poliglotim/ui/courses/view/course_card.dart';
import 'package:poliglotim/ui/courses/view_models/courses_viewmodel.dart';


class CoursesBody extends StatefulWidget {
  final CoursesViewModel viewModel;
  final int crossAxisCount;

  const CoursesBody({super.key, required this.crossAxisCount, required this.viewModel});
  @override
  State<CoursesBody> createState() => _CoursesBodyState();
}

class _CoursesBodyState extends State<CoursesBody> {

  @override
  void initState() {
    super.initState();
    widget.viewModel.getCourses();
    // late final chapterss = _loadChapters();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              childAspectRatio: 1.1,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
            ),
            padding: const EdgeInsets.only(bottom: 16, left: 18),
            itemCount: widget.viewModel.courses.length,
            itemBuilder: (context, index) => CourseCard(
              course: widget.viewModel.courses[index],
            ),
        );
      },
    );
  }
}