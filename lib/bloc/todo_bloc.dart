import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist_011/bloc/todo_event.dart';
import 'package:todolist_011/model/datamodel.dart';


part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<AddEvent>(_addTasks);
    on<DeleteEvent>(_deleteTasks);
    on<AddSubTaskEvent>(_addSubTask);
    on<DeleteSubTaskEvent>(_deleteSubTask);
  }

  // Add task
  void _addTasks(AddEvent event, Emitter<TodoState> emit) {
    final updatedTasks = List<Task>.from(state.tasks)
      ..add(Task(
        title: event.title,
        description: event.description,
        subTasks: [], 
      ));

    emit(state.copyWith(tasks: updatedTasks));
  }


  void _deleteTasks(DeleteEvent event, Emitter<TodoState> emit) {
    final updatedTasks = List<Task>.from(state.tasks)..removeAt(event.index);

    emit(state.copyWith(tasks: updatedTasks));
  }

  
  void _addSubTask(AddSubTaskEvent event, Emitter<TodoState> emit) {
    final taskIndex = state.tasks.indexOf(event.task);
    if (taskIndex != -1) {
      final updatedTask = event.task.copyWith(
        subTasks: [...event.task.subTasks, event.subTask],
      );
      final updatedTasks = List<Task>.from(state.tasks)
        ..[taskIndex] = updatedTask; 
      emit(state.copyWith(tasks: updatedTasks));
    }
  }


  void _deleteSubTask(DeleteSubTaskEvent event, Emitter<TodoState> emit) {
    final taskIndex = state.tasks.indexOf(event.task);
    if (taskIndex != -1) {
      final updatedTask = event.task.copyWith(
        subTasks: List<String>.from(event.task.subTasks)
          ..removeAt(event.subTaskIndex), 
      );
      final updatedTasks = List<Task>.from(state.tasks)
        ..[taskIndex] = updatedTask; 
      emit(state.copyWith(tasks: updatedTasks));
    }
  }
}


