import 'package:poliglotim/domain/models/chapter.dart';
import 'package:poliglotim/domain/models/lesson.dart';

import '../models/course.dart';
import 'package:poliglotim/data/api/study_api.dart';

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

  Future<List<Lesson>> getChapterLessons(String id) async {
    final response = await apiClient.getChapterLessons(id);
    return (response as List).map((json) => Lesson.fromJson(json)).toList();
  }

  Future<Lesson> getLesson(String id) async {
    final response = await apiClient.getChapterLessons(id);
    return (response).map((json) => Lesson.fromJson(json));
  }
}
