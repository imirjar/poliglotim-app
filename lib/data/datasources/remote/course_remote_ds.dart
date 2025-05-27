import 'package:dio/dio.dart';
import '../../../core/errors/api_exception.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../../models/course_dto.dart';

class CourseRemoteDataSource {
  final DioClient _dioClient;

  CourseRemoteDataSource(this._dioClient);

  Future<List<CourseDto>> getCourses() async {
    try {
      final response = await _dioClient.instance.get(
        ApiConstants.coursesEndpoint,
      );

      return (response.data as List)
          .map((json) => CourseDto.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? e.message ?? 'Unknown error',
        e.response?.statusCode ?? 500,
      );
    }
  }

  Future<CourseDto> getCourse(int id) async {
    try {
      final response = await _dioClient.instance.get(
        '${ApiConstants.coursesEndpoint}/$id',
      );

      return CourseDto.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? e.message ?? 'Unknown error',
        e.response?.statusCode ?? 500,
      );
    }
  }

  Future<CourseDto> createCourse(CourseDto course) async {
    try {
      final response = await _dioClient.instance.post(
        ApiConstants.coursesEndpoint,
        data: course.toJson(),
      );

      return CourseDto.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? e.message ?? 'Unknown error',
        e.response?.statusCode ?? 500,
      );
    }
  }

  // Другие методы: update, delete и т.д.
}