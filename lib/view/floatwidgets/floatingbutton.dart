import 'package:flutter/material.dart';
import 'package:todolist_011/view/floatwidgets/createbox.dart';

class MyFloatingButton extends StatelessWidget {
  final void Function(String taskName) onCreate;
  final bool isSubTask;

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
        _showCreateNewUserDialog(context);
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
          isSubTask: isSubTask,
          onCreate: (taskName) {
            Navigator.of(context).pop(); // Close the dialog
            onCreate(taskName); // Call the onCreate callback
          },
        );
      },
    );
  }
}
