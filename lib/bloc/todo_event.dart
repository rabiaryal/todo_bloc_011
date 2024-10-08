import 'package:equatable/equatable.dart';
import 'package:todolist_011/model/datamodel.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class AddEvent extends TodoEvent {
  final String title;
  final String description;

  const AddEvent(Task newTask, {
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

class DeleteEvent extends TodoEvent {
  final int index;

  const DeleteEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class AddSubTaskEvent extends TodoEvent {
  final String subTask;
  final Task task;

  const AddSubTaskEvent(this.subTask, this.task);

  @override
  List<Object?> get props => [subTask, task];
}

class DeleteSubTaskEvent extends TodoEvent {
  final int subTaskIndex;
  final Task task;

  const DeleteSubTaskEvent(this.subTaskIndex, this.task);

  @override
  List<Object?> get props => [subTaskIndex, task];
}
