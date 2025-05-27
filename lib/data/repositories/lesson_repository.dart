

import 'package:poliglotim/data/services/study_api.dart';
import 'package:poliglotim/domain/entities/response.dart';
import 'package:poliglotim/domain/models/lesson.dart';

class LessonRepository {
  LessonRepository({
    required StudyApi apiClient,
  }) : _apiClient = apiClient;

  final StudyApi _apiClient;

  Future<Result<List<Lesson>>> getLessons(int courseID) async {
    try {
      // Get the booking by ID from server.
      final resultLessons = await _apiClient.getCourseLessons(courseID);
      return resultLessons;
    } on Exception catch (e) {
      // return Result.error(e);
      return Result.error(e);
    }
  }
}