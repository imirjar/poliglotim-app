// lib/widgets/navigation_bar.dart
import 'package:flutter/material.dart';

class TaskNavigationBar extends StatelessWidget {
  final Function(int) onTaskChanged;
  final int currentIndex;
  final int totalTasks;

  TaskNavigationBar({
    required this.onTaskChanged,
    required this.currentIndex,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: currentIndex > 0
                ? () => onTaskChanged(currentIndex - 1)
                : null,
          ),
          Text("Задание ${currentIndex + 1} из $totalTasks"),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: currentIndex < totalTasks - 1
                ? () => onTaskChanged(currentIndex + 1)
                : null,
          ),
        ],
      ),
    );
  }
}