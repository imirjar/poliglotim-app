import 'package:flutter/material.dart';
import 'package:poliglotim/ui/home/view/components/course_card.dart';
import 'package:poliglotim/ui/home/view_models/home_viewmodel.dart';

// courses_body.dart
class HomeBody extends StatelessWidget {
  final HomeViewModel viewModel;
  final int crossAxisCount;

  const HomeBody({
    super.key, 
    required this.crossAxisCount, 
    required this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.1,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          padding: const EdgeInsets.only(bottom: 16, left: 18),
          itemCount: viewModel.courses.length,
          itemBuilder: (context, index) => CourseCard(
            course: viewModel.courses[index],
          ),
        );
      },
    );
  }
}