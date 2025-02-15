// lib/widgets/match_task.dart
import 'package:flutter/material.dart';

class MatchTask extends StatelessWidget {
  final Map<String, dynamic> data;

  const MatchTask({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Соотнесите столбцы:", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          for (final column in data["columns"])
            Text("${column["left"]} - ${column["right"]}"),
        ],
      ),
    );
  }
}