import 'package:flutter/material.dart';
import 'package:todolist_011/managetasks.dart';
import 'package:todolist_011/model/datamodel.dart';
import 'package:todolist_011/view/displaybox/displaysubtasks.dart'; // Ensure the path is correct
import 'package:todolist_011/view/displaybox/widgets/deletebox.dart';
import 'package:todolist_011/view/displaybox/widgets/selectbox.dart';
import 'package:todolist_011/view/displaybox/widgets/tasks.dart';


class Displaybox extends StatefulWidget {
  final Task task;
  final int index; // Index of the task
  final TaskService taskService; // Instance of TaskService

  const Displaybox({
    super.key,
    required this.task,
    required this.index, // Accept index as a parameter
    required this.taskService, // Accept TaskService as a parameter
  });

  @override
  _DisplayboxState createState() => _DisplayboxState();
}

class _DisplayboxState extends State<Displaybox> {
  bool isChecked = false; // State for the checkbox

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to TaskDetailsPage instead of showing a dialog
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailsPage(
              mainTask: widget.task, // Pass the task to the page
              taskService: widget.taskService, // Pass the task service to the page
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 100,
        child: Card(
          elevation: 4,
          color: isChecked ? Colors.green : Colors.grey.shade300, // Change card color based on checkbox state
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: ListTile(
              leading: SelectBox(
                isChecked: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false; // Update checkbox state
                  });
                },
              ),
              title: DisplayTasks(taskName: widget.task.title, taskDescription: widget.task.description),
              trailing: Deletebox(
                onDelete: () async {
                  // Handle deletion here
                  await widget.taskService.deleteTask(widget.index); // Call deleteTask from TaskService
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task deleted')), // Optionally show a snackbar
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
