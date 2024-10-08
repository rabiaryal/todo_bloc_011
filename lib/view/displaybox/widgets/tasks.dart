import 'package:flutter/material.dart';

class DisplayTasks extends StatelessWidget {
  final String taskName;
  final String? taskDescription; 

  const DisplayTasks({
    super.key,
    required this.taskName,
    this.taskDescription, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(taskName, style: const TextStyle(fontWeight: FontWeight.w600)),
        
        if (taskDescription != null && taskDescription!.isNotEmpty)
          Text(taskDescription!,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
