// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:poliglotim/presentation/courses/view_model/courses_view_model.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Consumer<CoursesViewModel>(
//         builder: (context, viewModel, child) {
//           return SingleChildScrollView( // Добавил возможность прокрутки
//              child: Center(
//               // padding: EdgeInsets.all(36),
//               child: Wrap(
//                 spacing: 16.0, // Расстояние между карточками по горизонтали
//                 runSpacing: 16.0, // Расстояние между карточками по вертикали
//                 children: [
//                   for (var course in viewModel.courses)
//                     Card(
//                       elevation: 8,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       margin: EdgeInsets.zero, // Убрал margin, так как spacing в Wrap уже задает отступы
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0), // Уменьшил padding внутри карточки
//                         child: Column(
//                           // mainAxisSize: MainAxisSize.max, // Чтобы колонка занимала минимальное пространство
//                           children: [
//                             SvgPicture.asset(
//                               "assets/images/poliglotim_login.svg",
//                               height: 100,
//                               width: 100,
//                             ),
//                             const SizedBox(height: 8), // Добавил отступ между иконкой и текстом
//                             Text(
//                               course.name,
//                               style: Theme.of(context).textTheme.titleMedium, // Использовал стиль из темы
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 8), // Добавил отступ между текстом и кнопкой
//                             ElevatedButton(
//                               onPressed: () {viewModel.selectCourse(context);},
//                               child: const Text("Перейти"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//             ),
//              ),
//           );
//         },
//       ),
//     );
//   }
// }