import 'package:hive/hive.dart';

part 'datamodel.g.dart'; // Generated file

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final bool isCompleted;

  @HiveField(3)
  final List<String> subTasks;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
    List<String>? subTasks,
  }) : subTasks = subTasks ?? [];

  
  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    List<String>? subTasks,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      subTasks: subTasks ?? this.subTasks,
    );
  }
}
