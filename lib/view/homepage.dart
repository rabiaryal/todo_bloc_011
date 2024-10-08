import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_011/bloc/todo_bloc.dart';
import 'package:todolist_011/bloc/todo_event.dart';
import 'package:todolist_011/model/datamodel.dart';
import 'package:todolist_011/view/displaybox/displaybox.dart';
import 'package:todolist_011/view/floatwidgets/floatingbutton.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void _createTask(String taskName) {
    final taskTitle = taskName;
    final taskDescription = ''; // Assuming no description for now

    // Create a new Task object
    final newTask = Task(
      title: taskTitle,
      description: taskDescription,
      subTasks: [], // Initialize with an empty list of sub-tasks
    );

    // Dispatch event to BLoC for adding a new task
    context.read<TodoBloc>().add(AddEvent(
      newTask,
      title: taskTitle,
      description: taskDescription,
    ));

    // Feedback on task addition
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task "$taskTitle" added')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current state of the BLoC
    final state = context.watch<TodoBloc>().state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade500,
        centerTitle: true,
        title: const Text("To Do"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: state.tasks.isEmpty
            ? const Center(child: Text('No tasks available'))
            : ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  return Displaybox(
                    task: state.tasks[index],
                    index: index,
                    // Remove taskService if it's not defined in your Displaybox widget
                    // If needed, define how to get the task service or simply omit this parameter
                  );
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyFloatingButton(
        onCreate: (taskName) {
          _createTask(taskName);
        },
        isSubTask: false,
      ),
    );
  }
}
