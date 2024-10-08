import 'package:hive/hive.dart';
import 'package:todolist_011/model/datamodel.dart';

class TaskService {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  Future<void> addTask(Task task) async {
    await _taskBox.add(task); // Adds a new task to Hive
  }

  Future<void> updateTask(int index, Task task) async {
    await _taskBox.putAt(index, task); // Updates task in Hive
  }

  Future<void> deleteTask(int index) async {
    await _taskBox.deleteAt(index); // Deletes task from Hive
  }

  Future<void> deleteSubTask(String mainTaskTitle, int subTaskIndex) async {
    List<Task> tasks = _taskBox.values.toList();
    Task mainTask = tasks.firstWhere(
      (task) => task.title == mainTaskTitle,
      orElse: () => throw Exception('Task not found'),
    );

    if (mainTask.subTasks != null && subTaskIndex < mainTask.subTasks!.length) {
      mainTask.subTasks!.removeAt(subTaskIndex); // Remove sub-task
      await updateTask(tasks.indexOf(mainTask), mainTask);
    } else {
      throw Exception('Sub-task index out of bounds');
    }
  }

  List<Task> getTasks() {
    return _taskBox.values.toList();
  }
}
