import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:poliglotim/ui/course/view_models/course_viewmodel.dart';
import 'package:poliglotim/ui/core/ui/elements/indicators/loading_indicator.dart';
import 'package:poliglotim/ui/core/ui/elements/placeholders/empty_placeholder.dart';

class CourseBody extends StatelessWidget {
  final CourseViewModel viewModel;
  const CourseBody({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: const [
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
        ],
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      // ListenableBuilder теперь является единственным и главным механизмом
      // для обновления этого виджета.
      child: ListenableBuilder(
        listenable: viewModel, // Можно использовать viewModel вместо widget.viewModel
        builder: (context, _) {
          final lesson = viewModel.lesson;

          // Первым делом проверяем загрузку (можно добавить проверку lesson == null)
          if (viewModel.isLoading && lesson == null) {
            return const LoadingIndicator();
          }

          // Если не грузимся, но урока нет
          if (lesson == null) {
            return const EmptyPlaceholder(message: 'Выберите урок');
          }

          // Если урок есть, но текст пустой (возможно, грузится контент)
          if (lesson.text.isEmpty) {
            return const LoadingIndicator(message: 'Загрузка содержимого...');
          }

          // Если все хорошо, показываем контент
          return Markdown(data: lesson.text);
        },
      ),
    );
  }
}