class Chapter {
  final String id;
  final String name;
  final String description;
  final DateTime updated;

  Chapter({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.updated,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      updated: DateTime.parse(json['updated']),
      // updated: DateTime.parse(json['updated']),
      // logo: json['logo'] != null ? FileModel.fromJson(json['logo']) : null,
    );
  }
}