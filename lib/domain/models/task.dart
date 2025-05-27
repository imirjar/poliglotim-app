// lib/models/task.dart
class Task {
  final String id;
  final String type; // Тип задания: "video", "fill", "match"
  final dynamic data; // Данные задания (зависят от типа)

  Task({required this.id, required this.type, required this.data});
}