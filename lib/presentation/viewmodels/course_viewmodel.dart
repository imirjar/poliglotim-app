import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poliglotim/domain/models/chapter.dart';
import 'package:poliglotim/domain/models/lesson.dart';
import 'package:poliglotim/domain/repositories/course_repository.dart';

class CourseViewModel extends ChangeNotifier {
  final CourseRepository _repository;
  
  CourseViewModel(this._repository);

  // State
  List<Chapter> _chapters = [];
  bool _isLoading = false;
  Lesson? _lesson;
  String? _error;

  // Getters
  List<Chapter> get chapters => _chapters;
  Lesson? get lesson => _lesson;
  bool get isLoading => _isLoading;

  String? get error => _error;

  // Public methods
  Future<void> loadChapters(String courseId) async {
    await _executeWithLoading(() async {
      _chapters = await _repository.getCourseChapters(courseId);
      if (_chapters.isEmpty) throw Exception('В курсе нет глав');
      notifyListeners();
    }, errorMessage: 'Ошибка загрузки курса');
  }


  Future<void> retryLoading(String courseId) async {
    _error = null;
    notifyListeners();
    await loadChapters(courseId);
  }

  Future<void> selectLesson(Lesson? lesson) async {
    if (lesson == null) {
       _lesson = lesson;
      notifyListeners();
    } else {
      lesson.text = await _repository.getLessonText(lesson.id); // Загружаем данные
      _lesson = lesson;
      notifyListeners();
    }
  }

  Future<void> _executeWithLoading(
    Future<void> Function() action, {
    required String errorMessage,
  }) async {
    try {
      _setLoading(true);
      await action();
    } catch (e) {
      _error = '$errorMessage: ${e.toString()}';
      debugPrint('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}