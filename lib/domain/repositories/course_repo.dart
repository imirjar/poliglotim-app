import '../entities/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses();
  Future<Course> getCourse(int id);
  Future<Course> createCourse(Course course);
  // Future<Course> updateCourse(Course course);
  // Future<void> deleteCourse(int id);
}