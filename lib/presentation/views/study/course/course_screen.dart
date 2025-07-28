import 'package:flutter/material.dart';
import 'package:poliglotim/presentation/views/study/course/body.dart';
import 'package:poliglotim/presentation/views/study/course/menu.dart';
import 'package:poliglotim/presentation/viewmodels/course_viewmodel.dart';

import 'package:poliglotim/injection_container.dart' as di;

class CourseScreen extends StatelessWidget {
  final String courseId;
  late final CourseViewModel viewModel = di.getIt<CourseViewModel>();
  
  CourseScreen({
    super.key, 
    required this.courseId,
    // required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Menu(key:super.key, courseId: courseId, viewModel: viewModel),
          Content(key:super.key, viewModel: viewModel),
        ],
      ),
    );
  }
}