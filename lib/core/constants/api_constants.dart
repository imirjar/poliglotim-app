class ApiConstants {
  static const String baseUrl = '';
  static const String coursesEndpoint = 'https://localhost:8080/courses';
  static const String chaptersEndpoint = 'https://localhost:8080/chapters';
  static const String lessonsEndpoint = 'https://localhost:8080/lessons';
  static const String authEndpoint = 'https://localhost:7070/login';
  
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration connectTimeout = Duration(seconds: 15);
}