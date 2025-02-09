// lib/models/lesson.dart
import 'task.dart';

class Lesson {
  final String id;
  final String title;
  final List<Task> tasks;

  Lesson({required this.id, required this.title, required this.tasks});
}
