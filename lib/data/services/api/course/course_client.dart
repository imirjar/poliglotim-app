// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:poliglotim/domain/models/chapter.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/domain/models/lesson.dart';
import 'package:poliglotim/domain/models/user.dart';

import '../../../../utils/result.dart';


/// Adds the `Authentication` header to a header configuration.
typedef AuthHeaderProvider = String? Function();

class CourseClient {
  CourseClient({String? host, int? port, HttpClient Function()? clientFactory})
    : _host = host ?? 'api.poliglotim.ru',
      _port = port ?? 80,
      _clientFactory = clientFactory ?? HttpClient.new;

  final String _host;
  final int _port;
  final HttpClient Function() _clientFactory;

  AuthHeaderProvider? _authHeaderProvider;

  set authHeaderProvider(AuthHeaderProvider authHeaderProvider) {
    _authHeaderProvider = authHeaderProvider;
  }

  Future<void> _authHeader(HttpHeaders headers) async {
    final header = _authHeaderProvider?.call();
    if (header != null) {
      headers.add(HttpHeaders.authorizationHeader, header);
    }
  }

  Future<Result<List<Course>>> getCourses() async {
    final client = _clientFactory();
    try {
      final request = await client.get(_host, _port, '/courses');
      await _authHeader(request.headers);
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Result.ok(
          json.map((element) => Course.fromJson(element)).toList(),
        );
      } else {
        return const Result.error(HttpException("Invalid response"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }

  Future<Result<List<Chapter>>> getCourseChapters(String ip) async {
    final client = _clientFactory();
    try {
      final request = await client.get(_host, _port, '/chapters/$ip');
      await _authHeader(request.headers);
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Result.ok(
          json.map((element) => Chapter.fromJson(element)).toList(),
        );
      } else {
        return const Result.error(HttpException("Invalid response"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }

  Future<Result<Lesson>> getLesson(String ip) async {
    final client = _clientFactory();
    try {
      final request = await client.get(_host, _port, '/lesson/$ip');
      await _authHeader(request.headers);
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final user = Lesson.fromJson(jsonDecode(stringData));
        return Result.ok(user);
      } else {
        return const Result.error(HttpException("Invalid response"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }

  Future<Result<User>> getUser() async {
    final client = _clientFactory();
    try {
      final request = await client.get(_host, _port, '/user');
      await _authHeader(request.headers);
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final user = User.fromJson(jsonDecode(stringData));
        return Result.ok(user);
      } else {
        return const Result.error(HttpException("Invalid response"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }

 
}