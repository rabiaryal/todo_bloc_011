import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist_011/managetasks.dart';
import 'package:todolist_011/model/datamodel.dart';
import 'package:todolist_011/view/displaybox/displaybox.dart';
import 'package:todolist_011/view/floatwidgets/createbox.dart';
import 'package:todolist_011/view/floatwidgets/floatingbutton.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TaskService taskService = TaskService();

  // Method to handle task creation
  void _createTask(String taskName) {
    
    final newTask = Task(title: taskName, description: "", subTasks: []); // Create a new task object
    taskService.addTask(newTask);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task "$taskName" added')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade500,
        centerTitle: true,
        title: const Text("To Do"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Task>('tasks').listenable(),
          builder: (context, Box<Task> box, _) {
            if (box.isEmpty) {
              return const Center(child: Text('No tasks available'));
            } else {
              final tasks = box.values.toList();
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Displaybox(
                    task: tasks[index],
                    index: index,
                    taskService: taskService, // Pass the TaskService instance
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyFloatingButton(
        onCreate: (taskName) {
          _createTask(taskName); // Call method to create a new task
        },
        isSubTask: false, // Set to false since we're creating a main task
      ),
    );
  }
}
