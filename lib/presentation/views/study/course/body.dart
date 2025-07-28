import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:poliglotim/presentation/views/ui/neomorph_container.dart';
import 'package:provider/provider.dart';
import 'package:poliglotim/presentation/viewmodels/course_viewmodel.dart';
import 'package:poliglotim/presentation/views/ui/loading_indicator.dart';
import 'package:poliglotim/presentation/views/ui/empty_placeholder.dart';


import 'package:poliglotim/domain/models/lesson.dart';

class Content extends StatefulWidget {
  // late Lesson lesson;
  final CourseViewModel viewModel;

  const Content({super.key, required this.viewModel});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {

  late final Lesson? lesson;

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     lesson = widget.viewModel.lesson;
  //   });
  //   // lesson = widget.viewModel.lesson;
  // }

  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<CourseViewModel>();

    return Expanded(
      child: NeumorphicContainer(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            final selectedLesson = widget.viewModel.lesson;

            if (widget.viewModel.isLoading) return const LoadingIndicator();
            if (selectedLesson == null) return const EmptyPlaceholder(message: 'Выберите урок');
            if (selectedLesson.title.isEmpty) {
              return const LoadingIndicator(message: 'Загрузка содержимого...');
            }

            return Markdown(data: selectedLesson.text);
            
          }
        )
      )
    );
  }
}


class LessonContent extends StatelessWidget {
  final CourseViewModel viewModel;

  const LessonContent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) return const LoadingIndicator();
    if (viewModel.lesson == null) return const EmptyPlaceholder(message: 'Выберите урок');
    if (viewModel.lesson!.text.isEmpty) {
      return const LoadingIndicator(message: 'Загрузка содержимого...');
    }

    return NeumorphicContainer(
      child: Markdown(data: viewModel.lesson!.text),
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