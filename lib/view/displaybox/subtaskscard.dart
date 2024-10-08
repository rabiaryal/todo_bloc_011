import 'package:flutter/material.dart';
import 'package:todolist_011/view/displaybox/widgets/deletebox.dart';
import 'package:todolist_011/view/displaybox/widgets/selectbox.dart';
import 'package:todolist_011/view/displaybox/widgets/tasks.dart';


class SubTaskCard extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final bool isChecked;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback onDelete;

  const SubTaskCard({
    Key? key,
    required this.taskName,
    required this.taskDescription,
    required this.isChecked,
    required this.onCheckboxChanged,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: isChecked ? Colors.green : Colors.white,
      child: ListTile(
        leading: SelectBox(
          isChecked: isChecked,
          onChanged: onCheckboxChanged,
        ),
        title: DisplayTasks(
          taskName: taskName,
          taskDescription: taskDescription,
        ),
        trailing: Deletebox(onDelete: onDelete),
      ),
    );
  }
}
