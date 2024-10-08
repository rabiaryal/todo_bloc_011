import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:todolist_011/bloc/todo_bloc.dart'; 
import 'package:todolist_011/bloc/todo_event.dart';
import 'package:todolist_011/model/datamodel.dart';
import 'package:todolist_011/utils/snackbar.dart';
import 'package:todolist_011/view/floatwidgets/floatingbutton.dart';
import 'package:todolist_011/view/displaybox/subtaskscard.dart';

class TaskDetailsPage extends StatefulWidget {
  final Task mainTask;

  const TaskDetailsPage({
    Key? key,
    required this.mainTask,
  }) : super(key: key);

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late List<bool> subTaskChecked;

  @override
  void initState() {
    super.initState();
    subTaskChecked = List<bool>.filled(widget.mainTask.subTasks.length, false);
  }

  void _addSubTask(String subTaskName) {
    context.read<TodoBloc>().add(AddSubTaskEvent(subTaskName, widget.mainTask));
    Utils.showSnackbar(context, 'Sub-task "$subTaskName" added');
    setState(() {
      subTaskChecked.add(false);
    });
  }

  void _deleteSubTask(int index) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this sub-task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      context.read<TodoBloc>().add(DeleteSubTaskEvent(index, widget.mainTask));
      Utils.showSnackbar(context, 'Sub-task deleted');
      setState(() {
        subTaskChecked.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mainTask.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.mainTask.description, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            Expanded(
              child: widget.mainTask.subTasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: widget.mainTask.subTasks.length,
                      itemBuilder: (context, index) {
                        return SubTaskCard(
                          taskName: widget.mainTask.subTasks[index],
                          taskDescription: "", // Customize as needed
                          isChecked: subTaskChecked[index],
                          onCheckboxChanged: (bool? value) {
                            setState(() {
                              subTaskChecked[index] = value ?? false;
                            });
                          },
                          onDelete: () => _deleteSubTask(index),
                        );
                      },
                    )
                  : const Center(child: Text('No sub-tasks available')),
            ),
          ],
        ),
      ),
      floatingActionButton: MyFloatingButton(
        onCreate: (taskName) {
          _addSubTask(taskName);
        },
        isSubTask: true, // Denotes creation of sub-tasks
      ),
    );
  }
}
