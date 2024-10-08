part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Task> tasks;
  const TodoState({this.tasks = const []});

  TodoState copyWith({List<Task>? tasks}) {
    return TodoState(tasks: tasks ?? this.tasks);
  }

  @override
  List<Object?> get props => [tasks];
}