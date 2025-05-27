import 'package:flutter/material.dart';
import '../../../domain/models/task.dart';
import 'tasks/video_task.dart';
import 'tasks/fill_task.dart';
import 'tasks/match_task.dart';
import 'task_navigation_bar.dart';
import '../view_model/lesson_view_model.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Курс китайского языка'),
      ),
      drawer: Consumer<LessonViewModel>(
        builder: (context, viewModel, child) {

          // Панель навигации в левой части
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader( // Убрали const
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Уроки',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Перенаправление на /home
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: const Text('Назад'),
                      ),
                    ],
                  ),
                ),
                for (var i = 0; i < viewModel.lessons.length; i++)
                  ListTile(
                    title: Text(
                      viewModel.lessons[i].title,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      viewModel.onLessonSelected(viewModel.lessons[i]);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          );
        },
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Expanded(
                child: _buildTask(viewModel.tasks[viewModel.currentTaskIndex]),
              ),
              TaskNavigationBar(
                onTaskChanged: viewModel.onTaskChanged,
                currentIndex: viewModel.currentTaskIndex,
                totalTasks: viewModel.tasks.length,
              ),
            ],
          );
        },
      ),
    );
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
}