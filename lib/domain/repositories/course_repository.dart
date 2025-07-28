import 'package:poliglotim/domain/models/chapter.dart';
import 'package:poliglotim/domain/models/lesson.dart';

import '../models/course.dart';
import 'package:poliglotim/data/api/study_api.dart';

// import 'dart:developer' as developer;

class CourseRepository {
  final StudyApi apiClient;

  CourseRepository(this.apiClient);

  Future<List<Course>> getCourses() async {
    final response = await apiClient.getCourses();
    return (response as List).map((json) => Course.fromJson(json)).toList();
  }

  Future<List<Chapter>> getCourseChapters(String id) async {
    final response = await apiClient.getCourseChapters(id);
    return (response as List).map((json) => Chapter.fromJson(json)).toList();
  }

  Future<String> getLessonText(String lessonId) async {
    final response = await apiClient.getLesson(lessonId);
    Lesson lesson = Lesson.fromJson(response);
    return lesson.text;
  }

}
