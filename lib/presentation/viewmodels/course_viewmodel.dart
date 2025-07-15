import 'package:flutter/foundation.dart';
import 'package:poliglotim/domain/models/chapter.dart';
import 'package:poliglotim/domain/models/lesson.dart';
import 'package:poliglotim/domain/repositories/course_repo.dart';

class CourseViewModel with ChangeNotifier {
  final CourseRepository _repository;

  bool _isMenuExpanded = false;
  bool get isMenuExpanded => _isMenuExpanded;

  List<Chapter> _chapters = []; // Инициализирован пустым списком
  List<Lesson> _lessons = [];   // Инициализирован пустым списком
  
  Lesson? _selectedLesson;
  String? _selectedChapterId;
  bool _isLoading = false;
  String? _error;
  Lesson? _lessonContent;

  CourseViewModel(this._repository); // Упрощенный конструктор

  List<Chapter> get chapters => _chapters;
  List<Lesson> get lessons => _lessons;
  Lesson? get selectedLesson => _selectedLesson;
  String? get selectedChapterId => _selectedChapterId;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Lesson? get lessonContent => _lessonContent;

  // Добавляем флаг для принудительного обновления LessonContent
  int _contentVersion = 0;
  int get contentVersion => _contentVersion;

  Future<void> selectChapter(String chapterId) async {
    if (_selectedChapterId == chapterId) return;
    
    _selectedChapterId = chapterId;
    _selectedLesson = null;
    _lessonContent = null;
    _contentVersion++; // Увеличиваем версию контента
    
    await _executeWithLoading(() async {
      _lessons = await _repository.getChapterLessons(chapterId);
      
      if (_lessons.isNotEmpty) {
        await selectLesson(_lessons.first);
      }
    });
  }

  Future<void> selectLesson(Lesson lesson) async {
    if (_selectedLesson?.id == lesson.id) return;
    
    _selectedLesson = lesson;
    _contentVersion++; // Увеличиваем версию контента
    
    await _executeWithLoading(() async {
      _lessonContent = await _repository.getLesson(lesson.id);
    });
  }

  void toggleMenu() {
    _isMenuExpanded = !_isMenuExpanded;
    notifyListeners();
  }

  
  Future<void> loadCourseData(String courseId) async {
    await _executeWithLoading(() async {
      _chapters = await _repository.getCourseChapters(courseId);
      
      if (_chapters.isNotEmpty) {
        await selectChapter(_chapters.first.id);
      }
    });
  }


  Future<void> _executeWithLoading(Future<void> Function() action) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      await action();
    } catch (e) {
      _error = e.toString();
      // В зависимости от операции можно сбросить соответствующие данные
      if (action == loadCourseData) {
        _chapters = [];
        _lessons = [];
        _selectedChapterId = null;
        _selectedLesson = null;
        _lessonContent = null;
      } else if (action == selectChapter) {
        _lessons = [];
        _selectedLesson = null;
        _lessonContent = null;
      } else if (action == selectLesson) {
        _lessonContent = null;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}