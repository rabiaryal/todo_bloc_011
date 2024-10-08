import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_011/bloc/todo_bloc.dart'; // Import your BLoC
import 'package:todolist_011/bloc/todo_event.dart'; // Import your TodoEvent
import 'package:todolist_011/model/datamodel.dart';
import 'subtaskpage.dart';

class CreateNewUser extends StatefulWidget {
  final bool isSubTask;
  final void Function(String) onCreate;

  const CreateNewUser({
    Key? key,
    required this.isSubTask,
    required this.onCreate,
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

  void _createTask() {
    final taskTitle = _taskNameController.text;
    final taskDescription = _taskDescriptionController.text;

    // Dispatch AddEvent for task
    final newTask = Task(
      title: taskTitle,
      description: taskDescription,
    );

    context.read<TodoBloc>().add(AddEvent(
      newTask, // Pass the new Task object
      title: taskTitle,
      description: taskDescription,
    ));

    // Handle sub-tasks creation
    if (addSubTasks) {
      for (String subTask in subTasks) {
        context.read<TodoBloc>().add(AddSubTaskEvent(
          subTask, // Pass the sub-task string
          newTask, // Pass the parent Task object
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isSubTask ? 'Create New Sub-Task' : 'Create New Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskNameController,
              decoration: InputDecoration(hintText: 'Enter ${widget.isSubTask ? 'sub-task' : 'task'} name'),
            ),
            if (!widget.isSubTask) ...[
              const SizedBox(height: 10),
              TextField(
                controller: _taskDescriptionController,
                decoration: const InputDecoration(hintText: 'Enter task description'),
              ),
            ],
            const SizedBox(height: 20),
            if (!widget.isSubTask) ...[
              Row(
                children: [
                  Checkbox(
                    value: addSubTasks,
                    onChanged: (bool? value) {
                      setState(() {
                        addSubTasks = value ?? false;
                        if (addSubTasks) {
                          _navigateToSubTaskPage(context);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subTasks.map((subTask) => Text(subTask, style: const TextStyle(fontSize: 16))).toList(),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (widget.isSubTask) {
              widget.onCreate(_taskNameController.text); // Sub-task callback
            } else {
              _createTask(); // Call method to create task
            }
            Navigator.of(context).pop();
          },
          child: const Text('Create'),
        ),
      ],
    );
  }

  void _navigateToSubTaskPage(BuildContext context) async {
    final result = await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(builder: (context) => const SubTaskPage()),
    );

    if (result != null) {
      setState(() {
        subTasks = result;
      });
    }
  }
}
