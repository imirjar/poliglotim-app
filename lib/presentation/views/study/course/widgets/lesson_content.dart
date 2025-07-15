import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:poliglotim/presentation/viewmodels/course_viewmodel.dart';

class LessonContent extends StatelessWidget {
  const LessonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseViewModel>(
      builder: (context, viewModel, _) {
        // Используем contentVersion для принудительного пересоздания
        return KeyedSubtree(
          key: ValueKey<int>(viewModel.contentVersion),
          child: Column( 
            children: [ 
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.lessons.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => _buildLessonItem(viewModel, index),
                ),
              ),
              if (viewModel.isLoading && viewModel.lessonContent == null)
                const Center(child: CircularProgressIndicator())
              else if (viewModel.lessonContent != null)
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: _buildDecoration(),
                  child: Markdown(
                    data: "viewModel.lessonContent!.content" ?? 'No content available',
                    styleSheet: _buildMarkdownStyle(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildLessonItem(CourseViewModel viewModel, int index) {
    final lesson = viewModel.lessons[index];
    final isSelected = viewModel.selectedLesson?.id == lesson.id;
    
    return GestureDetector(
      onTap: () => viewModel.selectLesson(lesson),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        decoration: BoxDecoration(
          gradient: _buildItemGradient(isSelected),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.white.withOpacity(0.8) : Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.circle_outlined, color: isSelected ? Colors.white : Colors.white70),
            const SizedBox(height: 8),
            Text(
              (index+1).toString(),
              style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Gradient _buildItemGradient(bool isSelected) {
    return isSelected
        ? LinearGradient(colors: [Colors.blue.shade400.withOpacity(0.7), Colors.blue.shade600.withOpacity(0.9)])
        : LinearGradient(colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.2)]);
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    );
  }

  MarkdownStyleSheet _buildMarkdownStyle() {
    return MarkdownStyleSheet(
      p: const TextStyle(color: Colors.white, fontSize: 16, height: 1.6),
      h1: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      h2: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      code: TextStyle(color: Colors.white, backgroundColor: Colors.black.withOpacity(0.3)),
      a: TextStyle(color: Colors.blue.shade300),
    );
  }
}
