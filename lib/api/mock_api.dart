import 'package:poliglotim/models/lesson.dart';
import 'package:poliglotim/models/task.dart';

class MockApi {
  Future<List<Lesson>> getLessons() async {
    await Future.delayed(const Duration(seconds: 2)); // Имитация задержки сети
    return [
      Lesson(
        id: "1",
        title: "Введение",
        tasks: [
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
        ],
      ),
      Lesson(
        id: "2",
        title: "Ключи",
        tasks: [
          Task(
            id: "5",
            type: "video",
            data: "assets/videos/bunny.mp4", // Ссылка на видео
          ),
          Task(
            id: "6",
            type: "fill",
            data: {
              "text": "Ключи бывают ______ и ______ .",
              "answers": ["простые", "составные"],
            },
          ),
          Task(
            id: "7",
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