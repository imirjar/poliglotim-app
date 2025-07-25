import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:poliglotim/presentation/views/ui/neomorph_container.dart';
import 'package:provider/provider.dart';
import 'package:poliglotim/presentation/viewmodels/course_viewmodel.dart';
import 'package:poliglotim/presentation/views/ui/loading_indicator.dart';
import 'package:poliglotim/presentation/views/ui/empty_placeholder.dart';

import 'package:poliglotim/domain/models/lesson.dart';

class ChapterBody extends StatelessWidget {
  const ChapterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CourseViewModel>();

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // if (viewModel.chapters.length > 1) ChapterNavigation(viewModel: viewModel),
          Expanded(child: LessonContent(viewModel: viewModel)),
        ],
      ),
    );
  }
}


class LessonContent extends StatelessWidget {
  final CourseViewModel viewModel;

  const LessonContent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) return const LoadingIndicator();
    if (viewModel.currentLesson == null) return const EmptyPlaceholder(message: 'Выберите урок');
    if (viewModel.currentLesson!.text.isEmpty) {
      return const LoadingIndicator(message: 'Загрузка содержимого...');
    }

    return NeumorphicContainer(
      child: Markdown(data: viewModel.currentLesson!.text),
    );
  }
}

// Reusable components
class NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;

  const NavigationButton({
    super.key,
    required this.icon,
    this.onPressed,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      tooltip: tooltip,
    );
  }
}

class LessonChip extends StatelessWidget {
  final Lesson lesson;
  final bool isSelected;
  final VoidCallback onSelected;

  const LessonChip({
    super.key,
    required this.lesson,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(lesson.title),
        selected: isSelected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}