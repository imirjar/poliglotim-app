import 'package:flutter/material.dart';
import 'package:poliglotim/domain/models/chapter.dart';
import 'package:poliglotim/domain/models/lesson.dart';
import 'package:poliglotim/domain/repositories/course_repository.dart';

class CourseViewModel extends ChangeNotifier {
  final CourseRepository _repository;

  CourseViewModel(this._repository);

  // State
  List<Chapter> _chapters = [];
  List<Lesson> _lessons = [];
  String? _selectedChapterId;
  String? _selectedLessonId;
  bool _isMenuExpanded = true;
  bool _isLoading = false;
  String? _error;
  bool _hasInitialLoad = false;

  // Getters
  List<Chapter> get chapters => _chapters;
  List<Lesson> get lessons => _lessons;
  String? get selectedChapterId => _selectedChapterId;
  String? get selectedLessonId => _selectedLessonId;
  bool get isMenuExpanded => _isMenuExpanded;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasInitialLoad => _hasInitialLoad;
  
  Lesson? get currentLesson => _getCurrentItem(_lessons, _selectedLessonId);
  Chapter? get currentChapter => _getCurrentItem(_chapters, _selectedChapterId);

  T? _getCurrentItem<T extends dynamic>(List<T> items, String? selectedId) {
    if (selectedId == null || items.isEmpty) return null;
    return items.firstWhere((item) => (item as dynamic).id == selectedId);
  }

  // Public methods
  Future<void> loadCourseData(String courseId) async {
    await _executeWithLoading(() async {
      _chapters = await _repository.getCourseChapters(courseId);
      if (_chapters.isEmpty) throw Exception('В курсе нет глав');
      
      _selectedChapterId = _chapters.first.id;
      await _loadLessons(_selectedChapterId!);
      _hasInitialLoad = true;
    }, errorMessage: 'Ошибка загрузки курса');
  }

  Future<void> selectChapter(String chapterId) async {
    if (_selectedChapterId == chapterId) return;
    
    _selectedChapterId = chapterId;
    _selectedLessonId = null;
    notifyListeners();
    
    await _loadLessons(chapterId);
  }

  Future<void> selectLesson(String lessonId) async {
    if (_selectedLessonId == lessonId) return;
    await _loadLessonContent(lessonId);
  }

  void navigateToAdjacentChapter(bool next) {
    if (_chapters.isEmpty || _selectedChapterId == null) return;
    
    final currentIndex = _chapters.indexWhere((c) => c.id == _selectedChapterId);
    final newIndex = next ? currentIndex + 1 : currentIndex - 1;
    
    if (newIndex >= 0 && newIndex < _chapters.length) {
      selectChapter(_chapters[newIndex].id);
    }
  }

  void toggleMenu() {
    _isMenuExpanded = !_isMenuExpanded;
    notifyListeners();
  }

  Future<void> retryLoading(String courseId) async {
    _error = null;
    notifyListeners();
    await loadCourseData(courseId);
  }

  // Private methods
  Future<void> _loadLessons(String chapterId) async {
    await _executeWithLoading(() async {
      _lessons = await _repository.getChapterLessons(chapterId);
      
      if (_lessons.isEmpty) {
        _error = 'В этой главе пока нет уроков';
      } else {
        _selectedLessonId = _lessons.first.id;
        await _loadLessonContent(_selectedLessonId!);
      }
    }, errorMessage: 'Не удалось загрузить список уроков');
  }

  Future<void> _loadLessonContent(String lessonId) async {
    await _executeWithLoading(() async {
      final fullLesson = await _repository.getLesson(lessonId);
      final index = _lessons.indexWhere((l) => l.id == lessonId);
      
      if (index != -1) _lessons[index] = fullLesson;
      _selectedLessonId = lessonId;
      _error = null;
    }, errorMessage: 'Не удалось загрузить содержимое урока');
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