import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../injection_container.dart';
import '../../viewmodels/course_viewmodel.dart';
import '../../../domain/repositories/course_repo.dart';


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _isMenuOpen = false;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      
      body: Stack(
        children: [
          _buildMainContent(),
          if (_isMenuOpen) _buildNavigationDrawer(),
        ],
      ),
      appBar: AppBar(
      // backgroundColor: const Color(0xFFE0E5EC),
      elevation: 2,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color:  Color(0xFFE0E5EC),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset:  Offset(-4, -4),
                blurRadius: 10,
              ),
              BoxShadow(
                color:  Color.fromARGB(255, 47, 45, 45),
                offset:  Offset(4, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Icon(
            Icons.menu,
            color: Color(0xFF6D7587),
          ),
        ),
        onPressed: () {
          setState(() {
            _isMenuOpen = !_isMenuOpen;
          });
        },
      ),
      title: Container(
        padding: EdgeInsets.all(10),
        
        color:const Color(0xFFE0E5EC),
      ),
      // Text(
      //   'Мои курсы',
      //   style: TextStyle(
      //     color: Colors.grey.shade700,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      centerTitle: true,
    ),
    
    );
  }

 
  Widget _buildNavigationDrawer() {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE0E5EC),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(5, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),
            _buildMenuButton(Icons.home, 'Главная'),
            _buildMenuButton(Icons.book, 'Мои курсы'),
            _buildMenuButton(Icons.settings, 'Настройки'),
            _buildMenuButton(Icons.exit_to_app, 'Выйти'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE0E5EC),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: const Offset(-4, -4),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(4, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.grey.shade700),
          title: Text(
            text,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          onTap: () {
            setState(() => _isMenuOpen = false);
            // Добавьте навигацию здесь
          },
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      padding: const EdgeInsets.only(top: kToolbarHeight + 20),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _buildNeomorphicCourseCard(),
          );
        },
      ),
    );
  }

  Widget _buildNeomorphicCourseCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(-6, -6),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(6, 6),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Название курса ${DateTime.now().millisecondsSinceEpoch % 100}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Описание курса',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}