import 'package:flutter/material.dart';
import 'package:poliglotim/presentation/viewmodels/course_viewmodel.dart';

import 'package:poliglotim/domain/models/lesson.dart';
import 'package:poliglotim/domain/models/chapter.dart';

import 'package:poliglotim/presentation/views/ui/loading_indicator.dart';

import 'package:flutter_svg/flutter_svg.dart';


class Menu extends StatefulWidget {
  final String courseId;
  final CourseViewModel viewModel;

  const Menu({super.key, required this.courseId, required this.viewModel});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool menuIsOpened = true;
  List<Chapter> chapters = [];
  // late final CourseViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _selectLesson();
    _loadChapters();
  }

  void _selectLesson()  {
    widget.viewModel.selectLesson(null);
  }

  Future<void> _loadChapters() async {
    await widget.viewModel.loadChapters(widget.courseId);
    setState(() {
      chapters = widget.viewModel.chapters;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
      children: [
        AnimatedMenuContainer(
          isExpanded: menuIsOpened,
          child: Column(
            children: [
              _buildLogo(context),
              _buildChaptersList(widget.viewModel),
            ],
          ),
        ),

        // развернуть свернуть меню
        MenuToggleButton(
          isExpanded: menuIsOpened,
          // onPressed: viewModel.toggleMenu,
          onPressed: () => toggleMenu(),
        ),
      ],
    ));
  }

  void toggleMenu() {
    setState(() {
      menuIsOpened =!menuIsOpened;
    });
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
        itemCount: chapters.length,
        itemBuilder: (context, index) => ChapterTile(
          chapter: chapters[index],
          viewModel: viewModel,
        ),
      ),
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
            for (Lesson lesson in chapter.lessons) Padding(
              padding: const EdgeInsets.only(left: 24),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(lesson.title),
                onTap: () => viewModel.selectLesson(lesson),
              ),
            ),
        ],
      ),
    );
  }
}

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