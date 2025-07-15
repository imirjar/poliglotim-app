import 'package:flutter/material.dart';

import 'package:poliglotim/presentation/viewmodels/course_viewmodel.dart';
import 'package:poliglotim/presentation/views/ui/neomorph_container.dart';

import 'package:poliglotim/domain/models/chapter.dart';
import 'package:provider/provider.dart';

class ChapterMenu extends StatelessWidget {
  const ChapterMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseViewModel>(
      builder: (context, viewModel, _) {
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: viewModel.isMenuExpanded ? 280 : 82,
          child: NeumorphicContainer(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                _buildMenuHeader(context, viewModel),
                Expanded(child: _buildChaptersList(viewModel)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuHeader(BuildContext context, CourseViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          IconButton(
            icon: Icon(viewModel.isMenuExpanded ? Icons.menu_open : Icons.menu),
            onPressed: viewModel.toggleMenu,
          ),
          if (viewModel.isMenuExpanded) ...[
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/courses');
              },
            ),
          ],
        ],
      ),
    );
  }

  // 
  Widget _buildChaptersList(CourseViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: viewModel.chapters.length,
      itemBuilder: (context, index) {
        final chapter = viewModel.chapters[index];
        return _buildChapterItem(chapter, index, viewModel);
      },
    );
  }


  // MENU ITEM
  Widget _buildChapterItem(Chapter chapter, int index, CourseViewModel viewModel) {
  final isSelected = viewModel.selectedChapterId == chapter.id;
  
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: viewModel.isMenuExpanded ? Container(
      // borderRadius: BorderRadius.circular(12),
      // intensity: isSelected ? 0.6 : 0.3,
      child: ListTile(
        
        title: Text(
          chapter.name.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.blueAccent : Colors.grey.shade700,
          ),
        ),
        selected: isSelected,
        onTap: () => viewModel.selectChapter(chapter.id),
      ),
    ) : null,
  );
}
}