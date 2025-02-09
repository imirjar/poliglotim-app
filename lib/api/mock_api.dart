import 'package:poliglotim/models/lesson.dart';
import 'package:poliglotim/models/task.dart';

class MockApi {
  Future<List<Lesson>> getLessons() async {
    await Future.delayed(Duration(seconds: 2)); // Имитация задержки сети
    return [
      Lesson(
        id: "1",
        title: "Введение",
        tasks: [
          Task(
            id: "1",
            type: "video",
            data: "https://www.youtube.com/watch?v=XC9JPRyON9U", // Ссылка на видео
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
        ],
      ),
      Lesson(
        id: "2",
        title: "Ключи",
        tasks: [
          Task(
            id: "1",
            type: "video",
            data: "https://www.youtube.com/watch?v=XC9JPRyON9U", // Ссылка на видео
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
        ],
      ),
      // Добавь больше уроков по необходимости
    ];
  }
}