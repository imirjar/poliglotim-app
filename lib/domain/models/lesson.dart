class Lesson {
  final String id;
  final String title;
  final String text;
  // final int position;

  Lesson({
    required this.id, 
    required this.title, 
    required this.text, 
    // required this.position
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      text: json['text'] != null ? json['text'] : "no text",
      // position: json['position'],
      // updated: DateTime.parse(json['updated']),
      // logo: json['logo'] != null ? FileModel.fromJson(json['logo']) : null,
    );
  }
}
