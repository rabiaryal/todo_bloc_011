import 'package:flutter/material.dart';
import 'package:todolist_011/managetasks.dart';
import 'package:todolist_011/model/datamodel.dart';
import 'package:todolist_011/utils/snackbar.dart';
import 'package:todolist_011/view/displaybox/subtaskscard.dart';

import 'package:todolist_011/view/floatwidgets/floatingbutton.dart'; 

class TaskDetailsPage extends StatefulWidget {
  final Task mainTask;
  final TaskService taskService;

  const TaskDetailsPage({
    Key? key,
    required this.mainTask,
    required this.taskService,
  }) : super(key: key);

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late List<bool> subTaskChecked;

  @override
  void initState() {
    super.initState();
    subTaskChecked =
        List<bool>.filled(widget.mainTask.subTasks?.length ?? 0, false);
  }

  void _addSubTask(String taskName) {
    setState(() {
      widget.mainTask.subTasks!.add(taskName);
      subTaskChecked.add(false); // Add a new unchecked state for the sub-task
    });
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
            Text(widget.mainTask.description, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            if (widget.mainTask.subTasks != null &&
                widget.mainTask.subTasks!.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: widget.mainTask.subTasks!.length,
                  itemBuilder: (context, index) {
                    return SubTaskCard(
                      taskName: widget.mainTask.subTasks![index],
                      taskDescription: "", // Customize as needed
                      isChecked: subTaskChecked[index],
                      onCheckboxChanged: (bool? value) {
                        setState(() {
                          subTaskChecked[index] = value ?? false;
                        });
                      },
                      onDelete: () async {
                        // Confirm deletion of the sub-task
                        final confirmDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Deletion'),
                            content: const Text(
                                'Are you sure you want to delete this sub-task?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false), // Cancel
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true), // Delete
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );

                        // Proceed to delete if confirmed
                        if (confirmDelete == true) {
                          await widget.taskService
                              .deleteSubTask(widget.mainTask.title, index);

                          Utils.showSnackbar(context, 'Sub-task deleted');
                        
                          setState(() {
                            widget.mainTask.subTasks!.removeAt(index);
                            subTaskChecked.removeAt(index);
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ] else ...[
              const Text(
                  'No sub-tasks available'), // Message when no sub-tasks exist
            ],
          ],
        ),
      ),
      floatingActionButton: MyFloatingButton(
        onCreate: (taskName) {
          _addSubTask(taskName);
           Utils.showSnackbar(context, 'Sub-task "$taskName" added');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sub-task "$taskName" added')),
          );
        },
        isSubTask: true, 
      ),
    );
  }
}
