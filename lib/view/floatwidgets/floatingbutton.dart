import 'package:flutter/material.dart';
import 'package:todolist_011/view/floatwidgets/createbox.dart';

class MyFloatingButton extends StatelessWidget {
  final void Function(String taskName) onCreate; // Callback to handle task creation
  final bool isSubTask; // Flag to determine if it's a sub-task

  const MyFloatingButton({
    Key? key,
    required this.onCreate,
    required this.isSubTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.yellow.shade700,
      foregroundColor: Colors.black,
      tooltip: 'Add Item',
      onPressed: () {
        _showCreateNewUserDialog(context); // Show the create dialog
      },
      label: const Text("Add Task"),
      icon: const Icon(Icons.add),
    );
  }

  void _showCreateNewUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateNewUser(
          isSubTask: isSubTask, // Pass the flag to CreateNewUser
          onCreate: (taskName) {
            // Handle task creation callback
            Navigator.of(context).pop(); // Close the dialog
            onCreate(taskName); // Call the provided onCreate callback
          },
        );
      },
    );
  }
}
