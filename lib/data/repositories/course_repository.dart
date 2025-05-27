import '../../domain/repositories/course_repo.dart';
import '../../domain/entities/course.dart';
import '../datasources/remote/course_remote_ds.dart';
import '../models/course_dto.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Course>> getCourses() async {
    final coursesDto = await remoteDataSource.getCourses();
    return coursesDto.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Course> getCourse(int id) async {
    final courseDto = await remoteDataSource.getCourse(id);
    return courseDto.toEntity();
  }

  @override
  Future<Course> createCourse(Course course) async {
    final courseDto = CourseDto.fromEntity(course);
    final createdCourseDto = await remoteDataSource.createCourse(courseDto);
    return createdCourseDto.toEntity();
  }

  // @override
  // Future<Course> updateCourse(Course course) async {
  //   final courseDto = CourseDto.fromEntity(course);
  //   final updatedCourseDto = await remoteDataSource.updateCourse(courseDto);
  //   return updatedCourseDto.toEntity();
  // }

  // @override
  // Future<void> deleteCourse(int id) async {
  //   await remoteDataSource.deleteCourse(id);
  // }
}