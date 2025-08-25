Курс китайского языка на Flutter

This app contains multiple environments.

* Development environment - This environment uses data from a JSON file, which is stored in the `assets` directory, and simulates developing locally.

```bash 
$ cd app
$ flutter run --target lib/main_development.dart
```

* Staging environment - This environment uses an HTTP server to get data, simulating a real app experience. This is a "dummy" server, that has endpoints that simply return fake data. The server can be found in the `compass_app/server` directory. You need to run the server locally before running the Flutter application.

```bash
$ cd server
$ dart run
# => Server listening on port 8080
 
$ cd ../compass_app/app
$ flutter run --target lib/main_staging.dart 
```

## Integration Tests

Integration tests must be run from the `app` directory.

**Integration tests with local data**

```bash
cd app
$ flutter test integration_test/app_local_data_test.dart
```

**Integration tests with background server and remote data**

```bash
cd app
$ flutter test integration_test/app_server_data_test.dart
```

Это приложение для изучения китайского языка, созданное с использованием Flutter. Оно включает в себя уроки с заданиями разных типов, систему авторизации и сохранение прогресса пользователя.
Основные функции

    Уроки и задания:

        Уроки содержат задания разных типов: просмотр видео, заполнение пропусков в тексте и сопоставление столбцов.

        Пользователь может переходить между заданиями в рамках одного урока.

    Прогресс пользователя:

        Прогресс выполнения заданий и уроков сохраняется локально с использованием SharedPreferences.

        Пользователь видит, какие уроки и задания он уже завершил.

    Блокировка уроков:

        Уроки блокируются, пока пользователь не завершит предыдущий урок.

        Заблокированные уроки отображаются серым цветом и недоступны для выбора.

    Mock авторизация:

        Реализована mock авторизация через API. Пользователь может "войти" с любыми данными, но успешная авторизация происходит только с логином user и паролем password.

    Навигация:

        Боковое меню (Drawer) для перехода между уроками.

        Навигационная панель для перехода между заданиями в рамках урока.

Структура проекта
Папки и файлы

    lib/:

        api/:

            auth_api.dart: Mock API для авторизации.

            mock_api.dart: Mock API для загрузки уроков и заданий.

        models/:

            lesson.dart: Модель урока.

            task.dart: Модель задания.

        screens/:

            login_screen.dart: Экран авторизации.

            home_screen.dart: Главный экран с уроками и заданиями.

        services/:

            progress_manager.dart: Управление прогрессом пользователя.

        widgets/:

            video_task.dart: Виджет для задания с видео.

            fill_task.dart: Виджет для задания с заполнением пропусков.

            match_task.dart: Виджет для задания с сопоставлением столбцов.

            task_navigation_bar.dart: Навигационная панель для заданий.

        main.dart: Точка входа в приложение.

Как работает приложение
1. Авторизация

Пользователь вводит логин и пароль на экране авторизации. Если введены данные user и password, происходит успешная авторизация, и пользователь переходит на главный экран.
2. Главный экран

На главном экране отображается список уроков в боковом меню (Drawer). Уроки могут быть:

    Доступные (черный цвет): Уроки, которые можно начать.

    Пройденные (зеленый цвет): Уроки, которые пользователь уже завершил.

    Заблокированные (серый цвет): Уроки, которые недоступны, пока не завершен предыдущий урок.

3. Задания

Каждый урок содержит несколько заданий. Типы заданий:

    Видео: Просмотр обучающего видео.

    Заполнение пропусков: Пользователь видит текст с пропущенными словами.

    Сопоставление столбцов: Пользователь сопоставляет элементы из двух столбцов.

4. Прогресс

    После завершения задания пользователь нажимает кнопку "Задание пройдено".

    Если это последнее задание в уроке, урок отмечается как пройденный, и следующий урок разблокируется.

    Прогресс сохраняется локально и не сбрасывается после перезапуска приложения.

Установка и запуск
1. Установите Flutter

Если у вас еще не установлен Flutter, следуйте официальной документации: flutter.dev.
2. Клонируйте репозиторий
bash
Copy

git clone https://github.com/ваш-репозиторий.git
cd ваш-репозиторий

3. Установите зависимости
bash
Copy

flutter pub get

4. Запустите приложение
bash
Copy

flutter run

Зависимости

    video_player: Для воспроизведения видео в заданиях.

    shared_preferences: Для сохранения прогресса пользователя.

Как добавить новый урок или задание
1. Добавьте урок в Mock API

Откройте lib/api/mock_api.dart и добавьте новый урок в список:
dart
Copy

Lesson(
  id: "2",
  title: "Новый урок",
  tasks: [
    Task(
      id: "1",
      type: "video",
      data: "https://www.example.com/video.mp4",
    ),
    Task(
      id: "2",
      type: "fill",
      data: {
        "text": "Новый текст с пропусками ______.",
        "answers": ["ответ"],
      },
    ),
  ],
),

2. Добавьте новый тип задания (если нужно)

Если нужно добавить новый тип задания, создайте новый виджет в папке lib/widgets/ и добавьте обработку в home_screen.dart.
Возможные улучшения

    Реальное API:

        Заменить mock API на реальное, чтобы данные загружались с сервера.

    Синхронизация прогресса:

        Сохранять прогресс пользователя на сервере.

    Улучшение UI/UX:

        Добавить анимации, улучшить дизайн.

    Тестирование:

        Написать unit- и widget-тесты.

Автор

[Imirjar](https://github.com/imirjar)

Если у вас есть вопросы или предложения, создайте issue в репозитории или свяжитесь со мной.
