// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../api/mock_api.dart';
import '../models/lesson.dart';
import '../models/task.dart';
import '../widgets/video_task.dart';
import '../widgets/fill_task.dart';
import '../widgets/match_task.dart';
import '../widgets/task_navigation_bar.dart';
import '../services/progress_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Lesson> _lessons = [];
  Lesson? _selectedLesson;
  int _currentTaskIndex = 0;
  List<String> _completedLessons = [];
  List<String> _completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadLessons();
    _loadProgress();
  }

  Future<void> _loadLessons() async {
    final lessons = await MockApi().getLessons();
    setState(() {
      _lessons = lessons;
      if (lessons.isNotEmpty) {
        _selectedLesson = lessons[0]; // По умолчанию выбираем первый урок
      }
    });
  }

  Future<void> _loadProgress() async {
    final completedLessons = await ProgressManager.getCompletedLessons();
    final completedTasks = await ProgressManager.getCompletedTasks();
    setState(() {
      _completedLessons = completedLessons;
      _completedTasks = completedTasks;
    });
  }

  void _onLessonSelected(Lesson lesson) {
    setState(() {
      _selectedLesson = lesson;
      _currentTaskIndex = 0; // Сбрасываем индекс задания при выборе нового урока
    });
    Navigator.pop(context); // Закрываем Drawer после выбора урока
  }

  void _onTaskChanged(int index) {
    setState(() {
      _currentTaskIndex = index;
    });
  }

  Future<void> _markTaskAsCompleted() async {
    final task = _selectedLesson!.tasks[_currentTaskIndex];
    await ProgressManager.saveCompletedTask(task.id);
    await _loadProgress(); // Обновляем прогресс

    // Если это последнее задание в уроке, отмечаем урок как пройденный
    if (_currentTaskIndex == _selectedLesson!.tasks.length - 1) {
      await ProgressManager.saveCompletedLesson(_selectedLesson!.id);
      await _loadProgress(); // Обновляем прогресс
      setState(() {}); // Обновляем состояние экрана
    }
  }

  Widget _buildTask(Task task) {
    switch (task.type) {
      case "video":
        return VideoTask(data: task.data);
      case "fill":
        return FillTask(data: task.data);
      case "match":
        return MatchTask(data: task.data);
      default:
        return const Center(child: Text("Неизвестный тип задания"));
    }
  }

  // Проверяем, доступен ли урок
  bool _isLessonAvailable(Lesson lesson, int index) {
    if (index == 0) return true; // Первый урок всегда доступен
    final previousLesson = _lessons[index - 1];
    return _completedLessons.contains(previousLesson.id); // Урок доступен, если пройден предыдущий
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedLesson?.title ?? 'Курс китайского языка'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Уроки',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            for (var i = 0; i < _lessons.length; i++)
              ListTile(
                title: Text(
                  _lessons[i].title,
                  style: TextStyle(
                    color: _completedLessons.contains(_lessons[i].id)
                        ? Colors.green // Показываем пройденные уроки зеленым
                        : _isLessonAvailable(_lessons[i], i)
                            ? Colors.black // Доступные уроки черным
                            : Colors.grey, // Недоступные уроки серым
                  ),
                ),
                onTap: _isLessonAvailable(_lessons[i], i)
                    ? () => _onLessonSelected(_lessons[i])
                    : null, // Блокируем нажатие на недоступные уроки
              ),
          ],
        ),
      ),
      body: _selectedLesson == null || _selectedLesson!.tasks.isEmpty
      ? const Center(child: Text('Выберите урок из меню'))
      : Column(
        children: [
          Expanded(
            child: _buildTask(_selectedLesson!.tasks[_currentTaskIndex]),
          ),
          TaskNavigationBar(
            onTaskChanged: _onTaskChanged,
            currentIndex: _currentTaskIndex,
            totalTasks: _selectedLesson!.tasks.length,
          ),
          if (!_completedTasks.contains(_selectedLesson!.tasks[_currentTaskIndex].id))
          ElevatedButton(
            onPressed: _markTaskAsCompleted,
            child: const Text("Задание пройдено"),
          ),
        ],
      ),
    );
  }
}