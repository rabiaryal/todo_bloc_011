import 'package:hive/hive.dart';

part 'datamodel.g.dart'; // Generated file

@HiveType(typeId: 0) // Define the type ID for the Task model
class Task extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final bool isCompleted;

  @HiveField(3)
  final List<String> subTasks; // Change to a non-nullable list

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
    List<String>? subTasks, // Optional parameter
  }) : subTasks = subTasks ?? []; // Initialize to an empty list if null
}
