import 'package:poliglotim/domain/models/lesson.dart';
import 'package:poliglotim/domain/models/chapter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:poliglotim/injection_container.dart' as di;
import 'package:poliglotim/presentation/viewmodels/course_viewmodel.dart';
import 'package:poliglotim/presentation/views/study/course/lesson_body.dart';
import 'package:poliglotim/presentation/views/ui/loading_indicator.dart';
import 'package:poliglotim/presentation/views/ui/error_placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseScreen extends StatefulWidget {
  final String courseId;

  const CourseScreen({super.key, required this.courseId});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final CourseViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = di.getIt<CourseViewModel>();
    _loadData();
  }

  Future<void> _loadData() async {
    await _viewModel.loadCourseData(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        body: Consumer<CourseViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.error != null && !viewModel.hasInitialLoad) {
              return ErrorPlaceholder(
                message: viewModel.error!,
                onRetry: _loadData,
              );
            }

            if (viewModel.isLoading && !viewModel.hasInitialLoad) {
              return const Center(child: LoadingIndicator());
            }

            return Row(
              children: [
                _buildCourseMenu(context, viewModel),
                _buildMainContent(viewModel),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(CourseViewModel viewModel) {
    return viewModel.error != null
        ? Expanded(child: ErrorPlaceholder(message: viewModel.error!, onRetry: _loadData))
        : const Expanded(child: ChapterBody());
  }

  Widget _buildCourseMenu(BuildContext context, CourseViewModel viewModel) {
    return Row(
      children: [
        AnimatedMenuContainer(
          isExpanded: viewModel.isMenuExpanded,
          child: Column(
            children: [
              _buildLogo(context),
              _buildChaptersList(viewModel),
            ],
          ),
        ),
        MenuToggleButton(
          isExpanded: viewModel.isMenuExpanded,
          onPressed: viewModel.toggleMenu,
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, '/courses'),
      child: SvgPicture.asset(
        "assets/images/poliglotim_login.svg",
        height: 150,
        width: 150,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildChaptersList(CourseViewModel viewModel) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16, left: 18),
        itemCount: viewModel.chapters.length,
        itemBuilder: (context, index) => ChapterTile(
          chapter: viewModel.chapters[index],
          viewModel: viewModel,
        ),
      ),
    );
  }
}

// Reusable components
class AnimatedMenuContainer extends StatelessWidget {
  final bool isExpanded;
  final Widget child;

  const AnimatedMenuContainer({
    super.key,
    required this.isExpanded,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 280 : 0,
      curve: Curves.easeInOut,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.centerLeft,
          maxWidth: 280,
          child: child,
        ),
      ),
    );
  }
}

class MenuToggleButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onPressed;

  const MenuToggleButton({
    super.key,
    required this.isExpanded,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(isExpanded ? Icons.chevron_left : Icons.chevron_right),
    );
  }
}

class ChapterTile extends StatelessWidget {
  final Chapter chapter;
  final CourseViewModel viewModel;

  const ChapterTile({
    super.key,
    required this.chapter,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        trailing: const SizedBox.shrink(),
        // visualDensity: const VisualDensity.minimumDensity,
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Text(
          chapter.name,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        children: [
          if (viewModel.isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LoadingIndicator(size: 20),
            )
          else
            ...viewModel.lessons.map((lesson) => LessonTile(
              lesson: lesson,
              isSelected: lesson.id == viewModel.selectedLessonId,
              onTap: () => viewModel.selectLesson(lesson.id),
            )).toList(),
        ],
      ),
    );
  }
}

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final bool isSelected;
  final VoidCallback onTap;

  const LessonTile({
    super.key,
    required this.lesson,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Text(lesson.title),
        onTap: onTap,
      ),
    );
  }
}