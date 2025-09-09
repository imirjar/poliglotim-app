import 'package:poliglotim/domain/models/chapter.dart';
import 'package:poliglotim/domain/models/course.dart';
import 'package:poliglotim/domain/models/lesson.dart';


class LocalCourseDataService {
  List<Course> getCourses() {
    return [
      Course(
        id: '1',
        name: 'Английский язык',
        description: "asdfasdf",
        updated: DateTime.now()
      ),
     Course(
        id: '2',
        name: 'Английский язык',
        description: "asdfasdf",
        updated: DateTime.now()
      ),
      Course(
        id: '3',
        name: 'Шумерский язык',
        description: "asdfasdf",
        updated: DateTime.now()
      ),
      Course(
        id: '4',
        name: 'Китайский язык>',
        description: "asdfasdf",
        updated: DateTime.now()
      ),
    ];
  }

  List<Chapter> getCourseChapters(String id) {
    return [
      Chapter(
        id: '1',
        name: 'Глава 1',
        description: "asdfasdf",
        updated: DateTime.now(),
        lessons: [
          Lesson(
            id: id, 
            title: "Урок 1", 
            text: "text"
          ),
          Lesson(
            id: id, 
            title: "Урок 2", 
            text: "text"
          ),
          Lesson(
            id: id, 
            title: "Урок 3", 
            text: "text"
          ),
        ]
      ),
      Chapter(
        id: '2',
        name: 'Английский язык',
        description: "asdfasdf",
        updated: DateTime.now(),
        lessons: [
          Lesson(
            id: id, 
            title: "Урок 1", 
            text: "text"
          ),
          Lesson(
            id: id, 
            title: "Урок 2", 
            text: "text"
          ),
          Lesson(
            id: id, 
            title: "Урок 3", 
            text: "text"
          ),
        ]
        
      ),
      Chapter(
        id: '3',
        name: 'Шумерский язык',
        description: "asdfasdf",
        updated: DateTime.now(),
        lessons: [
          Lesson(
            id: id, 
            title: "Урок 1", 
            text: "text"
          ),
          Lesson(
            id: id, 
            title: "Урок 2", 
            text: "text"
          ),
          Lesson(
            id: id, 
            title: "Урок 3", 
            text: "text"
          ),
        ]
      ),
      Chapter(
        id: '4',
        name: 'Китайский язык>',
        description: "asdfasdf",
        updated: DateTime.now(),
        lessons: [
          Lesson(
            id: id, 
            title: "Урок 1", 
            text: "text"
          ),
          Lesson(
            id: id, 
            title: "Урок 2", 
            text: "text"
          ),
          Lesson(
            id: id, 
            title: "Урок 3", 
            text: "text"
          ),
        ]
      ),
    ];
  }

  Lesson getLessonText(String lessonId) {
    return Lesson(
      id: lessonId, 
      title: "Урок 1", 
      text: "text"
    );
  }

}