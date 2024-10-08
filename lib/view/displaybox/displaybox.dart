import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:todolist_011/bloc/todo_bloc.dart'; 
import 'package:todolist_011/bloc/todo_event.dart';
import 'package:todolist_011/model/datamodel.dart';
import 'package:todolist_011/utils/snackbar.dart';
import 'package:todolist_011/view/displaybox/displaysubtasks.dart';
import 'package:todolist_011/view/displaybox/widgets/deletebox.dart';
import 'package:todolist_011/view/displaybox/widgets/selectbox.dart';
import 'package:todolist_011/view/displaybox/widgets/tasks.dart';

class Displaybox extends StatefulWidget {
  final Task task;
  final int index;

  const Displaybox({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  @override
  _DisplayboxState createState() => _DisplayboxState();
}

class _DisplayboxState extends State<Displaybox> {
  bool isChecked = false; // State for the checkbox

  void _handleDelete() {
    // Dispatch BLoC event for task deletion
    context.read<TodoBloc>().add(DeleteEvent(widget.index));
    Utils.showSnackbar(context, 'Task deleted');
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  }

  void _navigateToTaskDetails() {
    // Navigate to TaskDetailsPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsPage(mainTask: widget.task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToTaskDetails,
      child: Container(
        width: double.infinity,
        height: 100,
        child: Card(
          elevation: 4,
          color: isChecked ? Colors.green : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: ListTile(
              leading: SelectBox(
                isChecked: isChecked,
                onChanged: _toggleCheckbox,
              ),
              title: DisplayTasks(
                taskName: widget.task.title,
                taskDescription: widget.task.description,
              ),
              trailing: Deletebox(onDelete: _handleDelete),
            ),
          ),
        ),
      ),
    );
  }
}
