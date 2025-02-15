// lib/widgets/fill_task.dart
import 'package:flutter/material.dart';

class FillTask extends StatelessWidget {
  final Map<String, dynamic> data;

  const FillTask({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Заполните пропуски:", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          Text(data["text"]),
          const SizedBox(height: 20),
          Text("Ответы: ${data["answers"].join(", ")}"),
        ],
      ),
    );
  }
}