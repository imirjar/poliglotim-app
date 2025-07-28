// api/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poliglotim/core/constants/api_constants.dart';

class StudyApi {
  final httpClient = http.Client();
  static const String _coursesEndpoint = ApiConstants.coursesEndpoint;

  Future<dynamic> getCourses() async {
    final uri = Uri.parse('$_coursesEndpoint/courses');
    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from $_coursesEndpoint/courses');
    }
  }

  Future<dynamic> getCourseChapters(String ip) async {
    final uri = Uri.parse('$_coursesEndpoint/chapters/$ip');
    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from $uri');
    }
  }

  Future<dynamic> getLesson(String ip) async {
    final uri = Uri.parse('$_coursesEndpoint/lesson/$ip');
    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from $uri');
    }
  }

  // Можно добавить методы post, put, delete при необходимости
}