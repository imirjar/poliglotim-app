// lib/services/progress_manager.dart
import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {
  static const String _completedLessonsKey = 'completed_lessons';
  static const String _completedTasksKey = 'completed_tasks';

  // Сохраняем пройденный урок
  static Future<void> saveCompletedLesson(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    final completedLessons = prefs.getStringList(_completedLessonsKey) ?? [];
    if (!completedLessons.contains(lessonId)) {
      completedLessons.add(lessonId);
      await prefs.setStringList(_completedLessonsKey, completedLessons);
    }
  }

  // Сохраняем пройденное задание
  static Future<void> saveCompletedTask(String taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final completedTasks = prefs.getStringList(_completedTasksKey) ?? [];
    if (!completedTasks.contains(taskId)) {
      completedTasks.add(taskId);
      await prefs.setStringList(_completedTasksKey, completedTasks);
    }
  }

  // Получаем список пройденных уроков
  static Future<List<String>> getCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_completedLessonsKey) ?? [];
  }

  // Получаем список пройденных заданий
  static Future<List<String>> getCompletedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_completedTasksKey) ?? [];
  }

  // Очищаем прогресс (для тестирования)
  static Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_completedLessonsKey);
    await prefs.remove(_completedTasksKey);
  }
}