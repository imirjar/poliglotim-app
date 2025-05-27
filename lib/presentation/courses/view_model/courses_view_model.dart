import 'package:flutter/foundation.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/repositories/course_repo.dart';

class CourseViewModel with ChangeNotifier {
  final CourseRepository _courseRepository;
  
  List<Course> _courses = [];
  bool _isLoading = false;
  String? _error;

  CourseViewModel(this._courseRepository);
  
  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _courses = await _courseRepository.getCourses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createCourse(Course course) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final newCourse = await _courseRepository.createCourse(course);
      _courses.add(newCourse);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}