import 'package:poliglotim/domain/models/lesson.dart';

class Chapter {
  final String id;
  final String name;
  final String description;
  final DateTime updated;
  final List<Lesson> lessons;

  Chapter({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.updated,
    List<Lesson>? lessons, // Делаем параметр опциональным
  }) : lessons = lessons ?? []; // Устанавливаем пустой список по умолчанию


  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      updated: DateTime.parse(json['updated']),
      lessons: json['lessons'] != null 
          ? (json['lessons'] as List).map((e) => Lesson.fromJson(e)).toList()
          : null, // Явная обработка null
      // updated: DateTime.parse(json['updated']),
      // logo: json['logo'] != null ? FileModel.fromJson(json['logo']) : null,
    );
  }
}