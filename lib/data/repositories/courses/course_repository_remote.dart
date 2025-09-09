// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:poliglotim/data/repositories/courses/course_repository.dart';
import 'package:poliglotim/data/services/api/course/course_client.dart';
import 'package:poliglotim/domain/models/chapter.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/domain/models/lesson.dart';
import '../../../utils/result.dart';

class CourseRepositoryRemote implements CourseRepository {
  CourseRepositoryRemote({required CourseClient apiClient})
    : _apiClient = apiClient;

  final CourseClient _apiClient;

  // List<Destination>? _cachedDestinations;

  @override
  Future<Result<List<Course>>> getCourses() async {
    try {
      // Get booking by ID from server
      final resultBooking = await _apiClient.getCourses();
      switch (resultBooking) {
        case Error():
          return Result.error(resultBooking.error);
        case Ok():
         return resultBooking;
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<Chapter>>> getCourseChapters(String id) async {
    try {
      // Get booking by ID from server
      final resultBooking = await _apiClient.getCourseChapters(id);
      switch (resultBooking) {
        case Error():
          return Result.error(resultBooking.error);
        case Ok():
         return resultBooking;
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<Lesson>> getLesson(String id) async {
    try {
      // Get booking by ID from server
      final lesson = await _apiClient.getLesson(id);
      switch (lesson) {
        case Error():
          return Result.error(lesson.error);
        case Ok():
         return lesson;
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  
}