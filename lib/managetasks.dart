import 'package:hive/hive.dart';
import 'package:todolist_011/model/datamodel.dart';
// Import the Task model

class TaskService {
  // Open the box
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  // Save a new task
  Future<void> addTask(Task task) async {
    await _taskBox.add(task); // Adds a new task to the Hive box
  }

  // Update an existing task
  Future<void> updateTask(int index, Task task) async {
    await _taskBox.putAt(index, task); // Updates the task at the given index
  }

  // Delete a task
  Future<void> deleteTask(int index) async {
    await _taskBox.deleteAt(index); // Deletes the task at the given index
  }


// Delete a sub-task from a main task
Future<void> deleteSubTask(String mainTaskTitle, int subTaskIndex) async {
  List<Task> tasks = _taskBox.values.toList();
  // Find the task by title
  Task mainTask = tasks.firstWhere(
    (task) => task.title == mainTaskTitle,
    orElse: () {
      throw Exception('Task not found'); // Throw exception if task not found
    },
  );

  if (mainTask.subTasks != null && subTaskIndex < mainTask.subTasks!.length) {
    // Remove the sub-task from the list
    mainTask.subTasks!.removeAt(subTaskIndex);
    await updateTask(tasks.indexOf(mainTask), mainTask); // Update the task in the box
  } else {
    throw Exception('Sub-task index out of bounds'); // Optional: handle index out of bounds
  }
}

  List<Task> getTasks() {
    return _taskBox.values.toList(); // Returns all tasks
  }
}
