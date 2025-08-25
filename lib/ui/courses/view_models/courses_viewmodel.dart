import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/data/repositories/courses/course_repository.dart';
import 'package:poliglotim/utils/result.dart';
// view_models/courses_view_model.dart

class CoursesViewModel with ChangeNotifier {
  final CourseRepository _repository;

  CoursesViewModel({
    required CourseRepository courseRepository,
  }) : _repository = courseRepository;

  final _log = Logger('CoursesViewModel');

  List<Course> _courses = [];
  bool _isLoading = false;
  String? _error;

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  String? get error => _error;
  

  Future<Result<void>> getCourses() async {
    _isLoading = true;
    _error = null;

    final result = await _repository.getCourses();
    switch(result) {
      case Ok():
        _courses = result.value;
        _isLoading = false;
        notifyListeners();
        // print("FEEEEEE $_courses");
        // return result;
      case Error():
        // return Result.error(result.error);
        _isLoading = false;
        _log.warning("Failed to load courses");
    }
    return result;
  }
}