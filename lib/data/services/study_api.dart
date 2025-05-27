import 'package:poliglotim/domain/entities/response.dart';
import 'package:poliglotim/domain/models/lesson.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/domain/models/task.dart';

class StudyApi {

  Future<Result<List<Course>>> getCourses() async {
    await Future.delayed(const Duration(seconds: 1)); // Имитация задержки сети
     // Создаем список курсов
    final courses = [
      Course(
        id: "1",
        name: "Китайский язык",
      ),
      Course(
        id: "2",
        name: "Английский язык",
      ),
      Course(
        id: "3",
        name: "Французский язык",
      ),
      
    ];
    // print("StudyApi $courses");
    return Result.ok(courses);
  }

  Future<Result<List<Lesson>>> getCourseLessons(int courseID) async {
    await Future.delayed(const Duration(seconds: 2)); // Имитация задержки сети
    final lessons = [
      Lesson(
        id: "1",
        title: "Введение",
      ),
      Lesson(
        id: "2",
        title: "Ключи",
      ),
      // Добавь больше уроков по необходимости
    ];
    return Result.ok(lessons);
  }

  Future<Result<List<Task>>> getTasks(int courseID, int lessonID) async {
    await Future.delayed(const Duration(seconds: 1)); // Имитация задержки сети
     // Создаем список курсов
    final tasks= [
          Task(
            id: "1",
            type: "video",
            data: "assets/videos/bee.mp4", // Ссылка на видео
          ),
          Task(
            id: "2",
            type: "fill",
            data: {
              "text": "Китайский язык — это ______ и ______ язык.",
              "answers": ["красивый", "сложный"],
            },
          ),
          Task(
            id: "3",
            type: "match",
            data: {
              "columns": [
                {"left": "你好", "right": "Привет"},
                {"left": "谢谢", "right": "Спасибо"},
              ],
            },
          ),
          Task(
            id: "4",
            type: "match",
            data: {
              "columns": [
                {"left": "你好", "right": "Привет"},
                {"left": "谢谢", "right": "Спасибо"},
              ],
            },
          )
        ];
    // print("StudyApi $courses");
    return Result.ok(tasks);
  }
}