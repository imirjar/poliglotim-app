

import 'package:poliglotim/data/services/study_api.dart';
import 'package:poliglotim/domain/entities/response.dart';
import 'package:poliglotim/domain/models/task.dart';

class TaskRepository {
  TaskRepository({
    required StudyApi apiClient,
  }) : _apiClient = apiClient;

  final StudyApi _apiClient;

  Future<Result<List<Task>>> getTasks(int courseID, lessonID) async {
    try {
      // Get the booking by ID from server.
      final resultTasks = await _apiClient.getTasks(courseID, lessonID);
      return resultTasks;
    } on Exception catch (e) {
      // return Result.error(e);
      return Result.error(e);
    }
  }
}