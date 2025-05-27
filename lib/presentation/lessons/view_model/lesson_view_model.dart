import 'package:flutter/material.dart';
import 'package:poliglotim/data/repositories/lesson_repository.dart';
import 'package:poliglotim/data/repositories/chapter_repository.dart';
import 'package:poliglotim/domain/entities/response.dart';

// import '../../../data/services/study_api.dart';
import '../../../domain/models/lesson.dart';
import '../../../domain/models/task.dart';
// import '../../../data/repositories/progress_manager.dart';
import 'package:logging/logging.dart';

class LessonViewModel extends ChangeNotifier {
  LessonViewModel({
    required LessonRepository lessonRepo,
  })  : _lessonRepo = lessonRepo {
    loadLessons(1);
  }

  final LessonRepository _lessonRepo;

  List<Lesson> _lessons = [];
  Lesson? _selectedLesson;
  // int _currentTaskIndex = 0;
  final _log = Logger('LessonViewModel');

  List<Lesson> get lessons => _lessons;
  Lesson? get selectedLesson => _selectedLesson;

  Future<Result> loadLessons(int id) async {
     _log.fine('Loaded lessons');
    try {
      final userResult = await _lessonRepo.getLessons(id);
      switch (userResult) {
        case Ok<List<Lesson>>():
          _lessons = userResult.value;
          notifyListeners();
        case Error<List<Lesson>>():
          // Обработка ошибки
      }
      return userResult;
    } finally {
      notifyListeners();
    }
  }

  void onLessonSelected(Lesson lesson) {
    _selectedLesson = lesson;
  }
}


class TaskViewModel extends ChangeNotifier {
  TaskViewModel({
    required TaskRepository taskRepo,
    // required ProgressManager progressManager,
  })  : _taskRepo = taskRepo {
    loadLessons(1);
  }
  
        // _progressManager = progressManager;

  final TaskRepository _taskRepo;
  // final ProgressManager _progressManager;

  List<Task> _tasks = [];
  int _currentTaskIndex = 0;
  final _log = Logger('TaskViewModel');

  List<Task> get tasks => _tasks;
  int get currentTaskIndex => _currentTaskIndex;

  Future<Result> loadLessons(int id) async {
    // var lessonsResult = await _lessonRepo.getLessons(id);
    // if (_lessons.isNotEmpty) {
    //   _selectedLesson = _lessons[0];
    // }
    // return lessonsResult;
     _log.fine('Loaded lessons');
    try {
      final userResult = await _taskRepo.getTasks(id, id);
      switch (userResult) {
        case Ok<List<Task>>():
          _tasks = userResult.value;
          notifyListeners();
        case Error<List<Task>>():
          // Обработка ошибки
      }
      return userResult;
    } finally {
      notifyListeners();
    }
    
  }

  void onTaskChanged(int index) {
    _currentTaskIndex = index;
  }


}