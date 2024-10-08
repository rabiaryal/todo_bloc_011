import 'package:flutter/material.dart';

class DisplayTasks extends StatelessWidget {
  final String taskName;
  final String? taskDescription; // Make taskDescription optional

  const DisplayTasks({
    super.key,
    required this.taskName,
    this.taskDescription, // Change to optional
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(taskName, style: const TextStyle(fontWeight: FontWeight.w600)),
        // Conditionally show the description only if it is not null
        if (taskDescription != null && taskDescription!.isNotEmpty)
          Text(taskDescription!,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
