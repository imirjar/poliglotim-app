import 'package:flutter/material.dart';


class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Основной цвет фона для всего приложения
      scaffoldBackgroundColor:  Colors.white,
      
      // Градиентный фон можно задать через decoration, но это сложнее
      // Лучше использовать единый цвет, а градиенты делать индивидуально
      
      // Другие глобальные настройки темы
      // appBarTheme: const AppBarTheme(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),

      // Общие стили для текстовых полей
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),

        labelStyle: const TextStyle(color: Colors.white),
      ),
      
      // Другие глобальные настройки...
    );
  }
}