// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:poliglotim/data/repositories/courses/course_repository.dart';
import 'package:poliglotim/data/services/local/mocks/courses_mock.dart';
import 'package:poliglotim/domain/models/chapter.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/domain/models/lesson.dart';

import '../../../utils/result.dart';


class CourseRepositoryLocal implements CourseRepository {
  CourseRepositoryLocal({required LocalCourseDataService localDataService})
    : _localDataService = localDataService;

  // Only create default booking once
  // bool _isInitialized = false;
  // Used to generate IDs for bookings
  // int _sequentialId = 0;

  List<Course> _courses = List<Course>.empty(growable: true);
  List<Chapter> _chapters = List<Chapter>.empty(growable: true);
  // late Lesson _lessonText;
  final LocalCourseDataService _localDataService;


  @override
  Future<Result<List<Course>>> getCourses() async {
    List<Course> courses = _localDataService.getCourses();
    _courses = courses;
    return Result.ok(_courses);
  }

  @override
  Future<Result<List<Chapter>>> getCourseChapters(String id) async {
    // Initialize the repository with a default booking
     List<Chapter> chapters = _localDataService.getCourseChapters(id);
    _chapters = chapters;
    return Result.ok(_chapters);
    // final chapters = _chapters;
    // return Result.ok([
    //   Chapter(id: "1", name: "Chapter CR 1", description: "Description 1", updated: DateTime.now(), lessons: [Lesson(id: "1", title: "title", text: "textaksdfhaksd")]),
    //   Chapter(id: "2", name: "Chapter CR 2", description: "Description 2", updated: DateTime.now()),
    //   Chapter(id: "3", name: "Chapter CR 3", description: "Description 3", updated: DateTime.now()),
    //   Chapter(id: "4", name: "Chapter CR 4", description: "Description 4", updated: DateTime.now()),
    // ]);
  }

  @override
  Future<Result<Lesson>> getLesson(String lessonId) async {
    Lesson lesson = Lesson(id: "1", title: "title", text: "textaksdfhaksd");
    // _courses = courses;
    // return Result.ok(_courses);
    return Result.ok(lesson);
  }

}