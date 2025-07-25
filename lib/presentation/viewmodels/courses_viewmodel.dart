import 'package:flutter/foundation.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/domain/repositories/course_repository.dart';
// view_models/courses_view_model.dart

class CoursesViewModel with ChangeNotifier {
  final CourseRepository _repository;

  CoursesViewModel(this._repository);

  List<Course> _courses = [];
  bool _isLoading = false;
  String? _error;

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _courses = await _repository.getCourses();
      _error = null;
    } catch (e) {
      // print("ERROR is $e");
      _error = e.toString();
      _courses = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}