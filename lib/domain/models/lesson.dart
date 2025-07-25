class Lesson {
  final String id;
  final String title;
  final String text;
  final bool? isCompleted; // Добавим опциональное поле, если оно есть в API

  Lesson({
    required this.id, 
    required this.title, 
    required this.text,
    this.isCompleted,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      text: json['text'] as String? ?? "Нет содержимого", // Более безопасное преобразование
      isCompleted: json['isCompleted'] as bool?, // Если такое поле есть
    );
  }
}