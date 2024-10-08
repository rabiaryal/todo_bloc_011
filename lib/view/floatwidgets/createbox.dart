import 'package:flutter/material.dart';
import 'package:todolist_011/managetasks.dart';
import 'package:todolist_011/model/datamodel.dart';
import 'subtaskpage.dart'; // Import SubTaskPage

class CreateNewUser extends StatefulWidget {
  final bool isSubTask; // Indicates if this is for a sub-task
  final void Function(String) onCreate; // Callback for when a new task/sub-task is created

  const CreateNewUser({
    Key? key,
    required this.isSubTask,
    required this.onCreate, // Accept the onCreate callback
  }) : super(key: key);

  @override
  _CreateNewUserState createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();

  bool addSubTasks = false;
  List<String> subTasks = [];

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isSubTask ? 'Create New Sub-Task' : 'Create New Task'), // Change title based on context
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskNameController,
              decoration: InputDecoration(hintText: 'Enter ${widget.isSubTask ? 'sub-task' : 'task'} name'), // Adjust hint text
            ),
            if (!widget.isSubTask) ...[ // Show description field only for tasks
              const SizedBox(height: 10),
              TextField(
                controller: _taskDescriptionController,
                decoration: const InputDecoration(hintText: 'Enter task description'),
              ),
            ],
            const SizedBox(height: 20),
            if (!widget.isSubTask) ...[ // Checkbox only for tasks
              Row(
                children: [
                  Checkbox(
                    value: addSubTasks,
                    onChanged: (bool? value) {
                      setState(() {
                        addSubTasks = value ?? false;
                        if (addSubTasks) {
                          _navigateToSubTaskPage(context); // Navigate to sub-task input page
                        }
                      });
                    },
                  ),
                  const Text('Add Sub-tasks'),
                ],
              ),
            ],
            if (subTasks.isNotEmpty) ...[
              const SizedBox(height: 10),
              Column(
                children: subTasks
                    .map((subTask) => Text(subTask, style: const TextStyle(fontSize: 16)))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (widget.isSubTask) {
              // If creating a sub-task, just pass back the task name
              Navigator.of(context).pop(_taskNameController.text);
              widget.onCreate(_taskNameController.text); // Call the onCreate callback with the task name
            } else {
              // Create the Task object with sub-tasks
              final task = Task(
                title: _taskNameController.text,
                description: _taskDescriptionController.text,
                subTasks: subTasks,
              );

              // Save the Task to Hive using TaskService
              await TaskService().addTask(task);

              // Close the dialog after saving
              Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }

  void _navigateToSubTaskPage(BuildContext context) async {
    // Navigate to SubTaskPage and wait for the result (list of sub-tasks)
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SubTaskPage(),
      ),
    );

    if (result != null && result is List<String>) {
      setState(() {
        subTasks = result; // Store the sub-tasks returned from SubTaskPage
      });
    }
  }
}
