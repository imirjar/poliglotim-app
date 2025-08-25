import 'package:flutter/material.dart';
import 'package:poliglotim/ui/course/view/course_body.dart';
import 'package:poliglotim/ui/course/view/course_menu.dart';
import 'package:poliglotim/ui/course/view_models/course_viewmodel.dart';

class CourseScreen extends StatefulWidget {
  final CourseViewModel viewModel;
  final String courseId;

  const CourseScreen({
    super.key, 
    required this.courseId,
    required this.viewModel,
  });

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

// course_screen.dart
class _CourseScreenState extends State<CourseScreen> {
  bool isMenuOpened = true;

  @override
  void initState() {
    super.initState();
    // ЗАГРУЗКА ДАННЫХ ИНИЦИИРУЕТСЯ ЗДЕСЬ!
    // Это гарантирует, что данные загрузятся всего один раз при открытии экрана,
    // независимо от того, что происходит с меню.
    widget.viewModel.loadChapters(widget.courseId);
  }

  @override
  void didUpdateWidget(CourseScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если курс изменился (например, при навигации по deep link),
    // загружаем данные для нового курса.
    if (oldWidget.courseId != widget.courseId) {
      widget.viewModel.loadChapters(widget.courseId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedMenuContainer(
            isExpanded: isMenuOpened,
            child: CourseMenu(
              // Key теперь не так критически важен, т.к. нет своего состояния
              courseId: widget.courseId,
              viewModel: widget.viewModel,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                CourseBody(viewModel: widget.viewModel),
                Container(
                  alignment: Alignment.centerLeft,

                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Цвет фона
                      // Дополнительные настройки:
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)), // Закругленные углы
                      side: BorderSide(color: Colors.grey.shade300), // Граница
                      elevation: 2, // Тень
                    ),
                    onPressed: () => toggleMenu(),
                    icon: Icon(isMenuOpened ? Icons.chevron_left : Icons.chevron_right),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void toggleMenu() {
    setState(() {
      isMenuOpened = !isMenuOpened;
    });
  }
}